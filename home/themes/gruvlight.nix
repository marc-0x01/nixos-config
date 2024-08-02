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
    image = ./assets/wallpapers/gruv4-5k-3840x2160.jpeg;
    # Monochrome and dark
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-soft.yaml";
    polarity = "light";
    # Opacities
    opacity = {
       terminal = 0.85;
    };
    # Fonts
    fonts = {
      serif = {
        name = "Gohu Font 14 Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["Gohu"];
        };
      };
      sansSerif = {
        name = "Gohu Font 14 Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["Gohu"];
        };
      };
      monospace = {
        name = "Gohu Font 14 Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["Gohu"];
        };
      };
      emoji = {
        name = "Symbols Font 14 Nerd Font";
        package = pkgs.nerdfonts.override {
          fonts = ["NerdFontsSymbolsOnly"];
        };
      };
      # Font Sizes by context
      sizes = {
        terminal = 14;
      };
    };
  };

}