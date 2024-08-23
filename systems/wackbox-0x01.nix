# Configuration for main personnal system on Linux/Nixos

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, nur, home-manager, stylix, ... }: {

  # Set the system arch/os
  nixpkgs.hostPlatform = {
    system = "x86_64-linux";
  };

  # Boot: EFI, initrd, systemd
  boot = {

    # Loader
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 50;
      };
      efi.canTouchEfiVariables = true;
    };

    # Init
    initrd = { 
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "v4l2loopback" ];
    };

    # Kernel
    kernelModules = [ "uinput" "v4l2loopback" ];
    extraModulePackages = with pkgs; [ 
      linuxPackages.v4l2loopback
    ];

  };

  # Set the time zone
  time.timeZone = "Europe/Zurich";

  # Networking
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
    nftables.enable = false;
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
    qemu.enable = true;     # Machine emulation and vitualizer
    podman.enable = true;   # Containers, replacement for Docker
  };

  # Common Services
  services = {
    # Print: enable CUPS
    printing = {
      enable = true;
      drivers = []; 
    };
  };

  # Security
  security = {
    # No sudo for wheel users
    sudo = {
      enable = true;
      extraRules = [{
        commands = [
          {
           command = "${pkgs.systemd}/bin/reboot";
           options = [ "NOPASSWD" ];
          }
        ];
        groups = [ "wheel" ];
      }];
    };
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

  # State Version, Don't change!
  system.stateVersion = "24.05";

  # Post-Activation Commands
  # - Avoid a logout/login cycle when building the config
  system.activationScripts.postUserActivation.text = ''
  '';
}