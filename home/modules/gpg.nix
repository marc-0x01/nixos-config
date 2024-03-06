 # gpg: GNU Privacy Guard
 
 { pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {
   
   # Not using GPG anymore, replaced by 
   # - "age" (rage implementation) for file/blob encryption
   # - "minisign" (rsign implementation) for signing messages
   programs.gpg.enable = false;

 }