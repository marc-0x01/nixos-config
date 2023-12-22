{ pkgs, lib, ... }: {

  name = "Nix Development Sandbox";
 

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
            # Stack Specific
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
            "bbenoist.nix"
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
    # Stack specific
    vulnix
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
    DEVENV_STACK = "nix-flake";
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
    new.exec = ''
      printf "\033[1m%s\033[0m\n" "Create New Project"
      printf " ! Organisation: "
      read -r my_orga
      printf " ! Repository Name: "
      read -r my_repo_name
      printf " ✓ Creating a new repo \033[3m%s\033[0m in organisation \033[3m%s\033[0m based on template \033[3m%s\033[0m!\n" "''${my_repo_name}" "''${my_orga}" "''${DEVENV_STACK}-template" 
      gh create "''${my_repo_name}" --clone --template "https://github.com/''${my_orga}/''${DEVENV_STACK}-template.git"
    '';
    init.exec = ''
      nix flake init
    '';
    update.exec = ''
      nix flake update
    '';
    run.exec = ''
      # run <command> <target>
      nix flake check --impure
      nix run $1 -- --flake $2
    '';
    switch.exec = ''
      # switch <command> <target>
      nix run $1 -- switch --flake $2
    '';
  };

  # Startup commands
  enterShell = ''
    clear
    echo "【ツ】Welcome to your ❄ Nix Sandbox!"
    nix --version
  '';

}