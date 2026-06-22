# ==========================================================================
# Local LLM Services
# ==========================================================================

{ 
  pkgs, 
  pkgsUnstable, 
  ... 
}:

{
  
  # Ollama is currently used for local LLMs, but will eventually be replaced with llama.cpp. See /modules/user/llmagents for specific applications/services.
  
  # Enable Ollama for local llms
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

}
