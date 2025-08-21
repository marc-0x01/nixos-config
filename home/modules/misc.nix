# Misc additional applications

{ pkgs, lib, config, osConfig, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs = {

    ## Better version of unix tools, with a rust implementation

    # Bat: Better cat (bat)
    bat = {
      enable = true;
    };

    # Bottom: Better top (btm)
    bottom = {
      enable = true;
    };
    
    # Skim: Fuzzy finder (sk)
    skim = {
      enable = true;
      enableZshIntegration = true;
    };

    # Ripgrep: Better grep (rg)
    ripgrep  = {
      enable = false; # Deactivate because of a python issue
    };      

    # TheFuck: Correct latest command (fuck)
    thefuck = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    }; 

    # Rbw: Bitwarden cli (rbw)
    rbw = {
      enable = true;
      settings = {
        email = "${osConfig.parameters.user.secondary-email}";
        pinentry = pkgs.pinentry-tty;
        lock_timeout = 3600;
      };
    };         
    
  };

}
