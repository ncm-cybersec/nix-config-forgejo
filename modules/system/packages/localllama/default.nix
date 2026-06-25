# ==========================================================================
# Local LLM Services
# ==========================================================================

{ 
  pkgs, 
  pkgsUnstable, 
  ... 
}:

{
  
  # Ollama is currently used for local LLMs, will be replaced by llama.cpp
  
  # Enable Ollama
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

}
