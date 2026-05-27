# ---------------------------------------------------
# Home Manager Bash Conf
# ---------------------------------------------------

{ ... }:

{

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "ignoredups" "ignorespace" ];
    historyFileSize = 10000;
    historySize = 10000;
    bashrcExtra = ''
        fastfetch | lolcat
     '';
    shellAliases = {
    };
  };

}
