# Main Nix Flake to rule all configurations

{

  description = "Marc's systems configurations";

  #nixConfig = (import ./common/nix-config.nix);

  inputs = {

    # Used by the core system config
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    # Community packaages, mostly use for addons
    nur = {
      url = github:nix-community/NUR;
    };

    # Used by nix-darwin for Apple Systems
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Used for secrets on servers
    agenix ={
      url = "github:ryantm/agenix";
    };

    # Used by home-manager, well to manages home
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Used for styling apps, Unix Porn
    stylix = {
      url = "github:danth/stylix/release-24.05";
    }; 

    # Used by devenv for development environments
    devenv = {
      url = "github:cachix/devenv";
    };

    # Rust complete toolchain, rustup replacement
    fenix = {
      url = github:nix-community/fenix;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Overlays
    # No overlays for now
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nur, agenix, nix-darwin,
              home-manager, stylix, devenv, fenix, mozilla, ... } @ inputs: { 

    ## Entrypoint for marcbook-work
    # run with 
    # $ darwin-rebuild switch --flake .#marcbook-work
    # $ nix run nix-darwin -- switch --flake .#marcbook-work

    darwinConfigurations.marcbook-work = nix-darwin.lib.darwinSystem {
      inherit inputs;
      modules = [
        # Configurartion Modules
        ./common/nix-config.nix
        ./systems/marcbook-work.nix
        # Modules
        home-manager.darwinModules.home-manager
        stylix.darwinModules.stylix
        agenix.nixosModules.default
        nur.hmModules.nur
        # Base Modules
        {
          # Nix Config
          nixpkgs.config = {
            allowUnfree = true;
            allowBroken = false;
            allowInsecure = false;
            allowUnsupportedSystem = false;
          };
          # Nix Overlays
          nixpkgs.overlays = [
            nur.overlay
            (final: prev: {
              # Better keep it on closer to the edge
              yabai = nixpkgs-unstable.legacyPackages."aarch64-darwin".yabai;
              skhd = nixpkgs-unstable.legacyPackages."aarch64-darwin".skhd;
              sketchybar = nixpkgs-unstable.legacyPackages."aarch64-darwin".sketchybar;
              qutebrowser = nixpkgs-unstable.legacyPackages."aarch64-darwin".qutebrowser;
            })
          ]; 
          # Home Manager Config
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = 
          # Adding custom modules, until merged in currrent release
            let path = ./overlays/hm; in with builtins;
            map (n: import (path + ("/" + n)))
                (filter (n: match ".*\\.nix" n != null)
                        (attrNames (readDir path)));
        }
      ];
    };

    ### Entrypoint for marcbook-0x01
    # run with 
    # $ darwin-rebuild switch --flake .#marcbook-0x01
    # $ nix run nix-darwin  -- switch --flake .#marcbook-0x01

    darwinConfigurations.marcbook-0x01 = nix-darwin.lib.darwinSystem {
      inherit inputs;
      modules = [
        # Configurartion Modules
        ./common/nix-config.nix
        ./systems/marcbook-0x01.nix
        # Modules
        home-manager.darwinModules.home-manager
        stylix.darwinModules.stylix
        agenix.nixosModules.default
        nur.hmModules.nur
        # Base Modules
        {
          # Nix Config
          nixpkgs.config = {
            allowUnfree = true;
            allowBroken = false;
            allowInsecure = false;
            allowUnsupportedSystem = false;
          };
          # Nix Overlays
          nixpkgs.overlays = [
            nur.overlay
            (final: prev: {
              # Better keep it on closer to the edge
              yabai = nixpkgs-unstable.legacyPackages."aarch64-darwin".yabai;
              skhd = nixpkgs-unstable.legacyPackages."aarch64-darwin".skhd;
              sketchybar = nixpkgs-unstable.legacyPackages."aarch64-darwin".sketchybar;
              qutebrowser = nixpkgs-unstable.legacyPackages."aarch64-darwin".qutebrowser;
            })
          ]; 
          # Home Manager Config
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = 
          # Adding custom modules, until merged in currrent release
            let path = ./overlays/hm; in with builtins;
            map (n: import (path + ("/" + n)))
                (filter (n: match ".*\\.nix" n != null)
                        (attrNames (readDir path)));
        }
      ];
    };

    ### Entrypoint for devenv    
    # run with 
    # $ nix develop --impure .#<devenv>

    devShells.aarch64-darwin.nix = devenv.lib.mkShell {
      inherit inputs;
      pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      modules = [ ./devenv/nix/nix.nix ];
    };

    devShells.aarch64-darwin.rust-nightly = devenv.lib.mkShell {
      inherit inputs;
      pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      modules = [ ./devenv/rs/rust-nightly.nix ];
    };

    devShells.aarch64-darwin.rust-stable = devenv.lib.mkShell {
      inherit inputs;
      pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      modules = [ ./devenv/rs/rust-stable.nix ];
    };

    devShells.aarch64-darwin.python-stable = devenv.lib.mkShell {
      inherit inputs;
      pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      modules = [ ./devenv/py/python-stable.nix ];
    };

    devShells.aarch64-darwin.javascript-stable = devenv.lib.mkShell {
      inherit inputs;
      pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      modules = [ ./devenv/js/nodejs-lts.nix ];
    };

    devShells.aarch64-darwin.terraform-stable = devenv.lib.mkShell {
      inherit inputs;
      pkgs = import nixpkgs { system = "aarch64-darwin"; config.allowUnfree = true; };
      modules = [ ./devenv/tf/terraform-stable.nix ];
    };

  };

}