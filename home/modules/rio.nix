# Rio: A hardware-accelerated GPU terminal emulator focusing to run in desktops and browsers.
# Replacement for Alacritty, currently in test

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
  
  programs.rio = {
    enable = true;
    package = pkgs.rio-bin;
    settings = {
        cursor = "▇";
        blinking-cursor = true;
        hide-cursor-when-typing = true;
        editor = {
            program = "/etc/profiles/per-user/mguillen/bin/hx";
            args = [];
        };
        padding-x = 10;
        padding-y = [10 10];
        option-as-alt = "left";
        confirm-before-quit = false;
        window = {
            mode = "Maximized";
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
        };
        bindings = {
            keys = [];
        };
        developer = {
            log-level = "OFF";
        };
    } // 
    
    # Theme
    # Rio is not yet in Stylix, for now generating theme from the stylix colors
    # TODO Move to a TOML maker and eventualy create a stylix module
    {
        window = {
            opacity = 0.85;
            blur = false;
        };
        fonts = {
            family = "GohuFont 14 Nerd Font";
            size = 14;
        };
        navigation = {
            color-automation = [];
        };
        colors = {
            background = "#fbf1c7";
            foreground = "#282828";
            selection-background = "#d5c4a1";
            selection-foreground = "#665c54";
            cursor = "#282828";
            black = "#fbf1c7";
            red = "#9d0006";
            green = "#79740e";
            yellow = "#b57614";
            blue = "#076678";
            magenta = "#8f3f71";
            cyan = "#427b58";
            white = "#3c3836";
            light_black = "#9d8374";
            light_red = "#cc241d";
            light_green = "#98971a";
            light_yellow = "#d79921";
            light_blue = "#458588";
            light_magenta = "#b16186";
            light_cyan = "#689d69";
            light_white = "#7c6f64";
        };
    };
  };

}