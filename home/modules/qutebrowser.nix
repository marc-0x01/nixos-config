# qutebrowser: A keyboard-focused browser with a minimal GUI

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, nur, home-manager, ... }: {

  programs.qutebrowser = {
    enable = false;  # CURRENTLY BROKEN ;(
    # Key bindings
    enableDefaultBindings = true;
    #keyBindings = {};
    # Engines
    searchEngines = {
      dd = "";
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      nw = "https://wiki.nixos.org/index.php?search={}";
      g = "https://www.google.com/search?hl=en&q={}";
    };
    # Command Aliases
    aliases = {};
    # General Settings
    settings = {
        backend = "webengine";
        confirm_quit = "never";
    };
  };

  # Open browser script
  home.file = {
    ".local/bin/wm-open-web-browser.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ../scripts/wm-open-web-browser-darwin.sh;
      target = "${config.home.homeDirectory}/.local/bin/wm-open-web-browser.sh";
    };
  };

}