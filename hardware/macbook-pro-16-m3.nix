# Hardware tweaks for MacBook Pro 16 with M3 processor

{ pkgs, lib, nixpkgs, nixpkgs-unstable, nix-darwin, ... }: {
  system.defaults.CustomSystemPreferences = {
    # Disable dashboard that consume lots of resources
    "com.apple.dashboard" = { 
        mcx-disabled = true;
    };
  };
}