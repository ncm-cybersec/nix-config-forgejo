# ==========================================================================
# Ansible - Proxmox 3-Node Cluster Updates
# ==========================================================================

{
  config,
  pkgs,
  ...  
}:

{
  
  # Proxmox cluster sops secrets
  sops = {
    defaultSopsFile = ../../../secrets/pve/pve.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      pve1_ip = {};
      pve1_password = {};
      
      pve2_ip = {};
      pve2_password = {};
      
      pve3_ip = {};
      pve3_password = {};
    };
  };
  
  # Push nixadmin SSH keys to all homelab devices on boot
  system.activationScripts.pushSshKeys = {
    text = ''
      #!${pkgs.bash}/bin/bash
      
      # Inject core utilities into path execution environment
      export PATH="${pkgs.coreutils}/bin:${pkgs.gnused}/bin:${pkgs.gnugrep}/bin:${pkgs.openssh}/bin:${pkgs.sshpass}/bin:\$PATH"

      KEY_PATH="/home/nixadmin/.ssh/id_ed25519"
      KNOWN_HOSTS_FILE="/home/nixadmin/.ssh/known_hosts"

      mkdir -p "/home/nixadmin/.ssh"
      touch "\$KNOWN_HOSTS_FILE"

      # Safety Check: Exit cleanly if sops files are not loaded yet by systemd
      if [ ! -f "${config.sops.secrets.pve1_ip.path}" ]; then
        echo "Sops secrets not populated yet. Skipping execution loop."
        exit 0
      fi

      if [ -f "\$KEY_PATH" ]; then
        # Resolve secrets dynamically at compilation time from sops targets
        PVE1_IP="\$(cat ${config.sops.secrets.pve1_ip.path})"
        PVE1_PW="\$(cat ${config.sops.secrets.pve1_password.path})"
        
        PVE2_IP="\$(cat ${config.sops.secrets.pve2_ip.path})"
        PVE2_PW="\$(cat ${config.sops.secrets.pve2_password.path})"
        
        PVE3_IP="\$(cat ${config.sops.secrets.pve3_ip.path})"
        PVE3_PW="\$(cat ${config.sops.secrets.pve3_password.path})"

        # Stream loop: Feeds pairs of IPs and Passwords cleanly
        while read -r NODE PASSWORD; do
          if [ -z "\$NODE" ]; then continue; fi

          # Dynamically capture host signature keys
          ssh-keyscan -H "\$NODE" >> "\$KNOWN_HOSTS_FILE" 2>/dev/null

          # Validate connection capability
          if ssh -i "\$KEY_PATH" -o ConnectTimeout=3 -o PasswordAuthentication=no -o StrictHostKeyChecking=no root@\$NODE "echo 'ready'" &>/dev/null; then
            echo "SSH Public Key already active on Proxmox Node (\$NODE). Skipping deployment."
          else
            echo "Key not detected on \$NODE. Attempting automatic push..."
            sshpass -p "\$PASSWORD" \
              ssh-copy-id -o StrictHostKeyChecking=no -i "\$KEY_PATH" root@\$NODE
          fi
        done
        
        if [ -f "$KNOWN_HOSTS_FILE" ]; then
          sort -u "$KNOWN_HOSTS_FILE" -o "$KNOWN_HOSTS_FILE"
        fi
      fi
    '';
  };
}