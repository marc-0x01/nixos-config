# Nix Development 

{ pkgs, lib, ... }: {
 
  # Enable starship for a better prompt
  # Will load a project starship.toml
  starship = {
    enable = true;
    config.enable = true;
  };

  # Common packages for developers
  packages = with pkgs; [ 
    git
    gh
  ];

  # Toolchain: Nix
  languages.nix = {
    enable = true;
  };

  # Pre-commit hooks: Nix
  pre-commit.hooks = {
    nixfmt.enable = true;
    alejandra.enable = true;
    deadnix.enable = true;
  };

  # Additional services (attached resources)
  # No additional services, this is a sandbox
  services = {};

  # Environment variables
  dotenv.enable = false;
  env = {
    DEVENV_STACK = "nix";
  };
 
  # Special hosts
  # Can be used to mock external attached resources
  hosts = {
    "locahost" = "127.0.0.1";
  };

  # Scripts: Nix Stack
  # Can be used as aliases
  scripts = {
    # Workflow shortcuts
    dev-init.exec = ''
    '';
    dev-run.exec = ''
    '';
    dev-test.exec = ''
    '';
    dev-forrmat.exec = ''
    '';
  };

  # Startup commands
  enterShell = ''
    clear
    echo "【ツ】Welcome to your ❄ Nix Sandbox!"
    nix --version
  '';

}