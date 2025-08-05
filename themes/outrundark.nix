# Gruvbox dark theme based on base16

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, stylix, ... }: {

  stylix = {
    enable = true;
    # Theme apps by default
    autoEnable = true;
    targets = {};
    # Wallpaper!
    image = ./assets/wallpapers/outrun1-4k-3840x2160.jpg;
    # Monochrome and dark
    base16Scheme = "${pkgs.base16-schemes}/share/themes/outrun-dark.yaml";
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
        name = "ShureTechMono Nerd Font";
        package = pkgs.nerd-fonts.share-tech-mono;
      };
      sansSerif = {
        name = "ShureTechMono Nerd Font";
        package = pkgs.nerd-fonts.share-tech-mono;
      };
      monospace = {
        name = "ShureTechMono Nerd Font";
        package = pkgs.nerd-fonts.share-tech-mono;
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