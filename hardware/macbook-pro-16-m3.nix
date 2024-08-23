# Hardware tweaks for MacBook Pro 16 with M3 processor
# Not much here OSX is quite opiniated

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, nix-darwin, ... }: {

  system.defaults.CustomSystemPreferences = {
    # Disable dashboard that consume lots of resources
    "com.apple.dashboard" = { 
        mcx-disabled = true;
    };
  };
  
}