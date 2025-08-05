# Amber theme, inspired by Avalon

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, stylix, ... }: {

  stylix = {
    enable = true;
    # Theme apps by default
    autoEnable = true;
    targets = {};
    # Wallpaper!
    image = ./assets/wallpapers/amber1-5k-2880x1800.jpg;
    # Amber, old school
    base16Scheme = rec {
      scheme = "Amber Screen";
      author = "Marc Guillen (https://github.com/marc-0x01)";
      base00 = "282828"; # ----
      base01 = "2e1c00"; # ---
      base02 = "9e6c00"; # --
      base03 = "be8200"; # -
      base04 = "de9900"; # +
      base05 = "ffb000"; # ++
      base06 = "ffb940"; # +++
      base07 = "ffc15d"; # ++++
      base08 = base03;
      base09 = base04;
      base0A = base03;
      base0B = base05;
      base0C = base02;
      base0D = base04;
      base0E = base05;
      base0F = base02;
    };
    polarity = "dark";
    # Opacities
    opacity = {
       terminal = 0.85;
       desktop = 0.95;
       applications = 0.95;
       popups = 0.85;
    };
    # Fonts
    # TODO: Substitute with Benguiat fonts for an Avalon vibe
    fonts = {
      serif = {
        name = "Terminess Nerd Font";
        package = pkgs.nerd-fonts.terminus;
      };
      sansSerif = {
        name = "Terminess Nerd Font";
        package = pkgs.nerd-fonts.terminus;
      };
      monospace = {
        name = "Terminess Nerd Font";
        package = pkgs.nerd-fonts.terminus;
      };
      emoji = {
        name = "Symbols Nerd Font";
        package = pkgs.nerd-fonts.symbols-only;
      };
      # Font Sizes by context
      sizes = {
        terminal = 14;
      };
    };
  };

}
