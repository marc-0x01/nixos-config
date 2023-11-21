# Javascript Development

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
  ];

  # Toolchain: javascript with modejs/npm (slim)
  languages.javascript = {
    enable = true;
    package = pkgs.nodejs;
    corepack.enable = true;
    npm.install.enable = true;
  };

  # Pre-commit hooks: Javascript
  pre-commit.hooks = {
    eslint.enable = true;
  };

  # Additional services (attached resources)
  # No additional services, this is a sandbox
  services = {};

  # Environment variables
  dotenv.enable = false;
  env = {
    DEVENV_STACK = "javascript";
  };
 
  # Special hosts
  # Can be used to mock external attached resources
  hosts = {
    "locahost" = "127.0.0.1";
  };

  # Scripts: Javascript stack
  # Can be used as aliases
  scripts = {
    # Workflow shortcuts
    dev-init.exec = ''
    '';
    dev-run.exec = ''
      npx run
    '';
    dev-test.exec = ''
    '';
    dev-forrmat.exec = ''
    '';
  };

  # Startup commands
  enterShell = ''
    clear
    echo "【ツ】Welcome to your  Javascript Sandbox!"
    echo "nodejs version: $(npm --version)"
  '';

}