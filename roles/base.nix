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
    };

    # Tmux: multiplexor
    tmux = {
      enable = true;
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
  # Based summerfruit theme
  stylix = {
    image = pkgs.fetchurl {
      url = "https://placehold.co/600x400/FFF/FFF/jpeg";
      sha256 = "b522de69bcb6a6db707ae7257df595aa1a63d108c5b698296346db1c220d4b8c";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/summerfruit-light.yaml";
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