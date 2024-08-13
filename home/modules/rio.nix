# Rio: A hardware-accelerated GPU terminal emulator focusing to run in desktops and browsers.
# Replacement for Alacritty, currently in test

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
  
  programs.rio = {
    enable = true;
    settings = {
        cursor = "▇";
        blinking-cursor = true;
        hide-cursor-when-typing = true;
        editor = "hx";
        padding-x = 10;
        padding-y = [10 10];
        option-as-alt = "left";
        working-dir = "/Users/mguillen/";
        confirm-before-quit = false;
        window = {
            mode = "Maximized";
            blur = true;
            decorations = "Buttonless";
        };
        renderer = {
            performance = "High";
            backend = "Automatic";
            disable-unfocused-render = false;
        };
        shell = {
            program = "/etc/profiles/per-user/mguillen/bin/nu";
            args=[
                "--config ${config.home.homeDirectory}/.config/nushell/config.nu"
                "--env-config ${config.home.homeDirectory}/.config/nushell/env.nu"
            ];
        };
        keyboard = {
            use-kitty-keyboard-protocol = true;
            disable-ctlseqs-alt = true;
        };
        scroll = {
            multiplier = 3.0;
            divider = 1.0;
        };
        navigation ={        
            mode = "CollapsedTab";
            clickable = false;
            use-current-path = false;
            color-automation = [];
        };
        bindings = {
            keys = [];
        };
        developer = {
            log-level = "OFF";
        };
    };
  };

  # Open terminal script
  #home.file = {
  #  ".local/bin/wm-open-term.sh" = {
  #    enable = pkgs.stdenv.isDarwin;
  #    executable = true;
  #    source = ../scripts/wm-open-term-darwin.sh;
  #    target = "${config.home.homeDirectory}/.local/bin/wm-open-term.sh";
  #  };
  #};

}