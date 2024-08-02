# Monochrome theme based on base16

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
    image = ./assets/wallpapers/monochrome1-5k-2880x1800.jpg;
    # Monochrome and dark
    base16Scheme = "${pkgs.base16-schemes}/share/themes/grayscale-dark.yaml";
    polarity = "dark";
    # Opacities
    opacity = {
       terminal = 0.85;
    };
    # Fonts
    fonts = {
      serif = {
        name = "SauceCodePro Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["SourceCodePro"];
        };
      };
      sansSerif = {
        name = "SauceCodePro Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["SourceCodePro"];
        };
      };
      monospace = {
        name = "SauceCodePro Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["SourceCodePro"];
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
        terminal = 13;
      };
    };
  };

}