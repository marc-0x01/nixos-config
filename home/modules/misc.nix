# misc: Additional programs and scripts

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
   
  # Misc scripts, usually launch scripts are in the respective programs modules
  # Darwin Flavour
  home.file = {
    ".local/bin/wm-lock.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ../scripts/wm-lock-darwin.sh;
      target = "${config.home.homeDirectory}/.local/bin/wm-lock.sh";
    };
    ".local/bin/wm-shutdown.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ../scripts/wm-shutdown-darwin.sh;
      target = "${config.home.homeDirectory}/.local/bin/wm-shutdown.sh";
    };
    ".local/bin/wm-open-file-manager-darwin.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ../scripts/wm-open-file-manager-darwin.sh;
      target = "${config.home.homeDirectory}/.local/bin/wm-open-file-manager.sh";
    };
    ".local/bin/wm-open-digital-garden-darwin.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ../scripts/wm-open-digital-garden-darwin.sh;
      target = "${config.home.homeDirectory}/.local/bin/wm-open-digital-garden.sh";
    };
  };

}