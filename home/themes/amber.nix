# Amber theme, inspired by Avalon

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }: {

  stylix = {
    # Theme apps by default
    autoEnable = true;
    # Wallpaper!
    image = pkgs.fetchurl {
      url = "https://images7.alphacoders.com/883/883131.jpg";
      sha256 = "d382f82c88cc646003c4c63a3fe08fe5505a14a13d9fdb72b936d5ec4a01a293";
    };
    # Monochrome and dark
    polarity = "dark";
    # Opacities
    opacity = {
       terminal = 0.90;
    };
    # Fonts
    fonts = {
      serif = {
        name = "BigBlueTermPlus Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["BigBlueTerminal" ];
        };
      };
      sansSerif = {
        name = "BigBlueTermPlus Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["BigBlueTerminal" ];
        };
      };
      monospace = {
        name = "BigBlueTermPlus Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["BigBlueTerminal" ];
        };
      };
      emoji = {
        name = "Symbols Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["NerdFontsSymbolsOnly" ];
        };
      };
      # Font Sizes by context
      sizes = {
        terminal = 13;
      };
    };
  };

}