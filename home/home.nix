 # Home Configuration (dotfiles)
 
{ pkgs, lib, config, osConfig, nixpkgs, nixpkgs-unstable, nur, home-manager, stylix, ... }: {
  
  ## Expand System Environment, in User space
  environment = {
    shells = with pkgs; [ zsh nushell ]; 
    pathsToLink = [ 
      "/share/zsh"
    ];
  };

  ## Actual Home and dotfiles configuration
  home-manager.users.mguillen = {

    # State Version, used for backward compatibility
    home.stateVersion = "24.05";

    # Let Home Manager install and manage itself
    programs.home-manager.enable = true;

    ## User Environment
    # - Common to all POSIX shell (not nu!)
    home = {

      # Base Information
      username = "mguillen";
      homeDirectory = {
        "x86_64-linux" = "/home/mguillen";
        "aarch64-darwin" = "/Users/mguillen";
      }."${pkgs.system}";

      # Extra directories to add to PATH
      sessionPath = [ 
       "$HOME/.local/bin"
      ];

      # User specific environment Variables
      # Environment variables to always set at login
      sessionVariables = {};

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

    ## XDG ##
    # - XDG User Directories are linux only - not supported on Darwin!
    # - For Darwin, direct overwriting of the config file!
    xdg = {
      enable = true;
      userDirs = {
        enable = pkgs.stdenv.isLinux;
        createDirectories = true; 
        # Standard directories
        desktop = "$HOME/Desktop";
        download = "$HOME/Downloads";
        documents = "$HOME/Documents";
        music = "$HOME/Music";
        pictures = "$HOME/Pictures";
        templates = "$HOME/Templates";
        videos = "$HOME/Videos";
        publicShare = "$HOME/Public";
        # User specific
        extraConfig = {
          XDG_APPLICATIONS_DIR = "$HOME/Applications";
          XDG_LIBRARY_DIR = "$HOME/Library";
          XDG_DEVEL_DIR = "$HOME/Devel";
        };
        configFile.user-dirs = {
          enable = pkgs.stdenv.isDarwin;
          target = "user-dirs.dirs";
          # Standard directories
          text = ''
            XDG_DESKTOP_DIR="${config.home.homeDirectory}/Desktop"
            XDG_DOWNLOAD_DIR="${config.home.homeDirectory}/Downloads"
            XDG_TEMPLATES_DIR="${config.home.homeDirectory}/Templates"
            XDG_PUBLICSHARE_DIR="${config.home.homeDirectory}/Public"
            XDG_DOCUMENTS_DIR="${config.home.homeDirectory}/Documents"
            XDG_MUSIC_DIR="${config.home.homeDirectory}/Music"
            XDG_PICTURES_DIR="${config.home.homeDirectory}/Pictures"
            XDG_VIDEOS_DIR="${config.home.homeDirectory}/Movies" 
            XDG_APPLICATIONS_DIR = "${config.home.homeDirectory}/Applications";
            XDG_LIBRARY_DIR = "${config.home.homeDirectory}/Library";
            XDG_DEVEL_DIR = "${config.home.homeDirectory}/Devel";
          ''; # On Darwin Videos = Movies ;)
        };
      };
    };

    
    

    ## Applications ##
    # - This configuration builds the following lightsaber...

    imports = 

    # Base Unix
    # - That should be there whatever the context
    [
      ./modules/zsh.nix
      ./modules/vim.nix
      ./modules/tmux.nix
      ./modules/git.nix
      ./modules/ssh.nix
    ] 
    
    # Core Desktop Applications
    # - My Console and Web Terminal
    ++ lib.optionals pkgs.stdenv.isDarwin [
      ./modules/alacritty.nix
      ./modules/qutebrowser.nix
    ] 
    
    # Core Console Applications
    # - For productivity 
    ++ lib.optionals pkgs.stdenv.isDarwin [
      ./modules/nushell.nix
      ./modules/starship.nix
      ./modules/direnv.nix
      ./modules/zellij.nix
      ./modules/yazi.nix
      ./modules/helix.nix
      ./modules/github.nix
      ./modules/aws.nix
      ./modules/ncspot.nix
      ./modules/misc.nix
    ] 

    # Extra Desktop/Console Applications
    # Not yet in home-manager...
    ++ lib.optionals pkgs.stdenv.isDarwin [
      ./modules/extra.nix
    ] 
    
    # Apply styling of the applications
    ++ lib.optionals pkgs.stdenv.isDarwin [
      # Theme
      ./themes/common.nix
      ./themes/gruvlight.nix
    ] 
    
    # Currently testing those apps...
    ++ lib.optionals pkgs.stdenv.isDarwin [
      ./modules/rio.nix
    ];

  };

}
