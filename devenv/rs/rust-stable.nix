# Rust development

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
  ] ++ lib.optionals pkgs.stdenv.isDarwin (with pkgs.darwin.apple_sdk; [
    # Rerquired for rust on darwin to build cargo plugins and apps
    frameworks.CoreFoundation
    frameworks.SystemConfiguration
    frameworks.Security
  ]);

  # Toolchain: Rust
  languages.rust = {
    enable = true;
    channel = "stable";
    components = [ "rustc" "cargo" "clippy" "rustfmt" "rust-analyzer" ];
  };

  # Pre-commit hooks: Rust
  pre-commit.hooks = {
    rustfmt.enable = true;
    clippy.enable = true;
  };

  # Additional services (attached resources)
  # No additional services, this is a sandbox
  services = {};

  # Environment variables
  dotenv.enable = false;
  env = {
    DEVENV_STACK = "rust";
  };
 
  # Special hosts
  # Can be used to mock external attached resources
  hosts = {
    "locahost" = "127.0.0.1";
  };

  # Scripts: Rust Stack
  # Can be used as aliases, built your own lightsaber
  scripts = {
    # Install cargo addons
    dev-setup.exec = ''
      cargo install cargo-generate  # Project templates
      cargo install cargo-outdated  # Renovate deps
      cargo install cargo-readme    # Readme generation
      cargo install cargo-license   # License compliance
      cargo install cargo-audit     # Vulnerability check
    '';
    # Workflow shortcuts
    dev-init.exec = ''
      cargo init
    '';
    dev-run.exec = ''
      cargo run
    '';
    dev-format.exec = ''
      cargo fmt
    '';
    dev-build.exec = ''
      cargo build
    '';
    dev-test.exec = ''
      cargo test
    '';
   dev-clean.exec = ''
      cargo clean
    ''; 
  };

  # Startup commands
  enterShell = ''
    clear
    echo "【ツ】Welcome to your 🦀 Rust (stable) Sandbox!"
    rustc --version
    cargo --version
  '';

}
