#!/usr/bin/env python3

# ==============================================================================
# - By NCM_Cybersecurity
# - Plasma-Manager Synchronization Tool: plasma-sync.py
#
# - A pure-Python utility to replace 'rc2nix'. Capture live KDE Plasma configurations, 
#   map high-level options matching plasma-manager, filter out volatile state, and emit 
#   a cleanly formatted Nix module.
# - After installing plasma-manager flake, create or add a "scripts" folder to
#   your nix-config directory and add this script to it. In your configuration.nix 
#   file (or dedicated scripts module), add the following to make the script 
#   available:
#   
#   environment.systemPackages = with pkgs; [
#     Other packages...
#     
#     (writers.writePython3Bin "plasma-sync" { libraries = [ ]; } 
#      (builtins.readFile ./scripts/plasma-sync.py))
#   ];
#
# - After rebuilding your system, simply type "plasma-sync diff --update" to 
#   capture any changes.
# ==============================================================================

import os
import sys
import json
import re
import argparse
import subprocess
import glob
from pathlib import Path

# ==============================================================================
# Configuration & Definitions
# ==============================================================================

# Standard config files managed by rc2nix
KNOWN_FILES = [
    "baloofilerc", "dolphinrc", "kactivitymanagerdrc", "katerc",
    "kcminputrc", "kded5rc", "kdeglobals", "kglobalshortcutsrc",
    "kiorc", "klipperrc", "kscreenlockerrc", "kservicemenurc",
    "ktrashrc", "kwalletrc", "kwinrc", "kwinrulesrc", "plasma-localerc",
    "plasmanotifyrc", "plasmarc", "spectaclerc"
]

# Additional config files missed by rc2nix
EXTRA_FILES = ["powerdevilrc", "konsolerc"]
ALL_FILES = KNOWN_FILES + EXTRA_FILES

# Groups containing runtime state or volatile data
VOLATILE_GROUPS = [
    "desktop entry", "recent urls", "recent files", "state", "geometry", "windowproperties"
]

# High-level mappings from INI structure to typed plasma-manager options
# Format: (file, group, key, path_in_nix, transform_func)
MAPPINGS = [
    ("katerc", "KTextEditor Renderer", "Color Theme", "programs.kate.editor.theme.name", lambda v: v),
    ("katerc", "KTextEditor Renderer", "Text Font", "programs.kate.editor.font.family", lambda v: v.split(",")[0] if "," in v else v),
    ("katerc", "KTextEditor Renderer", "Text Font", "programs.kate.editor.font.pointSize", lambda v: int(v.split(",")[1]) if "," in v else 10),
    ("kdeglobals", "Icons", "Theme", "programs.plasma.workspace.iconTheme", lambda v: v),
    ("plasmarc", "Theme", "name", "programs.plasma.workspace.theme", lambda v: v),
    ("kcminputrc", "Mouse", "cursorTheme", "programs.plasma.workspace.cursor.theme", lambda v: v),
    ("kwinrc", "Plugins", "blurEnabled", "programs.plasma.kwin.effects.blur.enable", lambda v: v.lower() == "true"),
    ("kwinrc", "Plugins", "wobblywindowsEnabled", "programs.plasma.kwin.effects.wobblyWindows.enable", lambda v: v.lower() == "true"),
    ("kscreenlockerrc", "Daemon", "Autolock", "programs.plasma.kscreenlocker.autoLock", lambda v: v.lower() == "true"),
    ("kscreenlockerrc", "Daemon", "Timeout", "programs.plasma.kscreenlocker.timeout", lambda v: int(v)),
    ("powerdevilrc", "AC/SuspendAndShutdown", "AutoSuspendAction", "programs.plasma.powerdevil.AC.autoSuspend.action", lambda v: "nothing" if v == "0" else v),
    ("powerdevilrc", "AC/SuspendAndShutdown", "AutoSuspendIdleTimeoutSec", "programs.plasma.powerdevil.AC.autoSuspend.idleTimeout", lambda v: int(v)),
    ("powerdevilrc", "AC/Display", "TurnOffDisplayWhenIdle", "programs.plasma.powerdevil.AC.turnOffDisplay.idleTimeout", lambda v: "never" if v.lower() == "false" else v),
    ("konsolerc", "Desktop Entry", "DefaultProfile", "programs.konsole.defaultProfile", lambda v: v),
    ("konsolerc", "MainWindow", "MenuBar", "programs.konsole.extraConfig.MainWindow.MenuBar", lambda v: v),
]

# Comments to inject into the generated Nix output for readability
NIX_COMMENTS = {
    "programs.kate": "Kate Editor",
    "programs.konsole": "Konsole Terminal",
    "programs.plasma.workspace": "Workspace Theming",
    "programs.plasma.kwin": "KWin Window Manager",
    "programs.plasma.kscreenlocker": "Screen Locker",
    "programs.plasma.powerdevil": "Power Management",
    "programs.plasma.shortcuts": "Global Shortcuts",
    "programs.plasma.shortcuts.ActivityManager": "Activity Manager",
    "programs.plasma.shortcuts.KDE Keyboard Layout Switcher": "Keyboard Layout",
    "programs.plasma.shortcuts.kaccess": "Accessibility",
    "programs.plasma.shortcuts.kmix": "Audio Volume",
    "programs.plasma.shortcuts.ksmserver": "Session Management",
    "programs.plasma.shortcuts.kwin": "Window/Desktop Management",
    "programs.plasma.shortcuts.org_kde_powerdevil": "Power Actions",
    "programs.plasma.shortcuts.plasmashell": "Plasma Shell",
    "programs.plasma.shortcuts.plasmazonesd": "PlasmaZones Window Tiling",
    "programs.plasma.configFile": "Raw Configuration Files (configFile)",
}

# ==============================================================================
# Helper Functions
# ==============================================================================

def is_volatile(group, key):
    # Determine if group/key pair represents volatile state that should be ignored
    group_lower = group.lower()
    key_lower = key.lower()

    if group_lower in VOLATILE_GROUPS:
        return True
    if "timestamp" in key_lower:
        return True
    if key_lower in ["seen", "version", "dbversion"]:
        return True
    return False

def cast_value(v):
    # Cast string value to boolean, int, or float if appropriate
    v_lower = v.lower()
    if v_lower == "true":
        return True
    if v_lower == "false":
        return False

    # Try integer cast
    if v.isdigit() or (v.startswith('-') and v[1:].isdigit()):
        if str(int(v)) == v:
            return int(v)

    # Try float cast, excluding strings like '1920x1080'
    try:
        f = float(v)
        if '.' in v and 'x' not in v:
            return f
    except ValueError:
        pass

    return v

def parse_shortcut_value(v):
    # Parse comma/tab separated shortcut strings into Nix lists
    parts = v.split(',')
    if not parts:
        return []
    shortcuts = parts[0].split('\\t')
    shortcuts = [s for s in shortcuts if s and s.lower() != "none"]
    if not shortcuts:
        return []
    if len(shortcuts) == 1:
        return shortcuts[0]
    return shortcuts

def deep_set(d, path_str, value):
    # Set a value in a nested dictionary using dot-separated path
    keys = path_str.split('.')
    current = d
    for k in keys[:-1]:
        if k not in current:
            current[k] = {}
        current = current[k]
    current[keys[-1]] = value

# ==============================================================================
# Parser Logic
# ==============================================================================

def parse_rc_file(path):
    # Parse KDE RC INI file into a nested dictionary, handling [Group][Subgroup]
    if not os.path.exists(path):
        return {}

    result = {}
    current_group = ""

    with open(path, "r", encoding="utf-8", errors="replace") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"): 
                continue

            if line.startswith("[") and line.endswith("]"):
                groups = re.findall(r'\[([^\]]+)\]', line)
                if groups:
                    current_group = "/".join(groups)
                else:
                    current_group = line[1:-1]
                continue

            if "=" in line:
                key, val = line.split("=", 1)
                key = key.strip()
                val = val.strip()

                # Strip KDE type markers (e.g. [$e], [$i])
                key = re.sub(r'\[\$[a-zA-Z]\]$', '', key)

                if current_group not in result:
                    result[current_group] = {}
                result[current_group][key] = val

    return result

def load_konsole_profiles(config_dir="~/.local/share/konsole"):
    # Load dynamically available Konsole profiles and color schemes
    konsole_dir = os.path.expanduser(config_dir)
    schemes = {}
    profiles = {}

    if not os.path.isdir(konsole_dir):
        return schemes, profiles

    # Read color schemes
    for cs in glob.glob(os.path.join(konsole_dir, "*.colorscheme")):
        name = os.path.splitext(os.path.basename(cs))[0]
        schemes[name] = cs
        
    # Read profiles
    for prof in glob.glob(os.path.join(konsole_dir, "*.profile")):
        name = os.path.splitext(os.path.basename(prof))[0]
        parsed = parse_rc_file(prof)
        profile_data = {}
        extra_config = {}

        for group, keys in parsed.items():
            for k, v in keys.items():
                if group == "General" and k == "Name":
                    profile_data["name"] = v
                elif group == "General" and k == "Command":
                    profile_data["command"] = v
                elif group == "Appearance" and k == "ColorScheme":
                    profile_data["colorScheme"] = v
                else:
                    if group not in extra_config:
                        extra_config[group] = {}
                    extra_config[group][k] = cast_value(v)

        if extra_config:
            profile_data["extraConfig"] = extra_config

        profiles[name] = profile_data

    return schemes, profiles

def get_live_state(config_dir="~/.config"):
    # Read all KNOWN_FILES + EXTRA_FILES from config directory
    config_dir = os.path.expanduser(config_dir)
    state = {}
    for fname in ALL_FILES:
        path = os.path.join(config_dir, fname)
        parsed = parse_rc_file(path)
        if parsed:
            state[fname] = parsed
    return state

# ==============================================================================
# Output Formatting
# ==============================================================================

def build_nix_struct(state):
    # Transform raw configuration state into high-level Nix module structure
    struct = {
        "programs": {
            "plasma": {
                "enable": False,
                "shortcuts": {},
                "configFile": {}
            },
            "kate": {"enable": True},
            "konsole": {"enable": True}
        }
    }

    # Load dynamic Konsole profiles
    schemes, profiles = load_konsole_profiles()
    if schemes:
        struct["programs"]["konsole"]["customColorSchemes"] = schemes
    if profiles:
        struct["programs"]["konsole"]["profiles"] = profiles

    for fname, groups in state.items():
        for group, keys in groups.items():
            for key, val in keys.items():

                # Apply high-level mapped keys
                mapped = False
                for m_file, m_group, m_key, m_path, m_transform in MAPPINGS:
                    if fname == m_file and group == m_group and key == m_key:
                        deep_set(struct, m_path, m_transform(val))
                        mapped = True
                        break

                if mapped:
                    continue

                # Skip volatile variables
                if is_volatile(group, key):
                    continue

                # Handle shortcuts uniquely
                if fname == "kglobalshortcutsrc":
                    shortcut_val = parse_shortcut_value(val)
                    if group not in struct["programs"]["plasma"]["shortcuts"]:
                        struct["programs"]["plasma"]["shortcuts"][group] = {}
                    struct["programs"]["plasma"]["shortcuts"][group][key] = shortcut_val
                    continue

                # Drop remaining config keys into configFile block
                val_cast = cast_value(val)
                cf = struct["programs"]["plasma"]["configFile"]
                if fname not in cf:
                    cf[fname] = {}
                if group not in cf[fname]:
                    cf[fname][group] = {}
                cf[fname][group][key] = val_cast

    return struct

def to_nix(obj, indent=0, path=""):
    # Convert a Python dictionary to a formatted Nix expression
    ind = "  " * indent

    if isinstance(obj, bool):
        return "true" if obj else "false"

    elif isinstance(obj, (int, float)):
        return str(obj)

    elif isinstance(obj, str):
        # Interpret local path files dynamically
        if obj.startswith("/home/") and obj.endswith(".colorscheme"):
            if " " in obj:
                return f'/. + "{obj}"'
            return obj
        escaped = obj.replace('\\', '\\\\').replace('"', '\\"')
        return f'"{escaped}"'

    elif isinstance(obj, list):
        if not obj:
            return "[ ]"
        items = " ".join(to_nix(x) for x in obj)
        return f"[{items}]"

    elif isinstance(obj, dict):
        if not obj:
            return "{ }"
        lines = ["{"]

        # Sort items: ensure "enable" is always first in the block, otherwise alphabetical
        sorted_items = sorted(obj.items(), key=lambda x: (0 if x[0] == "enable" else 1, x[0]))

        for k, v in sorted_items:
            current_path = f"{path}.{k}" if path else k

            # Inject structural comments if matching the predefined path
            if current_path in NIX_COMMENTS:
                lines.append(ind + "  # --- " + NIX_COMMENTS[current_path] + " ---")

            safe_k = k if re.match(r'^[a-zA-Z_][a-zA-Z0-9_-]*$', k) else f'"{k}"'
            lines.append(ind + "  " + f"{safe_k} = {to_nix(v, indent + 1, current_path)};")

        lines.append(ind + "}")
        return "\n".join(lines)

    return '""'

# ==============================================================================
# CLI Commands
# ==============================================================================

def get_host():
    # Retrieve system hostname
    return subprocess.run(["hostname"], capture_output=True, text=True).stdout.strip()

# Single host version, remove get_out_dir(), replace cmd_convert()
# def cmd_convert(args):
    # Capture configuration, map to Nix, and write output
    # state = get_live_state()
    # struct = build_nix_struct(state)
    # out_nix = "{\n  config,\n  pkgs,\n  ...\n}:\n\n" + to_nix(struct, 0) + "\n"

    # out_file = args.out
    # if not out_file:
    #    out_file = f"modules/user/packages/kde/plasma-{get_host()}.nix"

    # os.makedirs(os.path.dirname(out_file) or ".", exist_ok=True)
    # with open(out_file, "w") as f:
    #    f.write(out_nix)
    # print(f"Wrote optimized configuration to {out_file}")

def get_out_dir(host):
    # Determine the output directory based on the host
    if host == "nixadmin":
        return "modules/user/plasmamanager/desktop"
    elif host == "nixpgadmin":
        return "modules/user/plasmamanager/laptop"
    return f"modules/user/plasmamanager/{host}"

def cmd_convert(args):
    # Capture configuration, map to Nix, and write output
    state = get_live_state()
    struct = build_nix_struct(state)
    out_nix = "{\n  config,\n  pkgs,\n  ...\n}:\n\n" + to_nix(struct, 0) + "\n"

    out_file = args.out
    if not out_file:
        host = get_host()
        out_file = f"{get_out_dir(host)}/default.nix"

    os.makedirs(os.path.dirname(out_file) or ".", exist_ok=True)
    with open(out_file, "w") as f:
        f.write(out_nix)
    print(f"Wrote optimized configuration to {out_file}")

def diff_dict(d1, d2, path=""):
    # Recursively diff two dictionaries to identify configuration drift
    diffs = []
    keys1 = set(d1.keys()) if isinstance(d1, dict) else set()
    keys2 = set(d2.keys()) if isinstance(d2, dict) else set()

    for k in keys1 - keys2:
        diffs.append(("REMOVED", f"{path}.{k}".strip('.'), d1[k], None))
    for k in keys2 - keys1:
        diffs.append(("ADDED", f"{path}.{k}".strip('.'), None, d2[k]))
    for k in keys1 & keys2:
        if isinstance(d1[k], dict) and isinstance(d2[k], dict):
            diffs.extend(diff_dict(d1[k], d2[k], f"{path}.{k}"))
        elif d1[k] != d2[k]:
            diffs.append(("CHANGED", f"{path}.{k}".strip('.'), d1[k], d2[k]))

    return diffs

# If you only have one host, replace baseline_file with the following (modify the path accordingly):
#   baseline_file = f"modules/user/packages/kde/plasma-{host}.baseline.json"

def cmd_diff(args):
    # Compare live KDE configuration against a recorded JSON baseline snapshot
    host = get_host()
    baseline_file = f"{get_out_dir(host)}/plasma-{host}.baseline.json"

    raw_state = get_live_state()
    state = {}

    # Remove volatile items from the comparison state
    for fname, groups in raw_state.items():
        state[fname] = {}
        for group, keys in groups.items():
            state[fname][group] = {}
            for key, val in keys.items():
                if not is_volatile(group, key):
                    state[fname][group][key] = val
            if not state[fname][group]:
                del state[fname][group]
        if not state[fname]:
            del state[fname]

    if args.update or not os.path.exists(baseline_file):
        os.makedirs(os.path.dirname(baseline_file) or ".", exist_ok=True)
        with open(baseline_file, "w") as f:
            json.dump(state, f, indent=2)
        print(f"Updated baseline at {baseline_file}")

        if args.update:
            cmd_convert(argparse.Namespace(out=None))
            print("Run 'git diff' to review the changes.")
        return 0

    with open(baseline_file, "r") as f:
        baseline = json.load(f)

    diffs = diff_dict(baseline, state)
    if not diffs:
        print("No configuration drift detected.")
        return 0

    print(f"Configuration drift detected against baseline for host {host}:")
    for t, p, v1, v2 in diffs:
        if t == "ADDED":
            print(f"  + {p} = {v2}")
        elif t == "REMOVED":
            print(f"  - {p} (was {v1})")
        elif t == "CHANGED":
            print(f"  ~ {p} : {v1} -> {v2}")

    return 1

def main():
    parser = argparse.ArgumentParser(description="Plasma Manager config synchronization tool")
    subparsers = parser.add_subparsers(dest="command", required=True)

    p_convert = subparsers.add_parser("convert", help="Convert live KDE config to Nix module")
    p_convert.add_argument("--out", help="Output Nix file path")

    p_diff = subparsers.add_parser("diff", help="Diff live KDE config against baseline")
    p_diff.add_argument("--update", action="store_true", help="Update the baseline snapshot and regenerate Nix module")

    args = parser.parse_args()
    if args.command == "convert":
        cmd_convert(args)
    elif args.command == "diff":
        sys.exit(cmd_diff(args))

if __name__ == "__main__":
    main()
    
