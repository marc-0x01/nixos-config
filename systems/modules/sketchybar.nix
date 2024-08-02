# sketchybar: Highly flexible, customizable, fast and powerful status bar replacement for people that like playing with shell scripts

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
  
  services.sketchybar = {
    enable = true;
    # All in one config
    config = ''
        ## General Appearance and Defaults
        # Bar Appearance
        sketchybar --bar      \
            height=38         \
            position=top      \
            sticky=off        \
            y_offset=-1       \
            padding_left=20   \
            padding_right=-1  \
            color=0xff
        # Changing Defaults
        sketchybar --default \
            icon.font="Helvetica:Regular:15.0"  \
            icon.padding_left=-1                \
            icon.padding_right=-1               \
            label.font="Helvetica:Regular:15.0"
        ## Items
        # No Custom Items
        ## Layouts
        # Left Items
        sketchybar --add item logo left
        sketchybar --set logo \
            label.string="(oO,) \,,/" \
            label.color=0xff000000    \
            label.font.style=Bold
        # Notch Items
        # Nothing in notch area!
        # Right Items
        sketchybar --add alias "Control Center,Clock" right
        sketchybar --add alias "Control Center,WiFi" right
        sketchybar --add alias "Control Center,Battery" right
        sketchybar --add alias "Control Center,Sound" right
        ## Force all scripts to run the first time
        sketchybar --update
    '';
  };
}
