# ==========================================================================
# System Scripts
# ==========================================================================

{ 
  pkgs,
  self,
  ... 
}: 

{
  environment.systemPackages = [ 
    
    # ZSH script to help automate git stage and commit
    (pkgs.writeShellScriptBin "git-stage-commit" (builtins.readFile "${self}/scripts/git-stage-commit.zsh"))
    
    # ZSH script to download the latest warp Appimage, update via gearlever cli and clean up
    (pkgs.writeShellScriptBin "update-warp" (builtins.readFile "${self}/scripts/update-warp.zsh"))

    # ZSH script to download the latest Netcatty Appimage, update to latest version, update desktop file, and clean up
    (pkgs.writeShellScriptBin "update-netcatty" (builtins.readFile "${self}/scripts/update-netcatty.zsh"))

    # Python script to replace plasma-manager rc2nix for initial plasma config generation, and to continuously capture changes to plasma settings
    (pkgs.writers.writePython3Bin "plasma-sync" { libraries = [ ]; flakeIgnore = [ "E265" "E302" "E305" "E501" "F401" "W291" "W292" "W293" ]; } (builtins.readFile "${self}/scripts/plasma-sync.py"))

  ];
}