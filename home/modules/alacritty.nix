# Alacritty: A fast, cross-platform, OpenGL terminal emulator

{ pkgs, lib, config, osConfig, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
  
  programs.alacritty = {
    enable = true;
    settings = {
      # Shell
      shell = {
        program = "/etc/profiles/per-user/${osConfig.parameters.user.username}/bin/nu";
        args = [
          "--config ${config.home.homeDirectory}/.config/nushell/config.nu"
          "--env-config ${config.home.homeDirectory}/.config/nushell/env.nu"
        ];
      };
      # Window Configuration
      window = {
        title = "Terminal";
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
        startup_mode = "Maximized";
        decorations = "Transparent";
        dynamic_title = true;
        dynamic_padding = true;
        padding = {
          x = 10;
          y = 20;
        };
      };
      # Cursor configuration
      mouse = {
        hide_when_typing = true;
      };
      colors = {
        draw_bold_text_with_bright_colors = false;
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
        bindings = [
          { key = "Enter"; mods = "Control"; action = "CreateNewWindow"; }
        ];
      };
    };
  };

}