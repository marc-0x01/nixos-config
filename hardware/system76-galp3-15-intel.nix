# Hardware tweaks for System76 Galago Pro

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, ... }: {

  # Boot: EFI, initrd, systemd
  boot = {

    # Loader
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 15;
      };
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };

    # Init
    initrd = { 
      availableKernelModules = [ 
        "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"
      ];
      kernelModules = [];
    };

    # Kernel Modules
    kernelModules = [ 
      "kvm-intel" 
    ];
    extraModulePackages = with pkgs; [];

    # Clean /tmp on boot
    tmp.cleanOnBoot = true;

  };

  # Filesystems
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/76dd494e-636e-487f-b2f8-a0301b134a23";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/58AA-D37C";
      fsType = "vfat";
      options = [
        "fmask=0077" 
        "dmask=0077"
      ];
    };
  };

  # SWAP
  swapDevices = [];
  zramSwap.enable = true;

  # Networking
  networking = {
    useDHCP = lib.mkDefault false;
    interfaces.wlp59s0.useDHCP = lib.mkDefault true;    # wifi
    interfaces.enp58s0f1.useDHCP = lib.mkDefault true;  # ethernet
  };

  # Harware Configuration
  hardware = { 
    
    # CPU
    cpu.intel = {
      updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

    # Graphics
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        # Open GL, Vulkan and VAAPI drivers
        onevpl-intel-gpu
      ];
    };

    # Audio
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };

    # Bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      disabledPlugins = [];
      settings = {
        General = {
          JustWorksRepairing = "always";
          MultiProfile = "multiple";
          Experimental = true;
        };
      };
    };

    # Enable all recommended configuration for system76 systems
    # Firmware, Power, Scheduler 
    system76.enableAll = true;

  };

}