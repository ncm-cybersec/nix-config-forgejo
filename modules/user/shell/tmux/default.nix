# ==========================================================================
# Home Manager Tmux Configuration
# ==========================================================================

{ 
  pkgs,
  ... 
}:

{

  # Enable Tmux
  programs.tmux = {
    enable = true;
    shortcut = "a";
    clock24 = true;
    terminal = "screen-256color";
    historyLimit = 10000;

    extraConfig = ''
      # Set vi mode for copy mode
      set-window-option -g mode-keys vi

      # Enable mouse support
      set -g mouse on
    '';

   # xdg.configFile."tmuxai/config.yaml".text = '' Enable after Tmuxai package is installed
     # local-llama:
     # provider: "openai"
     # model: "gemma3:1b"
     # api_key: "dummy-ollama-key"
     # base_url: "http://localhost:11434/v1"
   # '';
  };

}
