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
  home-manager.users.${config.parameters.user.username} = {

    # State Version, used for backward compatibility
    home.stateVersion = "24.11";

    # Let Home Manager install and manage itself
    programs.home-manager.enable = true;

    ## User Environment
    # - Common to all POSIX shell (not nu!)
    home = {

      # Base Information
      username = "${config.parameters.user.username}";
      homeDirectory = {
        "x86_64-linux" = "/home/${config.parameters.user.username}";
        "aarch64-darwin" = "/Users/${config.parameters.user.username}";
      }."${pkgs.system}";

      # Extra directories to add to PATH
      sessionPath = [ 
       "$HOME/.local/bin"
      ];

      # User specific environment Variables
      # Environment variables to always set at login
      sessionVariables = {};

      # Shell Integration and aliased
      # Common aliases that are compatible across all shells
      shell.enableShellIntegration = true;
      shellAliases = {
        # shorcuts
        c="clear";
        cs="clear;ls";
        h="history";
        j="jobs -l";
        # overrides
        more="less";
        rm="rm -i";
        cp="cp -i";
        mv="mv -i";
        meow="cat";       # just because you can
        man="echo woman"; # just because you can
        docker="podman";
        # ls
        ll="ls -l";
        la="ls -la";
        lm="ls -la | less";
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
      };
      configFile = {
        user-dirs = {
          enable = pkgs.stdenv.isDarwin;
          target = "user-dirs.dirs";
          # Standard directories
          text = ''
            XDG_DESKTOP_DIR="$HOME/Desktop"
            XDG_DOWNLOAD_DIR="$HOME/Downloads"
            XDG_TEMPLATES_DIR="$HOME/Templates"
            XDG_PUBLICSHARE_DIR="$HOME/Public"
            XDG_DOCUMENTS_DIR="$HOME/Documents"
            XDG_MUSIC_DIR="$HOME/Music"
            XDG_PICTURES_DIR="$HOME/Pictures"
            XDG_VIDEOS_DIR="$HOME/Movies" 
            XDG_APPLICATIONS_DIR = "$HOME/Applications";
            XDG_LIBRARY_DIR = "$HOME/Library";
            XDG_DEVEL_DIR = "$HOME/Devel";
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
   
    # Core Console Applications
    # - For productivity 
    ++ lib.optionals config.parameters.user.enableLightsaber [
      ./modules/alacritty.nix
      ./modules/qutebrowser.nix
      ./modules/firefox.nix
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
    ++ lib.optionals config.parameters.user.enableExtra [
      ./modules/extra.nix
    ]  

    # Currently testing those apps...
    ++ lib.optionals config.parameters.user.enableTest [
      ./modules/rio.nix
    ];

  };

}
