# ==========================================================================
# Laptop Local LLM Services
# ==========================================================================

{
  pkgs,
  ...
}: 

let
  llama-pkg = pkgs.llama-cpp.override {
    cudaSupport = true;
  };
in 
{
  services.llmhop = {
    enable = true;

    settings = {
      # Localhost only — laptop uses CLI tools
      listen = "127.0.0.1:8080";
    };

    # Built-in llama.cpp worker management
    llama-cpp = {
      enable = true;
      package = llama-pkg;
      models."qwen3.5-4b" = {
        port = 30001;
        settings = {
          hf-repo = "unsloth/Qwen3.5-4B-GGUF:Q4_K_M";
          n-gpu-layers = 99;
          ctx-size = 8192;
          no-webui = true;
        };
      };
    };
  };
}
