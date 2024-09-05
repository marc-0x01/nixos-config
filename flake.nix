# Main Nix Flake to rule all configurations

{

  description = "Marc's systems configurations";

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
              home-manager, stylix, devenv, fenix, ... } @ inputs: { 

    ## Entrypoint for marcbook-work
    # run with 
    # $ darwin-rebuild switch --flake .#marcbook-work
    # $ nix run nix-darwin -- switch --flake .#marcbook-work
    darwinConfigurations.marcbook-work = nix-darwin.lib.darwinSystem {
      specialArgs = inputs;
      modules = [
        # Configurartion Modules
        ./common/nix-config.nix
        ./common/user-config.nix
        ./systems/marcbook-work.nix
        # Modules
        home-manager.darwinModules.home-manager
        stylix.darwinModules.stylix
        nur.hmModules.nur
        # User Configuration
        {
          parameters.user = {
            username = "mguillen";
            description = "Marc Guillen";
            context = "work";
            email = "mguillen@pictet.com";
            theme = "gruvlight";
            enableLightsaber = true;
            enableStyling = true;
            enableExtra = true;
            enableTest = false;
          };
        }
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
              # Emerging also close to the edge
              rio = nixpkgs-unstable.legacyPackages."aarch64-darwin".rio;
              helix = nixpkgs-unstable.legacyPackages."aarch64-darwin".helix;
            })
            # Custom packages
            (final: prev: {
              qutebrowser-bin = prev.pkgs.callPackage ./overlays/pkgs/qutebrowser-bin.nix { };
              rio-bin = prev.pkgs.callPackage ./overlays/pkgs/rio-bin.nix { };
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

    ### Entrypoint for wackbox-0x01
    # run with 
    # $ nixos-rebuild dry-build --flake .#wackbox-0x01
    # $ nixos-rebuild switch --flake .#wackbox-0x01

    nixosConfigurations.wackbox-0x01 = nixpkgs.lib.nixosSystem  {
      specialArgs = inputs;
      modules = [
        # Configurartion Modules
        ./common/nix-config.nix
        ./common/user-config.nix
        ./systems/wackbox-0x01.nix
        # Modules
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        agenix.nixosModules.default
        nur.hmModules.nur
        # User Configuration
        {
          parameters.user = {
            username = "mguillen";
            description = "Marc Guillen";
            context = "0x01";
            email = "marc@0x01.ooo";
            theme = "monochrome";
            enableLightsaber = true;
            enableStyling = true;
            enableExtra = false;
            enableTest = false;
          };
        }
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
              # Better keep it on closer to the edgeß
              qutebrowser = nixpkgs-unstable.legacyPackages."x86_64-linux".qutebrowser;
              # Emerging also close to the edge
              rio = nixpkgs-unstable.legacyPackages."x86_64-linux".rio;
              helix = nixpkgs-unstable.legacyPackages."x86_64-linux".helix;
            })
            # Custom packages
            # Nothing for now
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
    # TODO: Move to another repo using forAllSystems  
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
