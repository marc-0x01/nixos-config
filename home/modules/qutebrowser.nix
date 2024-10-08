# qutebrowser: A keyboard-focused browser with a minimal GUI

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, nur, home-manager, ... }: {

  programs.qutebrowser = {
    enable = true;  
    # Main package currently broken, using own bin derivation on darwin
    package = lib.mkIf pkgs.stdenv.isDarwin pkgs.qutebrowser-bin;
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
        forward_unbound_keys = "auto";
        spatial_navigation = true;
        insert_mode = { 
          auto_load = true;
          auto_enter = true;
          auto_leave = true;
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
        show = "in-mode";
      };
      tabs = {
        position = "top";
        show = "multiple";
        last_close = "close";
        mousewheel_switching = false;
        mode_on_change = "persist";
        select_on_remove = "last-used";
        favicons = {
          show = "never";
        };
        title = {
          format = "{index}: {current_title}";
        };
      };
      completion = {
        height = "25%"; 
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
      # Color overrides
      colors = with config.lib.stylix.colors.withHashtag; {
        statusbar = { 
          passthrough = {
            bg = lib.mkForce base00;
            fg = lib.mkForce base05;
          };
        };
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
        "§§" = "mode-enter passthrough";
        "i" = "mode-enter insert";
        "v" = "mode-enter caret";
        # page navigation
        "h" = "scroll left";
        "j" = "scroll down";
        "k" = "scroll up";
        "l" = "scroll right";
        # content
        "<Return>" = "selection-follow";
        "<Ctrl-r>" = "reload";
        # history
        "H" = "back";
        "<Alt-Left>" = "back";
        "L" = "forward";
        "<Alt-Right>" = "forward";
        # tab
        "J" = "tab-next";
        "<Alt-Down>" = "tab-next";
        "K" = "tab-prev";
        "<Alt-Up>" = "tab-prev";
        "o" = "cmd-set-text :open ";
        "O" = "cmd-set-text :open -t ";
        "<Ctrl-t>" = "open -t";
        "dd" = "tab-close";
        "u" = "undo";
        "<Ctrl-w>" = "tab-close";
        "<Alt-1>" = "tab-focus 1";
        "<Alt-2>" = "tab-focus 2";
        "<Alt-3>" = "tab-focus 3";
        "<Alt-4>" = "tab-focus 4";
        "<Alt-5>" = "tab-focus 5";
        "<Alt-6>" = "tab-focus 6";
        "<Alt-7>" = "tab-focus 7";
        "<Alt-8>" = "tab-focus 8";
        "<Alt-Backspace>" = "tab-focus last";
        "<Ctrl-p>" = "tab-pin";
        "<Ctrl-m>" = "tab-mute";
        # search
        "<Ctrl-f>" = "cmd-set-text /";
        "n" = "search-next";
        "p" = "search-prev";
        # bookmarks
        "<Ctrl-b>" = "bookmark-add";
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
        "§§" = "mode-leave";
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

}
