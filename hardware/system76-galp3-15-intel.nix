# Hardware tweaks for System76 Galago Pro

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, ... }: {

  # Harware Configuration
  hardware = { 
    
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
    pulseaudio.enable = true;

    # Enable all recommended configuration for system76 systems
    system76.enableAll = true;
    
  };

}