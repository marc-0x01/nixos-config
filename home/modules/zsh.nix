# Zsh: The Z Shell

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
  };

}