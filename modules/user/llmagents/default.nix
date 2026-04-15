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
    forge
    gemini-cli
    copilot-cli
    goose-cli
    kilocode-cli
    letta-code
    nanocoder
    opencode
    qwen-code
    
    # Utilities
    copilot-language-server
    gno
    mcporter
    openskills

    # Workflow
    agent-deck
      
  ];

}
