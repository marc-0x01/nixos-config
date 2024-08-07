# Common setup across all themes

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }: {

  # (Darwin) Sketchybar, common plugins
  home.file = {
    ".config/sketchybar/plugins" = {
      enable = pkgs.stdenv.isDarwin;
      recursive = true;
      executable = true;
      source = ./scripts/sketchybar-plugins;
      target = "${config.home.homeDirectory}/.config/sketchybar/plugins";
    };
  };

}