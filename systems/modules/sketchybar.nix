# sketchybar: Highly flexible, customizable, fast and powerful status bar replacement for people that like playing with shell scripts

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
  
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
      FILE=/users/mguillen/.config/sketchybat/sketchybarrc && test -f $FILE && source $FILE
      ## Force all scripts to run the first time
      sketchybar --update
    '';
  };
}
