# ssh: Secure Shell

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.ssh = {
    enable = true;
    # Defaults
    forwardAgent = false;
    compression = false;
    controlMaster = "no";
    controlPersist = "no";
    hashKnownHosts = true;
    # More defaults
    extraConfig = "";
    # Specify per-host settings
    matchBlocks = {
      # Personnal prof1iles
      "github.com-0x01" = {
        host = "github.com"; 
        compression = true;
        user = "marc-0x01";
        identitiesOnly = true;
        identityFile = "~/.ssh/id-ed25519.key";
      };
      "0x01.cloud" = {
        host = "*.0x01.cloud"; 
        compression = true;
        user = "marc-0x01";
        identitiesOnly = true;
        identityFile = "~/.ssh/id-ed25519.key";
      };
      # Professional profiles
      "github.com-work" = {
        host = "github.com"; 
        compression = true;
        user = "mguillen";
        identitiesOnly = true;
        identityFile = "~/.ssh/id-ed25519-work.key";
      };
    };
  };

  # Script to fetch keys from vault
  home.file = {
    ".local/bin/ssh-setup.sh" = {
      enable = true;
      executable = true;
      source = ./scripts/ssh-setup.sh;
      target = "${config.home.homeDirectory}/.local/bin/ssh-setup.sh";
    };
  };

}