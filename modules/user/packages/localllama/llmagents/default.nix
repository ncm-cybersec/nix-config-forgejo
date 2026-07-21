# ==========================================================================
# Local LLM Stack  - User Services
# ==========================================================================

{ 
  inputs,
  pkgs,
  ... 
}:

{
  
  # Numtide/LLM-agents Packages
  home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [ 
    
    gitnexus
    gno
    herdr
    kilocode-cli
    letta-code
    memvid-cli
    nanocoder
    oh-my-opencode
    skills
    
  ];
  
  # Enable Opencode using pkg from llmagents flakes
  programs = {
    opencode = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
    };
  };
}
