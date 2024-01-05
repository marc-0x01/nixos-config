{ pkgs, lib, ... }: {

  name = "{{stack}} Development Sandbox/Environment";

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
            # ...
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
        cpus = 2;
        memory = "8gb";
        storage = "32gb";
      };
      # Optional: Secret asked when starting the devcontainer
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
    # Stack specific
  ] ++ lib.optionals pkgs.stdenv.isDarwin (with pkgs.darwin.apple_sdk; [
    # Rerquired for {{stack}} on darwin only
    # ...
  ]);

  # Toolchain: {{stack}}
  languages = {
    # {{stack}} = {
    #    enable = true;
    #    # options...
    #};
  };

  # Pre-commit hooks: {{stack}}
  pre-commit.hooks = {
    # <hook>.enable = true;
  };

  # Additional services (attached resources)
  # No additional services, this is a sandbox
  services = {};

  # Environment variables
  dotenv.enable = false;
  env = {
    DEVENV_STACK = "{{stack}}";
  };
 
  # Special hosts
  # Can be used to mock external attached resources
  hosts = {
    "locahost" = "127.0.0.1";
  };

  # Scripts: Rust Stack
  # Can be used as aliases, built your own lightsaber
  scripts = {
    # Install global addons
    setup.exec = ''
    '';
    # Workflow shortcuts
    init.exec = ''
    '';
    run.exec = ''
    '';
    build.exec = ''
    '';
    test.exec = ''
    '';
    clean.exec = ''
    ''; 
  };

  # Startup commands
  enterShell = ''
    clear
    echo "【ツ】Welcome to your {{stack}} (stable) Sandbox!"
    # Print version here
  '';

}
