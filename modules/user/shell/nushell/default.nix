# ---------------------------------------------------
# Home Manager Nushell Conf
# ---------------------------------------------------

{ ... }:

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
   carapace = { 
     enable = true;
     enableNushellIntegration = true;
   };
   
   starship = { 
     enable = true;
     settings = builtins.fromTOML (builtins.readFile ./starship.toml);
   };
 };

}
