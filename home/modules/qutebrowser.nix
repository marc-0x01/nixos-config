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
        hide_decoration = false; # On darwin, if enable yabai won't manage the screen
        transparent = true;
        title_format = "qutebrowser{title_sep}{current_title} ({host})";
      };
      input = {
        spatial_navigation = true;
        insert_mode = { 
          auto_load = true;
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
      completion = {
        height = 0.25; 
        shrink = true;
      };
      hints = {
        uppercase = true;
        radius = 2;
      };
      url = {
        default_page  = "about:blank";
        start_pages = "https://start.duckduckgo.com";
      };
    };
    # Command Aliases
    aliases = {};
    # Bindings, start from scratch and stay minimal
    enableDefaultBindings = false;
    keyBindings = {
      normal = {
        # commands
        "/" = "cmd-set-text /";
        ":" = "cmd-set-text :";
        # enter modes
        "i" = "mode-enter insert";
        "v" = "mode-enter caret";
        # page navigation
        "h" = "scroll left";
        "j" = "scroll down";
        "k" = "scroll up";
        "l" = "scroll right";
        # content
        "<Return>" = "selection-follow";
        "<Meta-r>" = "reload";
        # history
        "H" = "back";
        "<Meta-Left>" = "back";
        "L" = "forward";
        "<Meta-Right>" = "forward";
        # tab
        "J" = "tab-next";
        "<Meta-Down>" = "tab-next";
        "K" = "tab-prev";
        "<Meta-Up>" = "tab-prev";
        "o" = "cmd-set-text :open ";
        "O" = "cmd-set-text :open -t ";
        "<Meta-t>" = "open -t";
        "dd" = "tab-close";
        "<Meta-w>" = "tab-close";
        "<Meta-1>" = "tab-focus 1";
        "<Meta-2>" = "tab-focus 2";
        "<Meta-3>" = "tab-focus 3";
        "<Meta-4>" = "tab-focus 4";
        "<Meta-5>" = "tab-focus 5";
        "<Meta-6>" = "tab-focus 6";
        "<Meta-7>" = "tab-focus 7";
        "<Meta-8>" = "tab-focus 8";
        "<Meta-Backspace>" = "tab-focus last";
        "<Meta-p>" = "tab-pin";
        "<Meta-m>" = "tab-mute";
        # search
        "<Meta-f>" = "cmd-set-text /";
        "n" = "search-next";
        "p" = "search-prev";
        # bookmarks
        "<meta-b>" = "bookmark-add";
        # zoom
        "+" = "zoom-in";
        "-" = "zoom-out";
      };
      insert = {
        "<Escape>" = "mode-leave";
      };
      caret = {
        "<Return>" = "yank selection";
        "<Escape>" = "mode-leave";
        "<Space>" = "selection-toggle";
        "<Shift-Space>" = "selection-drop";
      };
      command = {
        "<Return>" = "command-accept";
        "<Escape>" = "mode-leave";
        "<Tab>" = "completion-item-focus next";
        "<Up>" = "completion-item-focus --history prev";
        "<Down>" = "completion-item-focus --history next";  
        "<Ctrl-K>" = "rl-kill-line";
        "<Ctrl-A>" = "rl-beginning-of-line";
        "<Ctrl-E>" = "rl-end-of-line";
        "<Ctrl-N>" = "command-history-next";
        "<Ctrl-P>" = "command-history-prev";
      };
      hint = {
        "<Return>" = "hint-follow";
        "<Escape>" = "mode-leave";
      };
      prompt = {
        "<Return>" = "prompt-accept";
        "<Escape>" = "mode-leave";
        "<Tab>" = "prompt-item-focus next";
        "<Down" = "prompt-item-focus next";
        "<Shift-Tab>" = "prompt-item-focus prev";
        "<Up>" = "prompt-item-focus prev";
        "<Ctrl-K>" = "rl-kill-line";
        "<Ctrl-A>" = "rl-beginning-of-line";
        "<Ctrl-E>" = "rl-end-of-line";
      };
      yesno = {
        "<Return>" = "prompt-accept";
        "<Escape>" = "mode-leave";
        "y" = "prompt-accept yes";
        "n" = "prompt-accept no";
      };
      passthrough = {
        "<Shift-Escape>" = "mode-leave";
      };
      register = {
        "<Escape>" = "mode-leave";
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
