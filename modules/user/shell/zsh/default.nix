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
      
      plugins = [
        {
          name = "zsh-autocomplete";
          src = "${pkgs.zsh-autocomplete}/share/zsh-autocomplete"; 
        }
      ];
           
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
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"

        export SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-agent.sock"
        
        setopt null_glob

        eval "$(starship init zsh)"

        fastfetch
        
        # -------------------------------------------------------------------------
        # ZSH > AIChat: Natural Language Processing
        # -------------------------------------------------------------------------
        ai-buffer() {
          [[ -z "$BUFFER" ]] && return

          # Clear visual artifacts and notify user
          echo -e "\n\e[1;34m [Agentic Router] Translating to executable shell syntax... \e[0m"

          local prompt="Convert this natural language instruction into a precise, executable Zsh/NixOS/Linux command. Return ONLY the raw shell command, with no explanations, no markdown formatting, and no code blocks: $BUFFER"
      
          # Force execution output string format bypassing interactive TTY allocation
          local ai_command=$(aichat --execute "$prompt" 2>/dev/null)

          # Strip any residual newlines or markdown artifacts the model emitted
          ai_command=$(echo "$ai_command" | tr -d '\n\r`')

          # Replace string inline
          BUFFER="$ai_command"
          CURSOR=$#BUFFER
      
          # Forces visual refresh of line structure
          zle reset-prompt
        }
        zle -N ai-buffer
        bindkey '^ ' ai-buffer

        # -------------------------------------------------------------------------
        # ZSH > AIChat: Prefix-Triggered Natural Language Execution
        # -------------------------------------------------------------------------
        ai-intercept-executor() {
          if [[ -z "$BUFFER" ]]; then
            zle .accept-line
            return
          fi

          # Check if the line starts with '?'
          if [[ "$BUFFER" == \?* ]]; then
            echo -e "\n\e[1;33m [Natural Language Intercept] -> Hitting Local Qwen Stack \e[0m"
            
            # Strip the '?' prefix and any leading whitespace
            local query="''${BUFFER#\?}"
            query="''${query## }"
            
            # Pass the raw text block directly down to aichat
            aichat "$query"
            
            # Clear the prompt after the chat finishes
            BUFFER=""
            zle reset-prompt
          else
            # Standard shell command
            zle .accept-line
          fi
        }
        zle -N ai-intercept-executor
        bindkey '^M' ai-intercept-executor
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