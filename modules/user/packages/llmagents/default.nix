# ==========================================================================
# Home Manager Packages - Numtide/LLMAgents Flake Input
# ==========================================================================

{ 
  inputs,
  pkgs,
  ... 
}:

{
  
  # Packages from numtide/llm-agents.nix flake input
  home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    
    # Assistants
    hermes-agent
    hermes-desktop
    
    # Coding Agents
    oh-my-opencode
    opencode
    
    # Memory
    gitnexus
    gno
    memvid-cli

    # Utilities
    apm
    mcporter
    openskills
    skills
    skills-installer
    
    # Workflow
    agent-deck
    herdr
      
  ];

    # ag-cli is antigravity-cli from llm-agents.nix; wrapper derivation to rename binary to avoid collision with IDE version from nixpkgs - reference 

    #(pkgs.symlinkJoin {
    #  name = "ag-cli";
    #  paths = [ antigravity ];
    #  postBuild = '' 
    #    mv "$out/bin/antigravity" "$out/bin/ag-cli"
    #  '';
    #})

}
