# ---------------------------------------------------
# Home Manager Packages - LLM-Agents Input
# ---------------------------------------------------

{ config, inputs, pkgs, pkgsUnstable, ... }:

{
  
  # Packages from numtide/llm-agents.nix flake input
  home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    
    # Assistants
    hermes-agent
    
    # Coding Agents
    antigravity
    gitnexus
    copilot-cli
    kilocode-cli
    nanocoder
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
      
  ];

}
