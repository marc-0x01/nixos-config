# skhd: Simple hotkey daemon for macOS

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
  
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Window new
      alt - return : /Users/mguillen/.local/bin/wm-open-term.sh 
      alt - b : /Users/mguillen/.local/bin/wm-open-web-browser.sh
      alt - u : /Users/mguillen/.local/bin/wm-open-music-player.sh
      alt - e : /Users/mguillen/.local/bin/wm-open-file-manager.sh
      alt - o : /Users/mguillen/.local/bin/wm-open-digital-garden.sh
      alt - c : /Users/mguillen/.local/bin/wm.open-code-editor.sh
      shift + alt - l : /Users/mguillen/.local/bin/wm-lock.sh
      shift + alt - e : /Users/mguillen/.local/bin/wm-shutdown.sh
      # Windows close
      alt - w : yabai -m window --close
      # Windows Float Unfloat
      alt - m : yabai -m window --toggle float
      # Windows Fullscreen
      alt - f : yabai -m window --toggle zoom-fullscreen
      shift + alt - f : yabai -m window --toggle native-fullscreen
      # Windows focus
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east
      alt - escape : yabai -m window --focus recent
      # Windows moving
      shift + alt - h : yabai -m window --warp west
      shift + alt - j : yabai -m window --warp south
      shift + alt - k : yabai -m window --warp north
      shift + alt - l : yabai -m window --warp east 
      # Windows moving to space
      shift + alt - espace : yabai -m window --space last; yabai -m space --focus last
      shift + alt - p : yabai -m window --space prev; yabai -m space --focus prev
      shift + alt - n : yabai -m window --space next; yabai -m space --focus next
      shift + alt - 1 : yabai -m window --space 1; yabai -m space --focus 1
      shift + alt - 2 : yabai -m window --space 2; yabai -m space --focus 2
      shift + alt - 3 : yabai -m window --space 3; yabai -m space --focus 3
      shift + alt - 4 : yabai -m window --space 4; yabai -m space --focus 4
      # Windows - resize
      ctrl + alt - h : yabai -m window --resize left:-50:0; \
                       yabai -m window --resize right:-50:0
      ctrl + alt - j : yabai -m window --resize bottom:0:50; \
                       yabai -m window --resize top:0:50
      ctrl + alt - k : yabai -m window --resize top:0:-50; \
                       yabai -m window --resize bottom:0:-50
      ctrl + alt - l : yabai -m window --resize right:50:0; \
                       yabai -m window --resize left:50:0
      # Windows balance or rotate
      ctrl + alt - b : yabai -m space --balance
      alt - r         : yabai -m space --rotate 270
      shift + alt - r : yabai -m space --rotate 90
      shift + alt - x : yabai -m space --mirror x-axis
      shift + alt - y : yabai -m space --mirror y-axis
      # Windows insertion point
      shift + ctrl + alt - h : yabai -m window --insert west
      shift + ctrl + alt - j : yabai -m window --insert south
      shift + ctrl + alt - k : yabai -m window --insert north
      shift + ctrl + alt - l : yabai -m window --insert east
      # Restart Yabai
      shift + alt - r : yabai --restart-service
    '';
  };
}
