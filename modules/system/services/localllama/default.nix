# ==========================================================================
# Nixos Productivity Services
# ==========================================================================

{ 
  pkgs, 
  pkgsUnstable, 
  ... 
}:

{
  # Enable Ollama for local llms
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

}
