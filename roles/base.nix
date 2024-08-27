# Base configuration for every situation

{ pkgs, lib, nixpkgs, nixpkgs-unstable, nur, nix-darwin, ... }: {
  
  # Default Shell: zsh
  environment.shells = with pkgs; [ zsh ];

  # Default environement variables 
  environment.variables = { 
    EDITOR = lib.mkForce "vim";
    VISUAL = lib.mkForce "vim";
    PAGER = lib.mkForce "less -R";
  };

  ## System level base programs
  # - Unix Trinity withour any defaults

  programs = {

    # Zsh: Standard shell
    zsh = {
      enable = true;
    };

    # Vim: Editor
    # Should be there anyway in any system

    # Tmux: Terminal Multiplexor
    tmux = {
      enable = true;
    };

  };

  # Common unix cli tools for any situation
  # - Only optional for IEEE Std 1003.1-2008
  environment.systemPackages = with pkgs; [
    vim # Just in case         
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


  ## Theme ##
  # - Genrate system-level theme
  # - Based on summerfruit!

  stylix = {

    # Dummy image
    image = pkgs.fetchurl {
      url = "https://placehold.co/600x400/FFF/FFF/jpeg";
      sha256 = "b522de69bcb6a6db707ae7257df595aa1a63d108c5b698296346db1c220d4b8c";
    };

    # The actual base16 scheme
    base16Scheme = "${pkgs.base16-schemes}/share/themes/summerfruit-light.yaml";

  };

}