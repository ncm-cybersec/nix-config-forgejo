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

  ];
}