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
      "github.com" = {
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
    };
  };

}