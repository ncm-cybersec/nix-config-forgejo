# ==========================================================================
# Home Manager - zsh configuration
# ==========================================================================

{ 
  pkgs, 
  ... 
}:

{
  
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    starship
    zsh-forgit
  ];

  # Enable ZSH w/ completions & extensions
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
                 
      oh-my-zsh = {
        enable = true;
        package = pkgs.oh-my-zsh;
        custom = "/home/nixadmin/.zsh/oh-my-zsh/custom";
        plugins = [
          "branch"
          "git"
          "git-commit"
          "ssh-agent"
          "ssh"
          "starship"
          "systemd"
          "tailscale"
        ];
      };
      
      initContent = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/.npm-global/bin"

        export SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-agent.sock"
        
        setopt null_glob

        eval "$(starship init zsh)"
              
        fastfetch
        
        if command -v inshellisense &> /dev/null; then
          eval "$(inshellisense init zsh)"
        fi
      '';    
    };

    # Zsh extensions
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    
    fastfetch = {
      enable = true;
      # https://github.com/borko17/fastfetch-config.git
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