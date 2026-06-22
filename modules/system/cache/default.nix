# ==========================================================================
# System Binary Cache Configuration
# ==========================================================================

{ 
  ... 
}: 

{ 

  # Increase maximum number of open files for user sessions to resolve 
  # "too many open files" error. I had previously solved this by running the
  # "ulimit -n 4096" command before updating flake inputs and running 
  # nixos-rebuild switch.

  # This should ensure that the "too many open files" error does not occur, 
  # while also protecting against memory spikes during large updates.
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "524288";
    }
    { 
      domain = "*";
      type = "hard";
      item = "nofile"; 
      value = "1048576";
    }
  ];

  # Binary caches for Nix flake inputs
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      "https://catppuccin.cachix.org"
      "https://cache.numtide.com"
      "https://cuda-maintainers.cachix.org"
      "https://vicinae.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:mCHdDbf9VMTLI1uSRunKadHYADjL5YhBJWhhSPK6QR0="
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };
} 