# Tmux: Terminal Multiplexer

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.tmux = {
    enable = true;
  };

}