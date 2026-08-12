# ==========================================================================
# Ansible - Proxmox 3-Node Cluster Updates
# ==========================================================================

{
  config,
  pkgs,
  ...  
}:

{
    
  # Systemd service for Proxmox cluster updates
  systemd.services = {
    proxmox-cluster-update = {
      description = "Automated updates for 3-node proxmox cluster";
      after = [ "network-online.target" "sops-nix.service" ];
      wants = [ "network-online.target" ];
      
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
      
      path = with pkgs; [ ansible openssh bash coreutils ];
      
      script = ''
      #!/usr/bin/env bash
      set -e

      # Resolve live paths dynamically from decrypted sops keys
      PVE1_IP=$(cat ${config.sops.secrets.pve1_ip.path})
      PVE2_IP=$(cat ${config.sops.secrets.pve2_ip.path})
      PVE3_IP=$(cat ${config.sops.secrets.pve3_ip.path})

      # Create a temporary, secure runtime directory for the host file
      RUN_DIR="/run/proxmox-ansible"
      mkdir -p "$RUN_DIR"
      chmod 700 "$RUN_DIR"
      INVENTORY="$RUN_DIR/hosts.ini"

      # Generate the dynamic hosts structure cleanly on demand
      cat << "EOF" > "$INVENTORY"

        [proxmox_nodes]
        pve01 ansible_host=$PVE1_IP
        pve02 ansible_host=$PVE2_IP
        pve03 ansible_host=$PVE3_IP

      [proxmox_nodes:vars]
      ansible_user=root
      ansible_ssh_private_key_file=/home/nixadmin/.ssh/id_ed25519
      EOF

      echo "Executing rolling cluster patch using playbook repository..."
      
      # Run the upgrade playbook directly from nix-config homelab modules directory
      ansible-playbook -i "$INVENTORY" /home/nixadmin/nix-config/modules/homelab/ansible/pve-maintenance.yml

      # Clean up the runtime inventory file afterward
      rm -rf "$RUN_DIR"
    '';
    };
  };
}
