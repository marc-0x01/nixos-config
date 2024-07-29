# Hardware tweaks for MacBook Air 15 with M2 processor

{ pkgs, lib, nixpkgs, nixpkgs-unstable, nix-darwin, ... }: {
  system.defaults.CustomSystemPreferences = {
    # Disable dashboard that consume lots of resources
    "com.apple.dashboard" = { 
        mcx-disabled = true;
    };
  };
}