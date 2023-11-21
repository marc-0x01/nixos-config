# direnv: Unclutter your .profile!

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # Integrations
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

}