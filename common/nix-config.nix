# Common Nix settings accross configurations

{ config, nixpkgs, nixpkgs-unstable, pkgs, ... }: {

  # Garbage Collection
  nix.gc = if pkgs.stdenv.isDarwin
  then {
    automatic = true;
    interval.Day = 7;
    options = "--delete-older-than 7d";
  }
  else { # linux
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Extra Options
  # Flakes and unified command still experimental
  # extra-platforms required for rosetta to cross-compile
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    extra-platforms = x86_64-darwin aarch64-darwin
    auto-optimise-store = false
    connect-timeout = 5
    log-lines = 25
  '';

  nix.settings = {
    trusted-users = [
      "root"
      "${config.parameters.user.username}"
    ];

    # Increase download buffer size to prevent buffer full warnings
    download-buffer-size = 134217728; # 128MB (default is 64MB)
    
    # Binary caches for faster builds
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://nixpkgs-python.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
    ];

  };

}
