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

    antigravity-cli
    gitnexus
    copilot-cli
    oh-my-opencode
    opencode
    
    # Utilities
    apm
    gno
    mcporter
    memvid-cli
    openskills
    skills
    skills-installer
    
    # Workflow
    agent-deck
    herdr
      
  ];

    # Antigravity has been renamed to antigravity-cli in the numtide/llmagents flake repo. leaving this here as a reference for renaming nixpkgs if needed in the future.

    # ag-cli declared here is antigravity-cli from llm-agents.nix. it uses a wrapper derivation to rename the binary to avoid collision with the IDE version declared in home.nix. Every time I run a nixos-rebuild switch, I receive a warning saying "antigravity" has been renamed to antigravity-cli, even though both are currently included in 26.05 unstable (https://search.nixos.org/packages?channel=unstable&query=antigravity). Im not sure what this means for antigravity IDE, to be determined.

    #(pkgs.symlinkJoin {
    #  name = "ag-cli";
    #  paths = [ antigravity ];
    #  postBuild = '' 
    #    mv "$out/bin/antigravity" "$out/bin/ag-cli"
    #  '';
    #})

}
