# ---------------------------------------------------
# Home Manager Nushell Conf
# ---------------------------------------------------

{ config, pkgs, ... }:

{

  programs = {
    nushell = { enable = true;
      extraConfig = ''
       let carapace_completer = {|spans|
       carapace $spans.0 nushell ...$spans | from json
       }
       $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false
        quick: false
        partial: true
        algorithm: "fuzzy"
        external: {
            enable: true
            max_results: 100
            completer: $carapace_completer
          }
        }
       }
       $env.PATH = ($env.PATH |
       split row (char esep) |
       prepend /home/myuser/.apps |
       append /usr/bin/env
       )
       fastfetch | lolcat
       '';
       shellAliases = {
       };
   };
   carapace.enable = true;
   carapace.enableNushellIntegration = true;

   starship = { enable = true;
       settings = {
         add_newline = true;
         character = {
         success_symbol = "[➜](bold green)";
         error_symbol = "[➜](bold red)";
       };
    };
  };
};

}
