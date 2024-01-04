{ pkgs, lib, ... }: {

  name = "Rust Development Sandbox";

  # Enable devcontainer support
  # Note: features are not used and replaced by devenv
  devcontainer = {
    enable = true;
    settings = {
      customizations = {
        vscode = {
          settings = {
            # Standard
            update.showReleaseNotes = false;
            window.commandCenter = false;
            workbench.colorTheme = "GitHub Dark Default";
            workbench.preferredDarkColorTheme = "GitHub Dark Default";
            workbench.preferredLightColorTheme = "GitHub Light Default";
            workbench.preferredHighContrastColorTheme = "GitHub Dark High Contrast";
            workbench.preferredHighContrastLightColorTheme = "GitHub Light High Contrast";
            editor.formatOnSave = true;
            editor.formatOnPaste = true;
            editor.minimap.autohide = true;
            vim.mouseSelectionGoesIntoVisualMode = false;
          };
          extensions = [
            # Standard
            "github.github-vscode-theme"
            "github.codespaces"
            "github.copilot"
            "github.copilot-chat"
            "scodevim.vim"
            "mkhl.direnv"
            # Stack specific
            "rust-lang.rust-analyzer"
            "serayuzgur.crates"   # Dependency management and reviews
            "vadimcn.vscode-lldb" # Debugger
          ]; 
        };
        codespaces = {
          "openFiles" = [
            # Open README at launch
            "README.md"
          ];
        };
      };
      # Capacity requested for devcontainer
      hostRequirements = {
        cpus = 8;
        memory = "8gb";
        storage = "32gb";
      };
      # Optional: Secret asked when starting the de devcontainer
      secrets = {};
    };
  };

  # Enable starship for a better prompt
  # Will load a project starship.toml
  starship = {
    enable = true;
    config.enable = true;
  };

  # Common packages for developers
  difftastic.enable = true;
  packages = with pkgs; [ 
    # Standard
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
    setup.exec = ''
      cargo install cargo-generate  # Project templates
      cargo install cargo-outdated  # Renovate deps
      cargo install cargo-readme    # Readme generation
      cargo install cargo-crev      # Code reviews
      cargo install cargo-license   # License compliance
      cargo install cargo-audit     # Vulnerability check
    '';
    # Workflow shortcuts
    init.exec = ''
      cargo init
    '';
    run.exec = ''
      cargo fmt
      cargo run
    '';
    build.exec = ''
      cargo fmt
      cargo build
    '';
    test.exec = ''
      cargo test
    '';
   clean.exec = ''
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
