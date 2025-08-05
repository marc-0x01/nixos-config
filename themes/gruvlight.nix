# Gruvbox light theme based on base16

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, stylix, ... }: {

  stylix = {
    enable = true;
    # Theme apps by default
    autoEnable = true;
    targets = {};
    # Wallpaper!
    image = ./assets/wallpapers/gruv4-5k-3840x2160.jpeg;
    # Monochrome and dark
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-light-soft.yaml";
    polarity = "light";
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