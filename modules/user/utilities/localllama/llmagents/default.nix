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
  
  # Enable Opencode using pkg from llmagents flakes
  programs = {
    opencode = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
      
      # opencode.json
      settings = {
        shell = "/bin/zsh";
        model = "qwen3.5:9b";
        default_agent = "plan";
        autoupdate = false;
        lsp = true;
        formatter = true;
        provider = {
          ollama = {
            models = {
              "hf.co/RavichandranJ/Dolphin3-Cyber-8B-GGUF:Q8_0" = {
                name = "Dolphin3-Cyber";
              };
              "gemma4:12b" = {
                name = "Gemma4";
              };
              "ornith:9b" = {
                name = "Ornith";
              };
              "qwen2.5-coder:14b" = {
                name = "Qwen2.5";
              };
              "qwen3.5:9b" = {
                name = "Qwen3.5";
              };
            };
            name = "Ollama";
            npm = "@ai-sdk/openai-compatible";
            options = {
              baseURL = "http://localhost:11434/v1";
              extraBody = {
                options = {
                  num_ctx = 32768;
                };
              };
            };
          };
        };
      };
    };
  };
}
