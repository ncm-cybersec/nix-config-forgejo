# ==========================================================================
# Home Manager Packages - LLM-Agents Input
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
    aionui
    hermes-agent
    hermes-desktop
    
    # Coding Agents

    # ag-cli declared here is antigravity-cli from llm-agents.nix. it uses a wrapper derivation to rename the binary to avoid collision with the IDE version declared in home.nix
    (pkgs.symlinkJoin {
      name = "ag-cli";
      paths = [ antigravity ];
      postBuild = '' 
        mv "$out/bin/antigravity" "$out/bin/ag-cli"
      '';
    })
    gitnexus
    copilot-cli
    oh-my-opencode
    opencode
    
    # Utilities
    apm
    gno
    mcporter
    openskills
    skills
    skills-installer
    
    # Workflow
    agent-deck
    herdr
      
  ];

}
