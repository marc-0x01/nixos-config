# Monochrome theme based on base16

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }: {

  stylix = {
    enable = true;
    # Theme apps by default
    autoEnable = true;
    targets = {
      # Exception due to bug on ruby ffi
      gnome.enable = false;
    };
    # Wallpaper!
    image = ./assets/wallpapers/gruv4-5k-3840x2160.jpeg;
    # Monochrome and dark
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-soft.yaml";
    polarity = "light";
    # Opacities
    opacity = {
       terminal = 0.85;
    };
    # Fonts
    fonts = {
      serif = {
        name = "GohuFont 14 Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["Gohu"];
        };
      };
      sansSerif = {
        name = "GohuFont 14 Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["Gohu"];
        };
      };
      monospace = {
        name = "GohuFont 14 Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["Gohu"];
        };
      };
      emoji = {
        name = "Symbols Font 14 Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["NerdFontsSymbolsOnly"];
        };
      };
      # Font Sizes by context
      sizes = {
        terminal = 14;
      };
    };
  };

  # (darwin )Sketchy Bar configuration
  home.file = {
    ".local/bin/wm-setup-bar.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      target = "${config.home.homeDirectory}/.local/bin/wm-setup-bar.sh";
      text = ''
        #!/bin/bash
        ## Colors
        export DEFAULT=0xff${config.lib.stylix.colors.base05}
        export BAR_COLOR=0xff${config.lib.stylix.colors.base00}
        export ITEM_BG_COLOR=0xff${config.lib.stylix.colors.base02}
        export ACCENT_COLOR=0xff${config.lib.stylix.colors.base04}
        ## Bar
        sketchybar --bar \ 
          height=37        \
          blur_radius=30   \
          position=top     \
          sticky=off       \
          padding_left=10  \
          padding_right=10 \
          color=$BAR_COLOR
        ## Defaults
        sketchybar --default \
          icon.font="GohuFont 14 Nerd Font:Regular:15.0"  \
          icon.color=$DEFAULT               \
          label.font="GohuFont 14 Nerd Font:Regular:15.0" \
          label.color=$DEFAULT              \
          background.color=$ITEM_BG_COLOR   \
          background.corner_radius=5        \
          background.height=24              \
          padding_left=5                    \
          padding_right=5                   \
          label.padding_left=4              \
          label.padding_right=10            \
          icon.padding_left=10              \
          icon.padding_right=4
        ## Plugins
        ## Items
	      sketchybar --add item logo left \
	        --set logo label.string="oO,)\,,/" \
	                   label.font-style="Bold" \
		                 background.color=0xff
      '';
    };
  };

}