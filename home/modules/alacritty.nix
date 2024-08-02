# Alacritty: A fast, cross-platform, OpenGL terminal emulator

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
  
  programs.alacritty = {
    enable = true;
    settings = {
      # Shell
      shell = {
        program = "/etc/profiles/per-user/mguillen/bin/nu";
      };
      # Window Configuration
      window = {
        title = "Terminal";
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
        startup_mode = "Maximized";
        decorations = "ButtonLess";
        dynamic_title = true;
        dynamic_padding = true;
        padding = {
          x = 10;
          y = 10;
        };
      };
      # Cursor configuration
      mouse = {
        hide_when_typing = true;
      };
      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
        unfocused_hollow = true;
      };
      # Selection
      # Save select, right-click to global clipboard
      selection = {
        save_to_clipboard = true;
      };
      # Live reload the configuration
      live_config_reload = true;
      # Keyboard and bindings
      keyboard = {
        bindings = [];
      };
    };
  };

  # Open terminal script
  home.file = {
    ".local/bin/wm-open-term.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ../scripts/wm-open-term-darwin.sh;
      target = "${config.home.homeDirectory}/.local/bin/wm-open-term.sh";
    };
  };

}