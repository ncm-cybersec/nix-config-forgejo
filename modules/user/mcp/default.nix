# ---------------------------------------------------
# Home Manager Packages - MCP Servers
# ---------------------------------------------------

{ pkgs, pkgsUnstable, ... }:

{
  
  # MCP Servers
  programs.mcp = {
    enable = true;
    antigravity.profiles.NCM_Cybersec.enableMcpIntegration = true;
    opencode.enableMcpIntegration = true;
    zed-editor.enableMcpIntegration = true;
    servers = {
      podman = {
        args = [
          "-y"
          "podman-mcp-server@latest"
        ];
        command = "npx";
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
  