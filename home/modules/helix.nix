# helix: A post-modern modal text editor

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.helix = {
    enable = true;
    # Still using vim as default for now
    defaultEditor = false;
    # Plugins
    extraPackages = with pkgs; [
         helix-gpt 
    ];
    # Ignore/Unignore list
    ignores = [
        "!.gitignore"
    ];
    # Main configuration, most default are right
    settings = {
        # Editor settings
        editor = {
            # Layout
            line-number = "absolute";
            auto-info = false;
            bufferline = "multiple";
            popup-border = "all";
            statusline = {
                left = [
                    "mode"
                    "spinner" "separator"
                    "version-control" "separator"
                    "file-name"
                    "read-only-indicator"
                    "file-modification-indicator"
                ];
                center = [ ];
                right = [
                    "diagnostics"
                    "selections"
                    "register"
                    "position" "separator"
                    "file-type"
                    "file-line-ending"
                    "file-encoding"
                ];
                separator = " • ";
                mode = {
                    normal = "N";
                    insert = "I";
                    select = "S";
                };
            };
            indent-guides = {
                render = true;
                character = "┆";
                skip-levels = 0;
            };
            cursor-shape = {
                    normal = "block";
                    insert = "bar";
                    select = "underline";
            };
            # Mouse/Selection
            mouse = true;
            middle-click-paste = false;
            # Shell
            shell = [
                "/etc/profiles/per-user/mguillen/bin/nu"
            ];
            # Common LSP
            lsp = {
                display-messages = true;
            };
        };
        # Keybindings remap
        # Keepng helix promoted as reference keybindings!
        keys = {
            normal = { };
            insert = { };
            select = { };
        };
    };
    # Language configuration, LSP tweaks
    languages = { };
  };

}