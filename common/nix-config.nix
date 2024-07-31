# Common Nix settings accross configurations

{ nixpkgs, nixpkgs-unstable, pkgs, ... }: {

  # Garbage Collection
  nix.gc = {
    automatic = true;
    interval.Day = 7;
    options = "--delete-older-than 7d";
  };

  # Extra Options
  # Flakes and unified command still experimental
  # extra-platforms required for rosetta to cross-compile
  nix.extraOptions = ''
    auto-optimise-store = false
    experimental-features = nix-command flakes
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

}
