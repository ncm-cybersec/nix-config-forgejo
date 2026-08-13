# ==========================================================================
# Home Manager - Zsh Configuration
# ==========================================================================

{ 
  config,
  pkgs, 
  ... 
}:

{
  
  imports = [
    ./integrations
  ];
  
  home.packages = with pkgs; [
    deja
    fzf-zsh-plugin
    jq-zsh-plugin
    nav
    nerd-fonts.fira-code
    starship
    zsh-completions
    zsh-forgit
    zsh-nix-shell
  ];

  # Enable Zsh w/ oh-my-zsh
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = false;
      
      syntaxHighlighting = { 
        enable = true;
        package = pkgs.zsh-syntax-highlighting;
        highlighters = [
          "brackets"
          "pattern"
          "regexp"
          "cursor"
          "root"
          "line"
        ];
      };
      
      history = {
        append = true;
        expireDuplicatesFirst = true;
        extended = true;
        ignoreAllDups = true;
        path = "${config.xdg.dataHome}/zsh/history";
        save = 1000;
        saveNoDups = true;
        share = true;
        size = 1000;
      };
      
      historySubstringSearch = {
        enable = true;
        searchDownKey = [ "$terminfo[kcud1]" ];
        searchUpKey = [ "$terminfo[kcuu1]" ];
      };
      
      plugins = [
        {
          name = "zsh-autocomplete";
          src = "${pkgs.zsh-autocomplete}/share/zsh-autocomplete"; 
        }
      ];
      
      oh-my-zsh = {
        enable = true;
        package = pkgs.oh-my-zsh;
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
        
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
          --color=fg:#cbccc6,bg:#1f2430,hl:#707a8c
          --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66
          --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6
          --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff'
        
        fpath=($HOME/.zsh-complete $fpath)
        
        rga-fzf() {
	          RG_PREFIX="rga --files-with-matches"
	          local file
	          file="$(
		            FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			              fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				                --phony -q "$1" \
				                --bind "change:reload:$RG_PREFIX {q}" \
				                --preview-window="70%:wrap"
			      )" &&
	          echo "opening $file" &&
	          xdg-open "$file"
        }
        
        setopt null_glob

        eval "$(starship init zsh)"
        
        eval "$(nav --init zsh --completion zsh)"
        
        eval "$(witr completion zsh)"
        
        eval "$(deja init zsh)"
              
        fastfetch
      '';    
    };
  };  
}