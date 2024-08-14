# helix: A post-modern modal text editor

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.helix = {
    enable = true;
    # Still using vim as default for now
    defaultEditor = false;
    # Plugins
    extraPackages = [ ];
    # Ignore/Unignore list
    ignore = [
        "!.gitignore"
    ];
    # Main configuration, most default are right
    settings = {
        # Editor settings
        editor = {
            line-number = "absolute";
            lsp.display-messages = true;
        };
        # Keybindings remap
        keys.normal = {
            space.space = "file_picker";
            space.w = ":w";
            space.q = ":q";
            esc = [ 
                "collapse_selection"
                "keep_primary_selection" 
            ];
        };
    };
    # Language configuration, LSP tweaks
    languages = { };
  };

}