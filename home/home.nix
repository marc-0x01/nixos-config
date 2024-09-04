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
      username = "${username}";
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
        videos = "$HOME/Movies";
        publicShare = "$HOME/Public";
        # User specific
        extraConfig = {
          XDG_APPLICATIONS_DIR = "$HOME/Applications";
          XDG_LIBRARY_DIR = "$HOME/Library";
          XDG_DEVEL_DIR = "$HOME/Devel";
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
    ++ lib.optionals True [
      ./modules/alacritty.nix
      ./modules/qutebrowser.nix
    ] 
    
    # Core Console Applications
    # - For productivity 
    ++ lib.optionals True [
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
    ++ lib.optionals True [
      ./modules/extra.nix
    ] 
    
    # Apply styling of the applications
    ++ lib.optionals True [
      # Theme
      ./themes/common.nix
      ./themes/gruvlight.nix
    ] 
    
    # Currently testing those apps...
    ++ lib.optionals True [
      ./modules/rio.nix
    ];

  };

}
