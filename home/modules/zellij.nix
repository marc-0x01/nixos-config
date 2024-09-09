# zellij: A terminal workspace with batteries included

# Note: You might need to manually clear the cache
#  * OSX: rm -rf ~/Library/Caches/org.Zellij-Contributors.Zellij
#  * Linux: rm -rf ~/.cache/zellij

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.zellij = {
    enable = true;
    settings = {
      # Base settings
      default_shell = "/etc/profiles/per-user/${osConfig.parameters.user.username}/bin/nu";
      mouse_mode = true;
      # Clipboard
      copy_on_select = true;
      copy_command = "pbcopy";
      copy_clipboard = "primary";
      # Layout and Mode
      default_layout = "default";
      default_mode = "locked";
      # user Interface
      simplified_ui = false;
      ui = {
        pane_frames = {
            rounded_corners = true;
            hide_session_name = true;
        };
      };
      # Plugins
      plugins = {
        # Builtin
        tab-bar = { path = "tab-bar"; };
        status-bar = { path = "status-bar"; };
        strider = { path = "strider"; };
        compact-bar = { path = "compact-bar"; };
        # custom
        startup = { path = "layout/startup.kdl"; };
      };
      # Key bindings
      # TODO: Look how to map the TOML format to Nix!
      keybinding = {};
    };
    # Integrations, i.e. autostart
    enableZshIntegration = false;
  };

  # Layouts, Default  
  xdg.configFile."default-layout" = {
    enable = true;
    target = "zellij/layouts/default.kdl";
    text = ''
      layout {
        default_tab_template {
          children
          pane size=1 borderless=true {
              plugin location="zellij:compact-bar"
          }
        }
        tab name="main" {
          pane
        }
      }
    '';
  };

}