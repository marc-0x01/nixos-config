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
        "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" 
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
  # ...

  # Enable ZRAM
  zramSwap.enable = true;

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
        vpl-gpu-rt          # for newer GPUs on NixOS >24.05 or unstable
        # intel-media-sdk   # for older GPUs
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
          KernelExperimental = true;
        };
      };
    };

    # Networking
    networking = {
      useDHCP = true;
      #interfaces.<interface_id>.useDHCP = true;
    };

    # Enable all recommended configuration for system76 systems
    # Firmware, Power, Scheduler 
    system76.enableAll = true;

  };

}