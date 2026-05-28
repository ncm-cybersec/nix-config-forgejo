# ---------------------------------------------------
# NixOS System Binary Cache Configuration
# ---------------------------------------------------

{ ... }: { 

  # Increase maximum number of open files for user sessions to resolve 
  # "too many open files" error. Equivalent to running 
  # "ulimit -n 4096" command after flake update > nix rebuild.
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "1048576";
    }
    { 
      domain = "*";
      type = "hard";
      item = "nofile"; 
      value = "226214400";
    }
  ];

  # Input channel binary caches
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      "https://cache.numtide.com"
      "https://vicinae.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:mCHdDbf9VMTLI1uSRunKadHYADjL5YhBJWhhSPK6QR0="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };
} 