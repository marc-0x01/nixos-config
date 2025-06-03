# Pantheon: A quite elmentary but beautiful desktop manager for linux

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, ... }: {

  # Graphical Environment Services
  services = {
    
    # Xorg Configuration
    xserver = { 
      enable = true;
      # Remove dated apps in default
      excludePackages = with pkgs; [
        xterm
      ];

      # Desktop Manager
      desktopManager = {
        # Using Pantheon
        pantheon = {
          enable = true;
          debug = false;
          # Extra packages managed globally
          extraWingpanelIndicators = with pkgs; [];
          extraSwitchboardPlugs = with pkgs; [];
          # Manage GSettings for specific Apps
          extraGSettingsOverrides = "";
          extraGSettingsOverridePackages =[];
        };
      };

      # Display Manager
      displayManager = {
        # Using LightDM
        lightdm = {
          enable = true;
          greeters.pantheon.enable = true;
        };
      };

      # Keyboard and inputs
      xkb = {
        layout = "ch";
        variant = "fr";
        # Set various useful tricks
        # - terminater x with ctrl-alt-bksp
        # - use alt-shit to toggle layouts
        # - swap capslock with left control
        options = "terminate:ctrl_alt_bksp,grp:alt_shift_toggle";
      };

    };

    # Pantheon Specific Services
    pantheon = { 
      apps.enable = true;
    };
    
    # Additional Related Services
    libinput.enable = true;
    flatpak.enable = true;
  
  };

  # Additional Programs
  programs = { };  

  # Default Environment
  environment = {

    # Built-in Pantheon Apps
    pantheon = { 
      excludePackages = with pkgs.pantheon; [
        elementary-mail       # SaaS
        elementary-tasks      # using taskwarrior
        elementary-calendar   # SaaS
        elementary-music      # Using spotify
        elementary-photos     # SaaS
        elementary-camera     # Not useful
        elementary-code       # Using helix
        elementary-wallpapers # I have mine
      ];
    };

    # Related Pantheon or X Applications
    systemPackages = with pkgs;[
      pantheon-tweaks  # Additional options
      xclip            # Access X clipboard from cli
      torrential       # Torrent client
      oneko            # Just melancoly ;)
    ];

  };

}
