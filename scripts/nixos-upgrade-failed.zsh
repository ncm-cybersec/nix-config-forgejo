#!/usr/bin/env zsh

# ==========================================================================
# NixOS Auto-Upgrade Failure - Notify-Send 
# By N1x_Cybersec
#
# - ZSH script to create a Desktop Notification on auto-upgrade failure, based
#   on HOSTNAME variable passed from systemd service.
# - Script is defined system-wide in /modules/system/packages/scripts using 
#   pkgs.writeShellScriptBin.
# ==========================================================================

# systemd passes the hostname via %i as the first argument
HOSTNAME="${1:-unknown-host}"

# Target user 1000 visual environment
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
export XDG_RUNTIME_DIR="/run/user/1000"

# Fetch the last 5 lines of the upgrade service log
ERROR_LOGS=$(journalctl -u nixos-upgrade.service -n 5 --no-hostname --no-pager | sed 's/^/• /')

if [[ -z "$ERROR_LOGS" ]]; then
  ERROR_LOGS="Could not retrieve logs automatically. Check 'journalctl -u nixos-upgrade.service'."
fi

NOTIF_BODY="The automated upgrade on ${HOSTNAME} failed. 

<b>Recent Log Tail:</b>
${ERROR_LOGS}"

# Drop privileges down to your user to execute the notify-send handshake safely
sudo -u $(id -nu 1000) notify-send \
  --urgency=critical \
  --icon=preferences-system-updates \
  --app-name="System Upgrade" \
  --expire-time=0 \
  "NixOS Upgrade Failed" \
  "${NOTIF_BODY}"
