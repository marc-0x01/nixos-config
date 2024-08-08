# Common setup across all themes

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }: {

  # (Darwin) Sketchybar, common plugins

  home.file = {
    ".config/sketchybar/color-scheme.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      target = "${config.home.homeDirectory}/.config/sketchybar/color-scheme.sh";
      text = ''
        #!/bin/bash
        ## Bar olors derived from base16
        export DEFAULT=0xff${config.lib.stylix.colors.base05}
        #export BAR_COLOR=0xff${config.lib.stylix.colors.base00}
        export BAR_COLOR=0xff
        export ITEM_BG_COLOR=0xff${config.lib.stylix.colors.base02}
        export ACCENT_COLOR=0xff${config.lib.stylix.colors.base04}
      '';
    };
    ".config/sketchybar/plugins/calendar.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ./scripts/sketchybar-plugins/calendar.sh;
      target = "${config.home.homeDirectory}/.config/sketchybar/plugins/calendar.sh";
    };
      ".config/sketchybar/plugins/volume.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ./scripts/sketchybar-plugins/volume.sh;
      target = "${config.home.homeDirectory}/.config/sketchybar/plugins/volume.sh";
    };
      ".config/sketchybar/plugins/cpu.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ./scripts/sketchybar-plugins/cpu.sh;
      target = "${config.home.homeDirectory}/.config/sketchybar/plugins/cpu.sh";
    };
      ".config/sketchybar/plugins/battery.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ./scripts/sketchybar-plugins/battery.sh;
      target = "${config.home.homeDirectory}/.config/sketchybar/plugins/battery.sh";
    };
      ".config/sketchybar/plugins/front-app.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ./scripts/sketchybar-plugins/front-app.sh;
      target = "${config.home.homeDirectory}/.config/sketchybar/plugins/front-app.sh";
    };
      ".config/sketchybar/plugins/media.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ./scripts/sketchybar-plugins/media.sh;
      target = "${config.home.homeDirectory}/.config/sketchybar/plugins/media.sh";
    };
      ".config/sketchybar/plugins/space.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ./scripts/sketchybar-plugins/space.sh;
      target = "${config.home.homeDirectory}/.config/sketchybar/plugins/space.sh";
    };
      ".config/sketchybar/plugins/space-windows.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ./scripts/sketchybar-plugins/space-windows.sh;
      target = "${config.home.homeDirectory}/.config/sketchybar/plugins/space-windows.sh";
    };
    # ...
  };

}