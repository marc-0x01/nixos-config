# ncspot: Spotify on the cli

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.ncspot = {
    enable = true;
    settings = {
      # Layout
      library_tabs = ["tracks" "playlists" "browse"];
      use_nerdfont = false;
      hide_display_names = true;
      # Notification
      notify = false;
      # Keybindings
      default_keybindings = true;
      # Default playback
      shuffle = true;
      gapless = true;
      repeat = "playlist";
    };
  };

}