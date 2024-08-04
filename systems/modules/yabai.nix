# yabai: Tiling window management for the Mac

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

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
      external_bar = "all:37:0"
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

}