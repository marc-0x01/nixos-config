# Configuration for main personnal system on Linux/Nixos

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, nur, home-manager, stylix, ... }: {

  # Set the system arch/os
  nixpkgs.hostPlatform = {
    system = "x86_64-linux";
  };

  # Locale
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {};
  };
  time.timeZone = "Europe/Zurich";
  
  # Console
  console = {
    earlySetup = true;
    # Internationalisation
    font = "Lat2-Terminus16";
    keyMap = "fr_CH";
    useXkbConfig = config.services.xserver.enable;
  };

  # Netwoking
  networking = {

    # Names
    computerName = "WackBox";
    hostName = "wackobox";

    # Hosts mappings
    hosts = {
      "127.0.0.1" = [ "localhost" "wackbox.local" ];
    };

    # Proxy
    proxy.default = null;

    # Firewall
    nftables.enable = false; # iptables required for containers
    firewall = {
      enable = true;
      # Incoming allowance, treat as exceptions
      allowPing = true;
      allowedTCPPorts = [];
      allowedTCPPortRanges = [];
      allowedUDPPorts = [];
      allowedUDPPortRanges = [];
    };

    # NetworkManager
    networkmanager = {
      enable = true;
      wifi = {
        backend = "wpa_supplicant";
        macAddress = "stable-ssid"; # Generate MAC
      };
      # Additional config if needed
      settings = {};
    };

  };

  # Sound
  sound = {
    enable = true;
    mediaKeys = {
      enable = !config.services.xserver.enable;
      volumeStep = "5%";
    }; 
  };

  # Vitualization
  virtualisation = {
    libvirtd = {           # Machine emulation and vitualizer
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
      };
    }; 
    podman.enable = true;   # Containers, replacement for Docker
  };

  # Common Services
  services = {

    # Power Management
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
        #Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 40;   # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80;    # 80 and above it stops charging
      };
    };

    # Print: enable CUPS
    printing = {
      enable = true;
      drivers = []; 
    };

    # eOOM: Early out of memory prevention
    earlyoom = {
      enable = true;
      enableNotifications = true;
      freeSwapThreshold = 10;
      freeMemThreshold = 10;
      extraArgs =
        let
          catPatterns = patterns: builtins.concatStringsSep "|" patterns;
          preferPatterns = [
            "java"
            "rust-analyzer"
          ];
          avoidPatterns = [
            "bash"
            "sshd"
            "systemd"
            "systemd-logind"
            "systemd-udevd"
          ];
        in
        [
          "--prefer '^(${catPatterns preferPatterns})$'"
          "--avoid '^(${catPatterns avoidPatterns})$'"
        ];
    };

    # Other daemon...
    thermald.enable = true;         # Temperature

  };

  # Security
  security = {

    # No sudo for wheel users
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };

    # RTKit enable for audio
    rtkit.enable = true;

  };

  # Do not generate documentation
  documentation.enable = false;

  # System specific environment Variables
  environment.variables = { 
    X01_SYSTEM = "wackbox-0x01";
  };

  # This system is a workstation
  imports = [
    # Hardware
    ../hardware/system76-galp3-15-intel.nix
    # Roles 
    ../roles/base.nix
    # Graphical Environment
    ./modules/linux/pantheon.nix
    # Apply home settings, OS agnostic
    ../home/home.nix
  ];

  # Additional system-wide Packages
  environment.systemPackages = with pkgs; [];

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

  # User account
  users.users.mguillen = {
    name = "mguillen";
    home = "/home/mguillen";
    description = "Marc Guillen";
    shell = pkgs.nushell;
    isNormalUser = true;
    extraGroups = [ 
      "wheel" 
      "NetworkManager"
    ];
  };

  # State Version, Don't change!
  system.stateVersion = "24.05";

  # Post-Activation Commands
  # - Avoid a logout/login cycle when building the config
  system.activationScripts.postUserActivation.text = ''
  '';
}