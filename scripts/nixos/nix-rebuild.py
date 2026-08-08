#!/usr/bin/env python3

# ==============================================================================
# - By NCM_Cybersec
# - Nixos-rebuild switch test script
#
# - A python script that runs nixos-rebuild dry-build, dry-activate, and switch 
#   in sequence to validate and apply system configuration changes.
# - Usage:
#   $ nix-rebuild
# 
# - This will run the dry-build, dry-activate, and switch commands in order. 
#   If any of the commands fail, the script will abort and display the error message.
# ==============================================================================

import subprocess
import sys
import re

def run_command(cmd, capture=True):
    """Run a shell command and return exit code, stdout, and stderr."""
    try:
        result = subprocess.run(
            cmd,
            stdout=subprocess.PIPE if capture else None,
            stderr=subprocess.PIPE if capture else None,
            text=True,
            check=False
        )
        return result.returncode, result.stdout, result.stderr
    except Exception as e:
        return 1, "", str(e)

def parse_nix_errors(stderr_output):
    """Extract readable error messages from Nix build output."""
    error_lines = []
    # Capture common nix build error formats and tracebacks
    patterns = [
        r"error:.*",
        r"Failed assertions:.*",
        r"at .*\.nix:\d+:\d+",
    ]
    
    for line in stderr_output.splitlines():
        if any(re.search(pattern, line, re.IGNORECASE) for pattern in ["error:", "failed", "traceback:"]):
            error_lines.append(line.strip())
            
    if not error_lines and stderr_output.strip():
        # Fallback if no specific pattern matched but stderr is populated
        return [line.strip() for line in stderr_output.splitlines() if line.strip()]
        
    return error_lines

def main():
    if subprocess.run(["id", "-u"], capture_output=True, text=True).stdout.strip() != "0":
        print("[-] Warning: This script typically requires root privileges to run nixos-rebuild.")

    steps = [
        ("Dry Build", ["sudo", "nixos-rebuild", "dry-build"]),
        ("Dry Activate", ["sudo", "nixos-rebuild", "dry-activate"]),
        ("Switch Configuration", ["sudo", "nixos-rebuild", "switch"])
    ]

    # Validation (Dry-run checks)
    for name, cmd in steps[:2]:
        print(f"[*] Running {name}...")
        code, stdout, stderr = run_command(cmd)
        
        if code != 0:
            print(f"\n[!] Error detected during: {name}")
            print("-" * 50)
            parsed_errors = parse_nix_errors(stderr + "\n" + stdout)
            if parsed_errors:
                for err in parsed_errors:
                    print(f"  -> {err}")
            else:
                print(stderr.strip())
            print("-" * 50)
            print("[X] Rebuild validation failed. Aborting before switch.")
            sys.exit(1)
        else:
            print(f"[+] {name} passed successfully.")

    # Execution (Switch)
    print("\n[+] All validation checks passed. Creating new system generation...")
    switch_code, switch_out, switch_err = run_command(steps[2][1], capture=False)

    if switch_code != 0:
        print(f"\n[!] Switch command failed with exit code {switch_code}.")
        sys.exit(switch_code)
    else:
        print("\n[SUCCESS] Nixos-rebuild switch completed successfully!")

if __name__ == "__main__":
    main()