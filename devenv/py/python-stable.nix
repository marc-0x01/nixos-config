# Python Development

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
    jq
    # Required for numpy and other data package
    zlib
  ];

  # Toolchain: Python with poetry
  # Note: the venv is deactivated by default
  languages.python = {
    enable = true;
    poetry = {
      enable = true;
      install.quiet = true;
      activate.enable = false;
    };
  };

  # Pre-commit hooks: Python
  pre-commit.hooks = {
    flake8.enable = true;
    autoflake.enable = true;
    black.enable = true;
    mypy.enable = true;
  };

  # Additional services (attached resources)
  # No additional services, this is a sandbox
  services = {};

  # Environment variables
  dotenv.enable = false;
  env = {
    DEVENV_STACK = "python";
  };
 
  # Special hosts
  # Can be used to mock external attached resources
  hosts = {
    "locahost" = "127.0.0.1";
  };

  # Scripts: Python Stack
  # Can be used as aliases
  scripts = {
    # Workflow shortcuts
    dev-init.exec = ''
      poetry init
      poetry config virtualenvs.in-project true
    '';
    dev-run.exec = ''
      poetry run
    '';
    dev-test.exec = ''
    '';
    dev-forrmat.exec = ''
    '';
  };

  # Startup commands
  enterShell = ''
    clear
    echo "【ツ】Welcome to your 🐍 Python Sandbox!"
    python --version
    poetry --version
  '';

}