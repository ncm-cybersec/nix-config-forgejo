# ==========================================================================
# System Binary Cache Configuration
# ==========================================================================

{ 
  ... 
}: 

{ 

  # Resolve "too many open files" error
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
      "https://cache.nixos-cuda.org"
      "https://catppuccin.cachix.org"
      "https://cache.numtide.com"
      "https://cuda-maintainers.cachix.org"
      "https://vicinae.cachix.org"
    ];
    
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:mCHdDbf9VMTLI1uSRunKadHYADjL5YhBJWhhSPK6QR0="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };
} 