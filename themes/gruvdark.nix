# Gruvbox dark theme based on base16

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, stylix, ... }: {

  stylix = {
    enable = true;
    # Theme apps by default
    autoEnable = true;
    targets = {};
    # Wallpaper!
    image = ./assets/wallpapers/gruv7-4k-1920x1080.png;
    # Monochrome and dark
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
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
        name = "GohuFont 14 Nerd Font";
        package = pkgs.nerd-fonts.gohu;
      };
      sansSerif = {
        name = "GohuFont 14 Nerd Font";
        package = pkgs.nerd-fonts.gohu;
      };
      monospace = {
        name = "GohuFont 14 Nerd Font";
        package = pkgs.nerd-fonts.gohu;
      };
      emoji = {
        name = "Symbols Font 14 Nerd Font";
        package = pkgs.nerd-fonts.symbols-only;
      };
      # Font Sizes by context
      sizes = {
        terminal = 14;
      };
    };
  };

}