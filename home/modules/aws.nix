# aws-cli: Amazon Web Services

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.awscli = {
    enable = true;
    # Default configuration file
    settings = {
      "default" = {
        region = "eu-west-1";
        output = "json";
      };
    };
    # Default credentials file
    credentials =  {};
  };

  # Script to generate SSO credentials
  # Using a separated file as it is not managed by Nix
  # aws-setup.sh <region> <start_url> ~./aws/config-<orga>
  # then set AWS_CONFIG_FILE to ~./aws/config-<orga>
  home.file = {
    ".local/bin/aws-setup.sh" = {
      enable = true;
      executable = true;
      source = ../scripts/aws-setup.sh;
      target = "${config.home.homeDirectory}/.local/bin/aws-setup.sh";
    };
  };

}