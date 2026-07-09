# ==========================================================================
# Desktop Local LLM Services
# ==========================================================================
{
  lib,
  pkgs,
  ...
}:
 
let
  # CUDA-enabled llama.cpp for the standalone Gemma service
  llama-pkg = pkgs.llama-cpp.override {
    cudaSupport = true;
  };
in 
{
  # llmhop Router
  services.llmhop = {
    enable = true;

    settings = {
      # Bind the llmhop OpenAI-compatible API to LAN interfaces
      listen = "0.0.0.0:8080";
    };

    # Built-in llama.cpp worker management
    llama-cpp = {
      enable = true;
      package = llama-pkg;
      models."qwen3.5-9b" = {
        port = 30001;
        settings = {
          hf-repo = "unsloth/Qwen3.5-9B-GGUF:Q4_K_M";
          n-gpu-layers = 99;
          ctx-size = 8192;
          no-webui = true;
        };
      };
      models."gemma-4-12b" = {
        port = 8033;
        settings = {
          host = "0.0.0.0"; # Bind to LAN for Web UI access
          hf-repo = "unsloth/gemma-4-GGUF:gemma-4-12B-it-qat-UD-Q4_K_XL";
          n-gpu-layers = 99;
          ctx-size = 4096;
        };
      };
    };
  };
}
