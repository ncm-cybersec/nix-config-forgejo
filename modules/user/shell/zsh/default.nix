# ==========================================================================
# Home Manager - zsh configuration
# ==========================================================================

{ 
  ... 
}:

{

  # Enable ZSH w/ completions & extensions
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      completionInit = "autoload -Uz compinit && compinit";
      initContent = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"

        export SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-agent.sock"
        
        setopt null_glob

        eval "$(starship init zsh)"

        fastfetch
        
        # Load the core compliant menu selection module
        zmodload zsh/complist

        # Force the completion system to use an interactive selection menu
        zstyle ':completion:*' menu select=1

        # Use arrow keys to navigate the menu list like an IDE dropdown
        bindkey -M menuselect '^M' .accept-line
        bindkey -M menuselect 'h' backward-char
        bindkey -M menuselect 'k' up-line-or-history
        bindkey -M menuselect 'j' down-line-or-history
        bindkey -M menuselect 'l' forward-char

        # Enable colored matching that mirrors your LS_COLORS scheme
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

        # Group matching elements together under styled category headers
        zstyle ':completion:*' group-name ""
        zstyle ':completion:*' format $'\e[1;35m %d\e[0m'
        zstyle ':completion:*' descriptions true

        # Enable smart case-insensitive matching (type lowercase, matches uppercase)
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'

        # Clean up trailing slashes automatically when matching directories
        zstyle ':completion:*' squeeze-slashes true
        
        # Natural Language Intercept
        nix-ai-buffer() {
          [[ -z "$BUFFER" ]] && return

          # Rose Pine 'Iris' / Catppuccin 'Lavender' visual indicator (\e[34m)
          echo -e "\n\e[1;34m[Agentic Router] Translating to executable shell syntax... \e[0m"

          local prompt="Convert this natural language instruction into a precise, executable Zsh/NixOS command. Return ONLY the raw shell command, with no explanations, no markdown formatting, and no code blocks: $BUFFER"
          local ai_command=$(aichat "$prompt")

          BUFFER="$ai_command"
          CURSOR=$#BUFFER
          zle redisplay
        }
        zle -N nix-ai-buffer
        bindkey '^ ' nix-ai-buffer

        ai-intercept-executor() {
          if [[ -z "$BUFFER" ]]; then
            zle .accept-line
            return
          fi

          local first_word=''${BUFFER%% *}

          if whence "$first_word" >/dev/null 2>&1 || [[ "$BUFFER" =~ ^[./] ]]; then
            zle .accept-line
            return
          fi

          local safety_prompt="Is the following text a conversational question or a natural language statement? Answer with exactly 'YES' or 'NO': $BUFFER"
          local is_natural=$(aichat "$safety_prompt" | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')

          if [[ "$is_natural" == *"YES"* ]]; then
            # Rose Pine 'Gold' / Catppuccin 'Rosewater' visual separator (\e[33m)
            echo -e "\n\e[1;33m[Natural Language Intercept] -> Hitting Local Qwen Stack \e[0m"
            
            # Passes the string directly down to aichat, triggering your custom persona theme flags
            aichat "$BUFFER"
            
            BUFFER=""
            zle redisplay
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