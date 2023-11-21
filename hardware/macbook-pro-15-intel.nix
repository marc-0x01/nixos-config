# Hardware tweaks for MacBook Pro 15 with Intel processor

{ pkgs, lib, nixpkgs, nixpkgs-unstable, nix-darwin, ... }: {
  system.defaults.CustomSystemPreferences = {
    # Disable dashboard that consume lots of resources
    "com.apple.dashboard" = { 
        mcx-disabled = true;
    };
    # Accessibility settings reducing ui chrome
    # "com.apple.Accessibility" = { 
    #   DifferentiateWithoutColor = 1;
    #   ReduceMotionEnabled = 1;
    # };
    # "com.apple.universalaccess" = {
    #   reduceMotion = 1;
    #   reduceTransparency = 1;
    # };
  };
  
}