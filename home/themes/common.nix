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
        export BAR_COLOR=0xff${config.lib.stylix.colors.base00}
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
    # ...
  };

}