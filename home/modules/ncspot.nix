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

  # Script to launch apps
  home.file = {
    ".local/bin/wm-open-music-player-darwin.sh" = {
      enable = true;
      executable = true;
      source = ../scripts/wm-open-music-player-darwin.sh;
      target = "${config.home.homeDirectory}/.local/bin/wm-open-music-player.sh";
    };
  };

}