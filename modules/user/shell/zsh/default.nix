# ==========================================================================
# Home Manager - zsh configuration
# ==========================================================================

{ 
  pkgs, 
  pkgsUnstable,
  ... 
}:

{

  # Enable ZSH w/ completions & extensions
  programs = {
    zsh = {
      enable = true;
      enableBashCompletion = true;
      enableCompletion = true;
      enableLsColors = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      plugins = [
        {
          name = "fabric-completions";
          src = "${pkgs.pkgsUnstable.fabric-ai}/share/zsh/site-functions"; 
          file = "_fabric"; 
        }
      ];
      
      ohMyZsh = {
        enable = true;
        plugins = [
          "branch"
          "git"
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
        # ZSH Completion System w/ IDE Dropdown Menu 
        # -------------------------------------------------------------------------
        autoload -Uz compinit
        compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
        zmodload zsh/complist

        # Apply styled drop-down selection parameters
        zstyle ':completion:*' menu select=1
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' group-name ""
        zstyle ':completion:*' format $'\e[1;35m🐈‍⬛ %d\e[0m'
        zstyle ':completion:*' descriptions true
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
        zstyle ':completion:*' squeeze-slashes true

        # Arrow keys to navigate like an IDE dropdown menu
        bindkey -M menuselect '^M' .accept-line
        bindkey -M menuselect 'h' backward-char
        bindkey -M menuselect 'k' up-line-or-history
        bindkey -M menuselect 'j' down-line-or-history
        bindkey -M menuselect 'l' forward-char

        # Gracefully prevent empty globs from halting shell profiles
        setopt null_glob

        # -------------------------------------------------------------------------
        # ZSH > AIChat: Natural Language Processing
        # -------------------------------------------------------------------------
        ai-buffer() {
          [[ -z "$BUFFER" ]] && return

          # Clear visual artifacts and notify user using theme colors
          echo -e "\n\e[1;34m 👁️ [Agentic Router] Translating to executable shell syntax... \e[0m"

          local prompt="Convert this natural language instruction into a precise, executable Zsh/NixOS/Linux command. Return ONLY the raw shell command, with no explanations, no markdown formatting, and no code blocks: $BUFFER"
      
          # FIX: Force execution output string format bypassing interactive TTY allocation
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
        # ZSH > AIChat: Natural Language Auto-Intercept Executor Stream Execution
        # -------------------------------------------------------------------------
        ai-intercept-executor() {
          if [[ -z "$BUFFER" ]]; then
            zle .accept-line
            return
          fi

          local first_word=''${BUFFER%% *}

          # Skip if first token matches an actual script, file path, path string, or registered function
      if whence "$first_word" >/dev/null 2>&1 || [[ "$BUFFER" =~ ^[./] ]]; then
        zle .accept-line
        return
      fi

      local safety_prompt="Is the following text a conversational question or a natural language statement? Answer with exactly 'YES' or 'NO': $BUFFER"
      local is_natural=$(aichat --execute "$safety_prompt" 2>/dev/null | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')

      if [[ "$is_natural" == *"YES"* ]]; then
        echo -e "\n\e[1;33m 🐈‍⬛ [Natural Language Intercept] -> Hitting Local Qwen Stack \e[0m"
        
        # Passes text block safely down to active aichat instances
        aichat "$BUFFER"
        
        BUFFER=""
        zle reset-prompt
      else
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