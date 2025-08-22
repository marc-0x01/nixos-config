# yazi: Blazing fast terminal file manager

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.yazi = {
    enable = false; 
    # Integrations
    enableZshIntegration = true;
    enableNushellIntegration = true;
    # General settings
    settings = {
      manager = {
        # Layout
        ratio = [1 2 5];
        show_hidden = false;
        show_symlink = true;
        # Sorting
        sort_by = "modified";
        sort_dir_first = true;
        sort_reverse = true;
      };
      log = {
        enabled = false;
      };
    };
    # Keybindings, nothing for now
    keymap = {};
  };

}