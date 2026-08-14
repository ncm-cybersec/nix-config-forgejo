# ==========================================================================
# Local LLM Stack  - Github Copilot CLI
# ==========================================================================

{ 
  config,
  inputs,
  lib,
  pkgs,
  ... 
}:

{
  
  # Environment variables to force Github Copilot CLI to use Ollama
  home.sessionVariables = {
    COPILOT_PROVIDER_TYPE = "openai";
    COPILOT_PROVIDER_BASE_URL = "http://localhost:11434/v1";
    COPILOT_MODEL = "qwen2.5-coder:14b";
    COPILOT_OFFLINE = "true";
  };

  # Enable Github Copilot CLI using pkg from llmagents flakes
  programs = {
    
    github-copilot-cli = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.copilot-cli;
      configDir = "${config.xdg.configHome}/copilot";
      
      settings = {
        autoUpdate = false;
        renderMarkdown = true;
        theme = "default";
        trusted_folders = [
          "/home/nixadmin/nix-config"
          "/home/nixadmin/Homelab/"
        ];
      };
      
      lspServers = {
        ansible = {
          command = "ansible-language-server";
          args = [ "--stdio" ];
          fileExtensions = {
            ".yaml.ansible" = "ansible";
            ".yml.ansible" = "ansible";
          };
        };
        copilot = {
          command = "copilot-language-server";
          args = [ "--stdio" ];
          fileExtensions = {
            "*" = "all";
          };
        };
        json = {
          command = "vscode-json-languageserver";
          args = [ "--stdio" ];
          fileExtensions = {
            ".json" = "json";
            ".jsonc" = "jsonc";
          };
        };
        marksman = {
          command = "marksman";
          args = [ "server" ];
          fileExtensions = {
            ".md" = "markdown";
            ".markdown" = "markdown";
          };
        };
        nixd = {
          command = "nixd";
          args = [ ];
          fileExtensions = {
            ".nix" = "nix";
          };
        };
        python = {
          command = lib.getExe' pkgs.pyright "pyright-langserver";
          args = [ "--stdio" ];
          fileExtensions = {
            ".py" = "python";
            ".pyw" = "python";
            ".pyi" = "python";
          };
        };
        systemd = {
          command = "systemd-language-server";
          args = [ "--stdio" ];
          fileExtensions = {
            ".service" = "systemd";
            ".timer" = "systemd";
            ".target" = "systemd";
            ".mount" = "systemd";
          };
        };
        terraform = {
          command = "terraform-ls";
          args = [ "serve" ];
          fileExtensions = {
            ".tf" = "terraform";
            ".tfvars" = "terraform";
          };
        };
        toml = {
          command = "taplo";
          args = [ "lsp" "run" ];
          fileExtensions = {
            ".toml" = "toml";
          };
        };
        typescript = {
          command = "typescript-language-server";
          args = [ "--stdio" ];
          fileExtensions = {
            ".ts" = "typescript";
            ".tsx" = "typescriptreact";
            ".js" = "javascript";
            ".jsx" = "javascriptreact";
          };
        };
        yaml = {
          command = "yaml-language-server";
          args = [ "--stdio" ];
          fileExtensions = {
            ".yaml" = "yaml";
            ".yml" = "yaml";
          };
        };
        zsh = {
          command = "bash-language-server";
          args = [ "start" ];
          fileExtensions = {
            ".zsh" = "zsh";
            "zshrc" = "zsh";
          };
        };
      };
    };
  };
}