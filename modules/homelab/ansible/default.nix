# ==========================================================================
# Homelab - Ansible
# ==========================================================================

{
  pkgs,
  ...  
}:

{
  
  imports = [
    ./proxmox
  ];
  
  environment.systemPackages = with pkgs;[
    ansible
    ansible-builder
    ansible-doctor
    ansible-language-server
    ansible-lint
    ansible-navigator
    molecule
    scap-security-guide
  ];
  

  # Systemd timers to trigger & automate Ansible playbooks
  systemd.timers = {
    proxmox-cluster-update = {
      description = "Trigger Proxmox rolling update on the 1st of every month";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-01 03:00:00";
        Persistent = true;
        Unit = "proxmox-cluster-update.service";
      };
    };
  };
}