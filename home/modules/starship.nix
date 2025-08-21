# starship: The minimal, blazing-fast, and infinitely customizable prompt for any shell! 

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.starship = {
    enable = true;
    # Integrations
    enableZshIntegration = true;
    enableNushellIntegration = true;
    # Settings
    settings = {
      add_newline = false;
      scan_timeout = 10;
      command_timeout = 750;
      format = "$all";
      # Tweak Nix-shell for devenv
      nix_shell = {
        format = "in [$symbol$state( \($name\))]($style) ";
        pure_msg = "";
        impure_msg = "!";
      };
    };
  };

}