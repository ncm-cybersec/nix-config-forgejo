# ==========================================================================
# Local LLM Stack  - User Services
# ==========================================================================

{ 
  inputs,
  pkgs,
  ...
}:

{
  
  imports = [
    ./copilot
    ./opencode
  ];
  
  # Numtide/LLM-agents Packages
  home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [ 
    aven
    ax
    cline
    gitnexus
    herdr
    letta-code
    memvid-cli
    oh-my-opencode
    open-code-review
    skills
    swamp
  ];
  
}
