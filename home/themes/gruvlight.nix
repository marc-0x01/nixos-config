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
        export WHITE=0xffffffff
        export BAR_COLOR=0xff2d2b02
        export ITEM_BG_COLOR=0xff8e7e0a
        export ACCENT_COLOR=0xfff7fc17
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
        sketchybar --default 
          icon.font="SF Pro:Semibold:15.0"  \
          icon.color=$WHITE                 \
          label.font="SF Pro:Semibold:15.0" \
          label.color=$WHITE                \
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
        battery = (
          #!/bin/sh
          PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
          CHARGING=$(pmset -g batt | grep 'AC Power')
          if [ $PERCENTAGE = "" ]; then
            exit 0
          fi
          case ${PERCENTAGE} in
            9[0-9]|100) ICON="􀛨"
            ;;
            [6-8][0-9]) ICON="􀺸"
            ;;
            [3-5][0-9]) ICON="􀺶"
            ;;
            [1-2][0-9]) ICON="􀛩"
            ;;
            *) ICON="􀛪"
          esac

          if [[ $CHARGING != "" ]]; then
            ICON="􀢋"
          fi
          sketchybar --set battery icon="$ICON" label="${PERCENTAGE}%"
        )
        ## Items
        # Battery
        sketchybar --add item battery right \
          --set battery update_freq=120 \
                        script="${battery[@]}" \
          --subscribe battery system_woke power_source_change
      '';
    };
  };

}