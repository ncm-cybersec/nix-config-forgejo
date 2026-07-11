# ==========================================================================
# Home Manager MCP Configuration
# ==========================================================================

{ 
  pkgs, 
  ... 
}:

{
  # MCP Settings
  programs = {
    antigravity.profiles.nixadmin.enableMcpIntegration = true;
    opencode.enableMcpIntegration = true;
    zed-editor.enableMcpIntegration = true;
  };

  # MCP Servers
  programs.mcp = {
    enable = true;
    servers = {
      
      ansible-dev = {
        command = "${pkgs.nodejs}/bin/npx";
        args = [ 
          "-y" 
          "@ansible/mcp-server" 
        ];
        env = {

        };
      };
      
      forgejo = {
        command = "npx";
        args = [
          "-y"
          "@forgejo/mcp-server@latest"
        ];
      };

      mcp-language-server = {
        command = "mcp-language-server";
      };

      mcp-nixos = {
        command = "npx";
        args = [
          "-y"
          "mcp-nixos@latest"
        ];
      };

      mcp-server-fetch = {
        command = "npx";
        args = [
          "-y"
          "mcp-server-fetch@latest"
        ];
      };

      mcp-server-filesystem = {
        command = "npx";
        args = [
          "-y"
          "mcp-server-filesystem@latest"
        ];
      };

      mcp-server-git = {
        command = "npx";
        args = [
          "-y"
          "mcp-server-git@latest"
        ];
      };
      
      mcp-server-sequential-thinking = {
        command = "npx";
        args = [
          "-y"
          "mcp-server-sequential-thinking@latest"
        ];
      };

      podman = {
        args = [
          "-y"
          "podman-mcp-server@latest"
        ];
        command = "npx";
      };

      terraform = {
        command = "npx";
        args = [
          "-y"
          "@hashicorp/terraform-mcp-server@latest"
        ];
      };
    };
  };

}
  