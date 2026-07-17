# ==========================================================================
# Desktop Local LLM Stack
# ==========================================================================
{
  pkgs,
  ...
}:
 
{
  
  imports = [
    ./librechat
    
  ];
  
  # llmhop Router
  services.llmhop = {
    enable = true;

    settings = {
      listen = "0.0.0.0:8080";
      cache = true;
    };

    # Built-in llama.cpp worker management
    llama-cpp = {
      enable = true;
      package = pkgs.llama-cpp.override { cudaSupport = true; };
      models."qwen3.5-9b" = {
        port = 30001;
        settings = {
          hf-repo = "unsloth/Qwen3.5-9B-GGUF:Q4_K_M";
          n-gpu-layers = 99;
          ctx-size = 32768;
          no-webui = true;
          flash-attn = true;
          
        };
      };
      
      models."gemma4-12b" = {
        port = 8033;
        settings = {
          host = "0.0.0.0";
          hf-repo = "unsloth/gemma-4-GGUF:gemma-4-12B-it-qat-UD-Q4_K_XL";
          n-gpu-layers = 99;
          ctx-size = 32768;
          flash-attn = true;
        };
      };
    };
  };
}
