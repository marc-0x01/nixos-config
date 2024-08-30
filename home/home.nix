 # Home Configuration (dotfiles)
 
{ pkgs, lib, config, osConfig, nixpkgs, nixpkgs-unstable, nur, home-manager, stylix, ... }: {
  
  # Expand System Environment, in User space
  environment = {
    shells = with pkgs; [ zsh nushell ]; 
    pathsToLink = [ 
      "/share/zsh"
    ];
  };

  # Actual Home and dotfiles configuration
  home-manager.users.mguillen = {

    # State Version, used for backward compatibility
    home.stateVersion = "24.05";

    # Let Home Manager install and manage itself
    programs.home-manager.enable = true;


    ## User Environment ##
    # - Common to all POSIX shell (not nu!)

    home = {

      # Base Information
      username = "mguillen";
      homeDirectory = {
        "x86_64-linux" = "/home/mguillen";
        "aarch64-darwin" = "/Users/mguillen";
      }.${builtins.currentSystem};

      # Extra directories to add to PATH
      sessionPath = [ 
       "$HOME/.local/bin"
      ];

      # User specific environment Variables
      # Environment variables to always set at login
      home.sessionVariables = {};

      # Common aliases that are compatible across all shells
      shellAliases = {
        # shorcuts
        c="clear";
        cs="clear;ls";
        h="history";
        j="jobs -l";
        # overrides
        more="less";
        mkdir="mkdir -p";
        du="du -kh";
        df="df -kTh";
        rm="rm -i";
        cp="cp -i";
        mv="mv -i";
        tree="tree --dirsfirst -F";
        meow="cat";       # just because you can
        man="echo woman"; # just because you can
        # ls
        ll="ls -l";
        la="ls -la";
        lm="la | less";
        # cd 
        ".."="cd ..";
        "..."="cd ../..";
        "...."="cd ../../..";
        "....."="cd ../../../..";
        "~"="cd ~";
      };

    };

    ## 1 Base Configuration ##
    # - Unix Trinity with *sensible* defaults
    # Note: Similar to what I use in dev workspaces

    # Zsh: Shell
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      autocd = true;
      enableAutosuggestions = true;
      
      # Zsh specific, the rest goes to "home"
      shellAliases = {
      };
    };

    # Vim: Editor
    programs.vim = {
      enable = true;
    };

    # Tmux: Terminal Multiplexor
    programs.tmux = {
      enable = true;
    };


    ## 2 Lightsaber Configuration ##
    # Where the tweaks and productivity happens 

    # This configuration builds the following lightsaber...
    # Note: VSCode, Discord, Slack are used in their web incarnations
    imports = [
      # Theme
      ./themes/common.nix
      ./themes/gruvlight.nix
      # Applications
      ./modules/alacritty.nix
      ./modules/rio.nix
      ./modules/qutebrowser.nix
      ./modules/nushell.nix
      ./modules/starship.nix
      ./modules/direnv.nix
      ./modules/zellij.nix
      ./modules/yazi.nix
      ./modules/helix.nix
      ./modules/gpg.nix
      ./modules/ssh.nix
      ./modules/git.nix
      ./modules/github.nix
      ./modules/aws.nix
      ./modules/ncspot.nix
      ./modules/misc.nix
    ];

    # Extra programs managed by home manager
    # They do not need extra configuration
    programs = {
      # Terminal
      bat.enable = true;          # Better cat (bat)
      bottom.enable = true;       # Better top (btm)
      jq.enable = true;           # Json parser (jq)
      skim.enable = true;         # Fuzzy finder (sk)
      lazygit.enable = true;      # Git UI for humans (lazygit)
      taskwarrior.enable = true;  # Task management (task)
      ripgrep.enable = true;      # Better grep (rg)
      rbw.enable = true;          # Bitwarden cli (rbw)
      thefuck.enable = true;      # Correct latest command (fuck)
    };

    # Extra packages or not yet in home-manager
    # Look for new addition or rust alternatives: lolcrab (better lolcat)
    home.packages = with pkgs; [
      # Desktop Apps
      obsidian                  # Digital Garden and noote taking
      jetbrains.gateway         # Remote development, alternative to vim in a professional environment
      # Terminal
      charasay                  # Cow have voice in terminal, better coesay (charasay)
      lolcat                    # Rainbow! (lolcat)
      steampipe                 # Query like it's 1992 (steampipe)
      uutils-coreutils          # Better coreutils in rust, hamonize on darwin (*)
      ouch                      # Compression swiss-army knife (ouch)
      rsign2                    # Signing cli compatible with minisign (rsign)
      rage                      # A simple, secure and modern encryption tool (age)
      age-plugin-yubikey        # -- Integration of age with yubikey
      difftastic                # Better diff (difft), mostly for git
      macchina                  # System info fetcher (macchina)
      xh                        # Replacement for httpie, curl (xh)
      du-dust                   # More intuitive du (dust)
      vulnix                    # Nix scurity scanner
    ];

    ## XDG General ##

    xdg.enable = true;

    # XDG User Directories, linux only - not supported on Darwin ?
    # i.e. Desktop, Downloads, Public
    xdg.userDirs = {
      enable = true; #pkgs.stdenv.isLinux;
      createDirectories = true; 
      # Standard directories
      desktop = "${config.home.homeDirectory}/Desktop";
      download = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/Documents";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      templates = "${config.home.homeDirectory}/Templates";
      videos = "${config.home.homeDirectory}/Movies";
      publicShare = "${config.home.homeDirectory}/Public";
      # User specific
      extraConfig = {
        XDG_APPLICATIONS_DIR = "${config.home.homeDirectory}/Applications";
        XDG_LIBRARY_DIR = "${config.home.homeDirectory}/Library";
        XDG_DEVEL_DIR = "${config.home.homeDirectory}/Devel";
      };
    };

    # For Darwin, savage overwriting the config file
    # xdg.configFile.user-dirs = {
    #   enable = pkgs.stdenv.isDarwin;
    #   target = "user-dirs.dirs";
    #   text = ''
    #     XDG_DESKTOP_DIR="${config.home.homeDirectory}/Desktop"
    #     XDG_DOWNLOAD_DIR="${config.home.homeDirectory}/Downloads"
    #     XDG_TEMPLATES_DIR="${config.home.homeDirectory}/Templates"
    #     XDG_PUBLICSHARE_DIR="${config.home.homeDirectory}/Public"
    #     XDG_DOCUMENTS_DIR="${config.home.homeDirectory}/Documents"
    #     XDG_MUSIC_DIR="${config.home.homeDirectory}/Music"
    #     XDG_PICTURES_DIR="${config.home.homeDirectory}/Pictures"
    #     XDG_VIDEOS_DIR="${config.home.homeDirectory}/Movies"
    #     XDG_APPLICATIONS_DIR = "${config.home.homeDirectory}/Applications";
    #     XDG_LIBRARY_DIR = "${config.home.homeDirectory}/Library";
    #     XDG_DEVEL_DIR = "${config.home.homeDirectory}/Devel";
    #   '';
    # };

  };

}
