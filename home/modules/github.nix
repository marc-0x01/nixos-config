# github: Let's build from here 

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.gh = {
    enable = true;
    extensions = with pkgs; [ 
      # Quite limited option for now by default
      # look for OSPO tools gh-net, gh-sbom
      gh-eco
    ];
  };

}