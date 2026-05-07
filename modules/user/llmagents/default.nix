# ---------------------------------------------------
# Home Manager Packages - LLM-Agents Input
# ---------------------------------------------------

{ config, inputs, pkgs, ... }:

{
  
  home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    
    # Assistants
    hermes-agent
    
    # Coding Agents
    crush
    gemini-cli
    gitnexus
    copilot-cli
    kilocode-cli
    nanocoder
    oh-my-opencode
    opencode
    
    # Utilities
    amp
    gno
    mcporter
    openskills
    skills
    skills-installer
    
    # Workflow
    agent-deck
      
  ];

}
