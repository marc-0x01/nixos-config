

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
  
  # yabai: Tiling window management for the Mac
  services.yabai = {
    enable = true; 
    enableScriptingAddition = true;
    # Standard config
    config = {
      # Layout
      layout = "bsp";
      auto_balance = "off";
      split_ratio = 0.50;
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;
      # Mouse   
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      # Windows
      window_opacity = "off";
      active_window_opacity = 1.0;
      normal_window_opacity = 0.9;
      window_shadow = "off";
      external_bar = "all:37:0";
    };
    # Rules and Signals
    extraConfig = ''
      # Rules
      yabai -m rule --add label="Finder" app="^Finder$" manage=off
      yabai -m rule --add label="Safari" app="^Safari$" title="^(General|(Tab|Password|Website|Extension)s|AutoFill|Se(arch|curity)|Privacy|Advance)$" manage=off
      yabai -m rule --add label="System Settings" app="^System Settings$" title=".*" manage=off
      yabai -m rule --add label="App Store" app="^App Store$" manage=off
      yabai -m rule --add label="Activity Monitor" app="^Activity Monitor$" manage=off
      yabai -m rule --add label="Calculator" app="^Calculator$" manage=off
      yabai -m rule --add label="Dictionary" app="^Dictionary$" manage=off
      yabai -m rule --add label="Software Update" title="Software Update" manage=off
      yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
      # Signals
      # yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      # yabai -m signal --add event=display_changed action=""
      # yabai -m signal --add event=space_changed action=""
      # yabai -m signal --add event=window_created action=""
      # yabai -m signal --add event=window_destroyed action=""
      # yabai -m signal --add event=window_focused action=""
    '';
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Window new
      alt - return : alacritty &
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
      shift + alt - escape : yabai -m window --space last; yabai -m space --focus last
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

  # sketchybar: Highly flexible, customizable, fast and powerful status bar replacement for people that like playing with shell scripts
  services.sketchybar = {
    enable = true;
    # All in one config
    config = ''
      ## General Appearance and Defaults
      # Bar Appearance
      sketchybar --bar \
        height=37         \
        position=top      \
        sticky=off        \
        y_offset=-1       \
        padding_left=10   \
        padding_right=10  \
        color=0xff
      # Changing Defaults
      sketchybar --default \
        icon.font="SF Pro:Semibold:15.0"      \
        icon.color=0xffffffff                 \
        label.font="SF Pro:Semibold:15.0"     \
        label.color=0xffffffff                \
        background.color=0xff                 \
        background.corner_radius=5            \
        background.height=24                  \
        padding_left=5                        \
        padding_right=5                       \
        label.padding_left=4                  \
        label.padding_right=10                \
        icon.padding_left=10                  \
        icon.padding_right=4
      ## Source theme specific configuration in home space
      FILE=/users/mguillen/.config/sketchybar/sketchybarrc && test -f $FILE && source $FILE
      ## Force all scripts to run the first time
      sketchybar --update
    '';
  };

  

}