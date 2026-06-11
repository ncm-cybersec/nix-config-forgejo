# ==========================================================================
# Proton Pass CLI/SSH Manager Configuration
# ==========================================================================

{ 
  pkgs, 
  pkgsUnstable,
  ... 
}: 

{
  
  # Enable Proton Pass Agent - Used for SSH key management 
  services.proton-pass-agent = {
    enable = true;
    package = pkgsUnstable.proton-pass-cli;
    socket = "proton-pass-agent";
    extraArgs = [
      "--share-id"
      "--vault-name"
      "SshKeyVault"
      "--refresh-interval"
      "7200"
      "--create-new-identities"
      "SshKeyVault"
    ];
  };

  # Proton Pass Agent Systemd Service - Unit File
  systemd.user.services.proton-pass-ssh-agent = {
    Unit = {
      Description = "Proton Pass SSH Agent";
    };
    Service = {
      ExecStart = "${pkgsUnstable.proton-pass-cli}/bin/pass-cli ssh-agent start --socket-path %h/.ssh/proton-pass-agent.sock";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };

}