{ pkgs, lib, ... }: {

  name = "Terraform Development Sandbox";


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
            asciidoc.antora.enableAntoraSupport = false;
            asciidoc.extensions.enableKroki = true;
          };
          extensions = [
            # Standard
            "github.github-vscode-theme"
            "github.codespaces"
            "github.copilot"
            "github.copilot-chat"
            "asciidoctor.asciidoctor-vscode"
            "scodevim.vim"
            "mkhl.direnv"
            # Stack specific
            "hashicorp.terraform"
            "golang.go"
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
    config.enable = false;
  };

  # Common packages for developers
  difftastic.enable = true;
  packages = with pkgs; [ 
    # Standard
    curl
    git
    gh
    jq
    # Stack specific, mandatory
    awscli2     # root cli
    terragrunt  # Terrafrom configuration
    # Stack specific, optional
    localstack  # Run localy, mocking AWS api 
    infracost   # Get cost, hopefully once in trivvy
  ];

  # Toolchain: Terraform
  # Golang for test and custom providers
  languages = {
    terraform.enable = true;
    go.enable = true;
  };
  
  # Pre-commit hooks: Terraform
  pre-commit.hooks = {
    terraform-format.enable = true; # formatter
    tflint.enable = true;           # linter
  };

  # Additional services (attached resources)
  # No additional services, this is a sandbox
  services = {};

  # Environment variables
  dotenv.enable = false;
  env = {
    DEVENV_STACK = "terraform";
    # Localstack, set your token and activate pro feature
    # LOCALSTACK_AUTH_TOKEN = "";
    # ACTIVATE_PRO = 1;
  };
 
  # Special hosts
  # Can be used to mock external attached resources
  hosts = {
    "locahost" = "127.0.0.1";
  };

  # Scripts: Terraform
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
      localstack start
      terraform init
    '';
    update.exec = ''
      terraform init
    '';
    plan.exec = ''
      terrafrom get
      terraform fmt
      terraform validate
      terraform plan
    '';
    inspect.exec = ''
      terraform graph | dot -Tsvg > depedency.svg
    ''; 
    apply.exec = ''
      terraform apply
    '';
  };

  # Startup commands
  enterShell = ''
    clear
    echo "【ツ】Welcome to your 💠 Terraform (stable) Sandbox!"
    printf "Terraform v%s\n" `terraform version --json | jq -r '.["terraform_version"]'`
    printf "Golang v%s\n" `go version | cut -d " " -f 3 | tr -d "go"`
    printf "Localstack v%s\n" `localstack --version`
    printf "Infracost %s\n\n" `infracost --version 2>/dev/null | cut -d " " -f 2`
  '';

}
