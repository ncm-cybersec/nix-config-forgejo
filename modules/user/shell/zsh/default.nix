# ---------------------------------------------------
# Home Manager - zsh configuration
# ---------------------------------------------------

{ ... }:

{
  # ZSH Shell configuration
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      initContent = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"

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
      settings = builtins.fromJSON (builtins.readFile ./fastfetch25.jsonc);
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