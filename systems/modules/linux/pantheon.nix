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
          enable = false;
          greeters.pantheon.enable = true;
        };
      };

      # Keyboard and inputs
      libinput.enable = true;
      xkb = {
        layout = "fr_CH";
        options = "";
      };

    };

    # Pantheon Specific Services
    pantheon = { 
      apps.enable = true;
    };
    
    # Additional Related Services
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