# Base configuration for every situation

{ pkgs, lib, nixpkgs, nixpkgs-unstable, nur, nix-darwin, ... }: {
  
  # Default Shell: zsh
  environment.shells = with pkgs; [ zsh ];

  # System level base programs
  programs = {

    # Zsh: standard shell
    zsh = {
      enable = true;
    };

    # Vim: visual instrument
    vim = {
      enable = true;
      enableSensible = true; 
      vimConfig = '''';
    };

    # Tmux: multiplexor
    tmux = {
      enable = true;
      enableSensible = true;
      enableVim = true;
      extraConfig = '''';
    };

  };

  # Common unix cli tools for any situation
  # Only optional for IEEE Std 1003.1-2008
  environment.systemPackages = with pkgs; [         
    git
    less
    curl
    wget
    htop
    tree
    python3
    openssh
    unzip
    rsync
    mosh
    jq
  ];

  # Genrate system-level theme
  # Based on funky image
  stylix = {
    image = pkgs.fetchurl {
      url = "https://images.pexels.com/photos/1335971/pexels-photo-1335971.jpeg";
      sha256 = "9a7fe80946c6664cd20320c15f6a98a7374203e8689ad2f99c62ec2b570804bc";
    };
  };

  # Set default environement variables 
  environment.variables = { 
    EDITOR = lib.mkDefault "vim";
    VISUAL = lib.mkDefault "vim";
    PAGER = lib.mkDefault "less -R";
  };

  # Post-activation commands  
  system.activationScripts.postActivation.text = ''
    # Change the default shell for root
    sudo chsh -s ${pkgs.zsh}/bin/zsh
  '';

}