# sketchybar: Highly flexible, customizable, fast and powerful status bar replacement for people that like playing with shell scripts

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
  
  services.sketchybar = {
    enable = true;
    # All in one config
    config = ''
        ## General Appearance and Defaults
        # Bar Appearance
        sketchybar --bar     \ 
            height=37        \
            blur_radius=30   \
            position=top     \
            sticky=on        \
            padding_left=10  \
            padding_right=10 \
            color=0xff101314
        # Changing Defaults
        sketchybar --default \ 
            icon.font="SF Pro:Semibold:15.0"  \
            icon.color=WHITE=0xffffffff       \
            label.font="SF Pro:Semibold:15.0" \
            label.color=WHITE=0xffffffff      \
            background.color=0xff353c3f       \
            background.corner_radius=5        \
            background.height=24              \
            padding_left=5                    \
            padding_right=5                   \
            label.padding_left=4              \
            label.padding_right=10            \
            icon.padding_left=10              \
            icon.padding_right=4
        ## Items
        # TODO
        ## Layouts
        # Left Items
        # TODO
        # Notch Items
        # TODO
        # Right Items
        # TODO
        ## Force all scripts to run the first time
        sketchybar --update
    '';
  };
}
