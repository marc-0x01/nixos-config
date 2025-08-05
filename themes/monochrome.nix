# Monochrome theme based on base16

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, stylix, ... }: {

  stylix = {
    enable = true;
    # Theme apps by default
    autoEnable = true;
    targets = {};
    # Wallpaper!
    image = ./assets/wallpapers/monochrome1-5k-2880x1800.jpg;
    # Monochrome and dark
    base16Scheme = "${pkgs.base16-schemes}/share/themes/grayscale-dark.yaml";
    polarity = "dark";
    # Opacities
    opacity = {
       terminal = 0.85;
       desktop = 0.95;
       applications = 0.95;
       popups = 0.85;
    };
    # Fonts
    fonts = {
      serif = {
        name = "SauceCodePro Nerd Font";
        package = pkgs.nerd-fonts.sauce-code-pro;
      };
      sansSerif = {
        name = "SauceCodePro Nerd Font";
        package = pkgs.nerd-fonts.sauce-code-pro;
      };
      monospace = {
        name = "SauceCodePro Nerd Font";
        package = pkgs.nerd-fonts.sauce-code-pro;
      };
      emoji = {
        name = "Symbols Nerd Font";
        package = pkgs.nerd-fonts.symbols-only;
      };
      # Font Sizes by context
      sizes = {
        terminal = 13;
      };
    };
  };

}