# ==========================================================================
# Home Manager - zsh configuration
# ==========================================================================

{ 
  pkgs,
  ... 
}:

{

  # Enable ZSH w/ completions & extensions
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      
      initContent = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"

        export SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-agent.sock"

        autoload -Uz compinit && compinit
        
        setopt null_glob

        eval "$(starship init zsh)"

        fastfetch
      '';    
    };

    # Zsh extensions
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    
    fastfetch = {
      enable = true;
      # Thank you borko17 for the fastfetch config! https://github.com/borko17/fastfetch-config.git
      settings = builtins.fromJSON (builtins.readFile ./fastfetch1.jsonc);
    };
    
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };
    
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };  
}