# Terraform development Sandbox 
# TODO: Include terragrunt, terratest, localstack

{ pkgs, lib, ... }: {

  # Enable starship for a better prompt
  # Will load a project starship.toml
  starship = {
    enable = true;
    config.enable = false;
  };

  # Common packages for developers
  packages = with pkgs; [ 
    git
    gh
    jq
    # Additional
    terragrunt
    localstack
  ];

  # Toolchain: Terraform
  # Golang for test and custom providers
  languages = {
    terraform.enable = true;
    go.enable = true;
  };
  
  # Pre-commit hooks: Terraform
  pre-commit.hooks = {
    terraform-format.enable = true; # Formatter
    tflint.enable = true;           # linter
  };

  # Additional services (attached resources)
  # No additional services, this is a sandbox
  services = {};

  # Environment variables
  dotenv.enable = false;
  env = {
    DEVENV_STACK = "terraform";
  };
 
  # Special hosts
  # Can be used to mock external attached resources
  hosts = {
    "locahost" = "127.0.0.1";
  };

  # Scripts: Terraform Stack
  # Can be used as aliases
  scripts = {
    # Workflow shortcuts
    dev-init.exec = ''
      terraform init
    '';
    dev-plan.exec = ''
      terraform plan
    '';
    dev-apply.exec = ''
      terraform apply
    '';
    dev-format.exec = ''
      terraform fmt
    '';
  };

  # Startup commands
  enterShell = ''
    clear
    echo "【ツ】Welcome to your 💠 Terraform (stable) Sandbox!"
    printf "Terraform v%s\n" `terraform version --json | jq -r '.["terraform_version"]'`
    printf "Golang v%s\n" `go version | cut -d " " -f 3 | tr -d "go"`
    printf "Localstack v%s\n\n" `localstack --version`
  '';

}
