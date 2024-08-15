# Amber theme, inspired by Avalon

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }: {

  stylix = {
    enable = true;
    # Theme apps by default
    autoEnable = true;
    targets = {
      # Exception due to bug on ruby ffi
      gnome.enable = false;
    };
    # Wallpaper!
    image = pkgs.fetchurl {
      url = "https://images7.alphacoders.com/883/883131.jpg";
      sha256 = "d382f82c88cc646003c4c63a3fe08fe5505a14a13d9fdb72b936d5ec4a01a293";
    };
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
       terminal = 0.95;
       desktop = 0.95;
    };
    # Fonts
    # TODO: Substitute with Benguiat fonts for an Avalon vibe
    fonts = {
      serif = {
        name = "Terminess Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["Terminus"];
        };
      };
      sansSerif = {
        name = "Terminess Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["Terminus"];
        };
      };
      monospace = {
        name = "Terminess Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["Terminus"];
        };
      };
      emoji = {
        name = "Symbols Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["NerdFontsSymbolsOnly"];
        };
      };
      # Font Sizes by context
      sizes = {
        terminal = 15;
      };
    };
  };

}