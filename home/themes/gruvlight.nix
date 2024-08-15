# Gruvbox light theme based on base16

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
       desktop = 0.95;
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

  # (darwin) Sketchy Bar configuration
  home.file = {
    ".config/sketchybar/sketchybarrc" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      target = "${config.home.homeDirectory}/.config/sketchybar/sketchybarrc";
      text = ''
        #!/bin/bash
        ## Colors
        source "${config.home.homeDirectory}/.config/sketchybar/color-scheme.sh"
        ## Bar
        sketchybar --bar \
          height=37 \
          blur_radius=30 \
          position=top \
          sticky=off \
          padding_left=10 \
          padding_right=10 \
          color=$TRANSPARENT
        ## Defaults
        sketchybar --default \
          icon.font="Symbols Font 14 Nerd Font:Regular:15.0" \
          icon.color=$DEFAULT \
          label.font="GohuFont 14 Nerd Font:Regular:15.0" \
          label.color=$DEFAULT \
          background.color=$ITEM_BG_COLOR \
          background.corner_radius=5 \
          background.height=24 \
          padding_left=5 \
          padding_right=5 \
          label.padding_left=4 \
          label.padding_right=10 \
          icon.padding_left=10 \
          icon.padding_right=4
        ## Plugins
        PLUGIN_DIR="${config.home.homeDirectory}/.config/sketchybar/plugins"
        ## Items
        # L: Logo
        sketchybar --add item logo left \
          --set logo label.string="oO,)\,,/" \
                     label.font.style="Bold" \
                     icon.font.size="16" \
                     icon=󱓞 \
                     background.color=$TRANSPARENT \
                     click_script="sketchybar -m --update"
        # L: spaces
        SPACE_SIDS=(1 2 3 4 5 6 7 8 9 10)
        for sid in "''${SPACE_SIDS[@]}"
        do
        sketchybar --add space space.$sid left \
          --set space.$sid space=$sid \
                           icon=$sid \
                           label.font="sketchybar-app-font:Regular:15.0" \
                           label.padding_right=20 \
                           label.y_offset=-1 \
                           script="$PLUGIN_DIR/space.sh" \
                           click_script="yabai -m space --focus $sid"
        done
        sketchybar --add item space_separator left \
           --set space_separator icon=❯ \
                                 icon.color=$ACCENT_COLOR \
                                 icon.padding_left=4 \
                                 label.drawing=off \
                                 background.drawing=off \
                                 script="$PLUGIN_DIR/space-windows.sh" \
           --subscribe space_separator space_windows_change
        # L: Front Application
        sketchybar --add item front_app left \
           --set front_app  background.color=$ACCENT_COLOR \
                            icon.font="sketchybar-app-font:Regular:15.0" \
                            icon.color=$BAR_COLOR \
                            label.color=$BAR_COLOR \
                            script="$PLUGIN_DIR/front-app.sh" \
           --subscribe front_app front_app_switched
        # LN: Media
        sketchybar --add item media e \
           --set media label.color=$ACCENT_COLOR \
                       label.max_chars=20 \
                       icon.padding_left=0 \
                       scroll_texts=on \
                       icon= \
                       icon.color=$ACCENT_COLOR \
                       background.drawing=off \
                       script="$PLUGIN_DIR/media.sh" \
           --subscribe media media_change
        # R: Calendar
        sketchybar --add item calendar right \
           --set calendar update_freq=30 \
                          icon=󰚒  \
                          script="$PLUGIN_DIR/calendar.sh"
        # R: Volume
        sketchybar --add item volume right \
           --set volume script="$PLUGIN_DIR/volume.sh" \
           --subscribe volume volume_change
        # R: Battery
        sketchybar --add item battery right \
           --set battery update_freq=120 \
                         script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke power_source_change
        # R: CPU
        sketchybar --add item cpu right \
           --set cpu update_freq=2 \
                     icon=󰍛 \
                     script="$PLUGIN_DIR/cpu.sh"
      '';
    };
  };

}