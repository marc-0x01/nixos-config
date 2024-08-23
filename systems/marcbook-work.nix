# Configuration for main work system on Darwin/OSX

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, nur, nix-darwin, home-manager, stylix, ... }: {

  # Set the system arch/os
  nixpkgs.hostPlatform = {
    config = "aarch64-apple-darwin";
    system = "aarch64-darwin";
  };

  # Auto upgrade the nix deamon and packages, required on darwin
  services.nix-daemon.enable = true;

 # Networking
  networking = {
    computerName = "MarcBook";
    hostName = "marcbook";
  };

  # System specific environment Variables
  environment.variables = { 
    X01_SYSTEM = "marcbook-work";
  };

  # Do not generate documentation
  documentation.enable = false;

  # This system is a workstation
  imports = [
    # Hardware
    ../hardware/macbook-pro-16-m3.nix
    # Roles 
    ../roles/base.nix
    # Graphical Environment
    # Well builtin OSX
    # Additional global services
    ./modules/darwin/yabai.nix
    ./modules/darwin/skhd.nix
    ./modules/darwin/sketchybar.nix
    # Apply home settings, OS agnostic
    ../home/home.nix
  ];

  # Additional system-wide Packages
  # There is no virtualization config on nix-darwin
  environment.systemPackages = with pkgs; [
    qemu     # Machine emulation and vitualizer
    podman   # Containers, replacement for Docker         
    # OSX specific
    m-cli    # System cli interaction in scripts
  ];

  # Security
  security = {
    pam = { 
      # TouchId when you need to provide Sudo password
      enableSudoTouchIdAuth = true; 
    }; 
  };

  # Fonts
  # Selection of good terminal/coding fonts
  fonts = {                              
    packages = with pkgs; [
      monoid
      font-awesome
      (nerdfonts.override {
        fonts = [
          "Monoid"
        ];
      })
    ];
  };

  # Specific OSX System default settings
  # Some settings are commented and not authorized since the device is managed
  system = {

    # Software Update
    defaults.SoftwareUpdate = {
      AutomaticallyInstallMacOSUpdates = true;
    };

    # Core services
    defaults.LaunchServices = {
        # Keep Application quarantiine for work
        LSQuarantine = true;
    };

    # Global Namespace Settings
    defaults.NSGlobalDomain = {
      # Set the style to ‘Dark’ to enable dark mode, or leave unset for normal mode.
      AppleInterfaceStyle = null;
      # When to display scroll bars
      AppleShowScrollBars = "WhenScrolling";
      # Device Input key repeat
      InitialKeyRepeat = 25;
      KeyRepeat = 6;
    };

    # Login
    defaults.loginwindow = {
      # Displays login window as a name and password
      SHOWFULLNAME = true;
      # Security: No Guest account
      GuestEnabled = false;
      # Security: No console access
      DisableConsoleAccess = true;
    };

    # Dock and Desktop
    defaults.dock = {
      # General dock
      orientation = "left";
      show-recents = false;
      minimize-to-application = true;
      show-process-indicators = true;
      # Switcher only, enable if using skhd to launch apps
      static-only = true; 
      # Automatically hide and show the dock
      autohide = true;
      autohide-delay = 0.1;
      autohide-time-modifier = 0.7;
      # Animation and content
      launchanim = false;
      magnification = false;
      mineffect = "suck";
      # Make icons of hidden applications tranclucent
      showhidden = true;
      # Size of the icons in the dock
      tilesize = 36;
      largesize = 42;
      # hot corners
      wvous-tl-corner = 1;  # Disable
      wvous-tr-corner = 1;  # Disable
      wvous-bl-corner = 13; # Lock Screen
      wvous-br-corner = 1;  # Disable
      # Mission Control
      expose-group-by-app = true;
      expose-animation-duration = 0.1;
      # Do not rearrange spaces based on use
      mru-spaces = false;
    };

    # Spaces
    defaults.spaces = {
      # Each physical display has a separate space
      spans-displays = false;
    }; 

    # Screensaver
    defaults.screensaver = {
      # Prompt for a password when the screen saver is unlocked
      askForPassword = true;
      askForPasswordDelay = 0;
    };

    # Clock
    defaults.menuExtraClock = {
      # Like that little round thing
      IsAnalog = true;
      # If digital
      Show24Hour = true;
      ShowAMPM = false;
      ShowDate = 0;
    };

    # Finder and desktop icons
    defaults.finder = {
      # Prefered view : Lists
      FXPreferredViewStyle = "Nlsv";
      # Allow quitting of the Finder
      QuitMenuItem = true;
      # Do not create icons in the desktop
      CreateDesktop = false;
      # File and extensions options
      AppleShowAllFiles = false;
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      # Display options
      ShowStatusBar = false;
      ShowPathbar = false;
    };

    # Accessibility
    # BLOCKED for worked
    defaults.universalaccess = {
      # Bigger cursor for readability
      # mouseDriverCursorSize = 1.5;
    };

    defaults.screencapture = {
      # File type
      type = "png";
      # Location of the screen captures
      location = "$HOME/Pictures/screeshots";
      # No drop shadows in screen captures
      disable-shadow = true;
    };

    # Keyboard
    keyboard = { 
      # Enable key remapping, for skhd
      # https://developer.apple.com/library/archive/technotes/tn2450/_index.html
      enableKeyMapping = true;
      remapCapsLockToControl = true;
      userKeyMapping = [];
    };

    # Trackpad
    defaults.trackpad = {
      # Enable trackpad tap to click
      Clicking = true;
      # Enable trackpad right click
      TrackpadRightClick = true;
      # Silent clicking
      ActuationStrength = 0;
      # Thresholds : 0 light, 1 normal, 2 firm
      FirstClickThreshold = 0;
      SecondClickThreshold = 1;
    };

    # Magicmouse
    defaults.magicmouse = {
      # Enable right click, i.e. "TwoButton"
      MouseButtonMode = "TwoButton";
    };

    ## Fine tuning, misc tweaks
    # Global Namespace, misc scattered settings

    defaults.CustomSystemPreferences = {
      "NSGlobalDomain" = {
        #Set accent color to graphite
        AppleAccentColor = -1;
        # Autohide the menu bar
        AppleMenuBarVisibleInFullscreen = false;
        _HIHideMenuBar = true;
        # Reduce animation for the tilling manager
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowResizeTime = 0.001;
        # Sets the size of the finder sidebar icons
        NSTableViewDefaultSizeMode = 1;
        # Disable saving to iCloud by default
        NSDocumentSaveNewDocumentsToCloud = false;
        # Disable "smart" annoying autocorrection for developpers
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        # Enable hidden feature useful for developpers
        NSNavPanelExpandedStateForSaveMode = true;
        NSTextShowsControlCharacters = true;
      };
      "com.apple.sound.beep" = {
        # No Beep
        volume = 0.0;
        feedback = 0;
      };
      "com.apple.SoftwareUpdate" = {
        # Check for software updates daily, not just once per week
        ScheduleFrequency = 1;
      };
      "com.apple.systempreferences" = {
        # Disable system-wide resume
        NSQuitAlwaysKeepsWindows = false;
      };
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.ImageCapture" = {
        # Prevent Photos from opening automatically when devices are plugged in
        disableHotPlug = true;
      };
      "com.apple.print.PrintingPrefs" = {
        # Automatically quit printer app once the print jobs complete
        "Quit When Finished" = true;
      };
      "com.apple.dock" = {
        # Disable switching workspace automatically
        workspaces-auto-swoosh = false;
      };
      "com.apple.finder" = {
        # Disable animation, required for yabai
        DisableAllAnimations = true;
      };
    };

  };

  # User account
  users.users.mguillen = {
    name = "mguillen";
    home = "/Users/mguillen";
    description = "Marc Guillen";
    shell = pkgs.nushell;
  };

  # Post-Activation Commands
  # - Avoid a logout/login cycle when building the config
  system.activationScripts.postUserActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}