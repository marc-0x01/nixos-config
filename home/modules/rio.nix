# Rio: A hardware-accelerated GPU terminal emulator focusing to run in desktops and browsers.
# Replacement for Alacritty, currently in test

{ pkgs, lib, config, osConfig, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
  
  programs.rio = {
    enable = true;
    # Main package currently broken, using own bin derivation on darwin
    package = lib.mkIf pkgs.stdenv.isDarwin pkgs.rio-bin;
    settings = {
      cursor = "▇";
      blinking-cursor = true;
      hide-cursor-when-typing = true;
      editor = {
        program = "/etc/profiles/per-user/${osConfig.parameters.user.username}/bin/hx";
        args = [];
      };
      padding-x = 10;
      padding-y = [10 10];
      option-as-alt = "left";
      confirm-before-quit = false;
      window = {
        mode = "Maximized";
        decorations = "Transparent";
      };
      renderer = {
        performance = "High";
        backend = "Automatic";
        disable-unfocused-render = false;
      };
      shell = {
        program = "/etc/profiles/per-user/${osConfig.parameters.user.username}/bin/nu";
        args = [
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
    }; 

  };

}