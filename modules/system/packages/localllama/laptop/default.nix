# ==========================================================================
# Laptop Local LLM Services
# ==========================================================================

{
  pkgs,
  ...
}: 

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
      package = pkgs.llama-cpp.override { cudaSupport = true; };
      models."qwen3.5-4b" = {
        port = 30001;
        settings = {
          hf-repo = "unsloth/Qwen3.5-4B-GGUF:Q4_K_M";
          n-gpu-layers = 99;
          ctx-size = 16384;
          flash-attn = true;
          cache-type = "k-quant";
          cache-quant-level = 8;
        };
      };
    };
  };
}
