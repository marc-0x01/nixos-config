# qutebrowser: A keyboard-focused browser with a minimal GUI

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, nur, home-manager, ... }: {

  programs.qutebrowser = {
    enable = true;  
    # Main package currently broken, using own bin derivation
    package = pkgs.qutebrowser-bin;
    loadAutoconfig = false;
    # General Settings, most defaults are fine!
    settings = {
      backend = "webengine";
      window = {
        hide_decoration = true;
        transparent = true;
        title_format = "qutebrowser{title_sep}{current_title} ({host})";
      };
      input = {
        insert_mode = { 
          spatial_navigation = true;
          auto_enter = true;
          auto_leave = false;
        };
      };
      auto_save = {
        session = false;
      };
      content = {
        private_browsing = true;
        prefers_reduced_motion = true;
        autoplay = false;
        mute = true;
        pdfjs = true;
        webgl = true;
        user_stylesheets = null;
        notifications = {
          enabled = false;
        };
      };
      downloads = {
        location = {
          prompt = false;
          directory = "${config.home.homeDirectory}/Downloads";
          };
      };
      statusbar = {
        position = "bottom";
        show = "always";
      };
      tabs = {
        position = "top";
        show = "multiple";
        last_close = "close";
        mousewheel_switching = false;
        favicons = {
          show = "never";
        };
        title = {
          format = "{index}: {current_title}";
        };
      };
      url = {
        default_page  = "about:blank";
        start_pages = "https://start.duckduckgo.com";
      };
    };
    # Command Aliases
    aliases = {};
    # Bindings, start from scratch
    enableDefaultBindings = false;
    keyBindings = {
      normal = {
        "," = "config-edit";
      };
    };
    # Common Search Engines
    searchEngines = {
      duckduckgo = "https://duckduckgo.com/?q={}&kp=-1&kl=us-en&kae=t";
      wikipedia = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      nixwiki = "https://wiki.nixos.org/index.php?search={}";
      google = "https://www.google.com/search?hl=en&q={}";
    };
    # Quickmarks = Bookmarks
    quickmarks = {
      code = "https://vscode.dev";
      gh = "https://github.com/marc-0x01";
      sky = "https://sky.pictet.com";
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