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
        options = "terminate:ctrl_alt_bksp,grp:alt_shift_toggle, ctrl:swapcaps";
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

  # Default Environment
  environment = {

    # Built-in Pantheon Apps
    pantheon = { 
      excludePackages = with pkgs; [];
    };

    # Related Applications
    systemPackages = with pkgs;[
      xclip         # Access X clipboard from cli
      torrential    # Torrent client
      oneko         # Just melancoly ;)
    ];

  };

}