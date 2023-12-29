 # Home Configuration (dotfiles)
 
{ pkgs, lib, config, osConfig, nixpkgs, nixpkgs-unstable, nur, home-manager, stylix, ... }: {
  
  # User account
  users.users.mguillen = {
    name = "mguillen";
    home = "/Users/mguillen";
    description = "Marc Guillen";
    shell = pkgs.nushell;
  };

  # Expand Default Shells
  environment.shells = with pkgs; [ zsh nushell ];

  # Actual home dotfiles configuration
  home-manager.users.mguillen = {

    # State Version, used for backward compatibility
    home.stateVersion = "23.11";

    # Let Home Manager install and manage itself
    programs.home-manager.enable = true;

    # Base information about the user
    home = {
      username = "mguillen";
      homeDirectory = "/Users/mguillen";
    };

    # Basic POSIX shell
    # NOTE: Not forwarded to nu as it is non POSIX
    programs.zsh.enable = true;
    home = {
      sessionPath = [
       "$HOME/.local/bin"
      ];
      shellAliases = {};
    };

    # This configuration builds the following lightsaber...
    # Note: VSCode, Discord, Slack are used in their web incarnations
    imports = [
      # Theme
      ./themes/monochrome.nix
      #./themes/amber.nix
      # Applications
      ./modules/alacritty.nix
      ./modules/firefox.nix
      ./modules/nushell.nix
      ./modules/starship.nix
      ./modules/direnv.nix
      ./modules/zellij.nix
      ./modules/neovim.nix
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
      bat.enable = true;          # Better cat (bat)
      bottom.enable = true;       # Better top (btm)
      jq.enable = true;           # Json parser (jq)
      skim.enable = true;         # Fuzzy finder (sk)
      lazygit.enable = true;      # Git UI for humans (lazygit)
      nix-index.enable = true;    # Nix locator (nix-inidex)
      k9s.enable = true;          # Cluster Management
      taskwarrior.enable = true;  # Task management (task)
      ripgrep.enable = true;      # Better grep (rg)
      thefuck.enable = true;      # Correct latest command (fuck)
      # Testing
      rio.enable = true;          # Rust/WebGPU Terminal (rio) - alacritty replacement ?
    };

    # Extra packages or not yet in home-manager
    # More not packaged yet: charasay (better cowsay), lolcrab (better lolcat), neko
    home.packages = with pkgs; [
      # Apps
      obsidian                  # Digital Garden and noote taking
      # Terminal
      bitwarden-cli             # Passkey manager
      steampipe                 # Query like it's 1992
      uutils-coreutils          # Better coreutils in rust, hamonize on darwin (*)
      ouch                      # Compression swiss-army knif (ouch)
      rsign2                    # Signing cli compatible with minisign (rsign)
      rage                      # A simple, secure and modern encryption tool (age)
      age-plugin-yubikey        # -- Integrration of age with yubikey
      macchina                  # System info fetcher (macchina)
      du-dust                   # More intuitive du (dust)
      asciinema                 # Terminal recorder
      vulnix                    # Nix scurity scanner
      difftastic                # Better diff (difft)
    ];

    # XDG General
    # i.e. for config, data, cache
    xdg.enable = true;

    # XDG User Directories, linux only - not supported onééééélkk Darwin
    # i.e. Desktop, Downloads, Public
    xdg.userDirs = {
      enable = pkgs.stdenv.isLinux;
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
    xdg.configFile.user-dirs = {
      enable = pkgs.stdenv.isDarwin;
      target = "user-dirs.dirs";
      text = ''
        XDG_DESKTOP_DIR="$env.HOME/Desktop"
        XDG_DOWNLOAD_DIR="$env.HOME/Downloads"
        XDG_TEMPLATES_DIR="env.$HOME/Templates"
        XDG_PUBLICSHARE_DIR="env.$HOME/Public"
        XDG_DOCUMENTS_DIR="$env.HOME/Documents"
        XDG_MUSIC_DIR="$env.HOME/Music"
        XDG_PICTURES_DIR="$env.HOME/Pictures"
        XDG_VIDEOS_DIR="$env.HOME/Movies"
        XDG_APPLICATIONS_DIR = "$env.HOME/Applications";
        XDG_LIBRARY_DIR = "$env.HOME/Library";
        XDG_DEVEL_DIR = "$env.HOME/Devel";
      '';
    };

  };

}