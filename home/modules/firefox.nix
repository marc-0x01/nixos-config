# firefox: Firefox is just the beginning

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, nur, home-manager, ... }: {

  programs.firefox = {
    enable = true;
    # Package, using binary overlay without extrapPolicies ;(
    package = pkgs.firefox-bin;
    profiles = {
      mguillen = {
        id = 0;
        name = "mguillen";
        isDefault = true;
        settings = {
          "general.smoothScroll" = true;
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          duckduckgo-privacy-essentials
          vimium
          bitwarden
        ];
        bookmarks = [
          {
            name = "Toolbba";
            toolbar = true;
            bookmarks = [
              {
                name = "GitHub";
                tags = [ "Dev" ];
                keyword = "GitHub";
                url = "https://www.github.dev";
              }
              {
                name = "Slack";
                tags = [ "Chat" ];
                keyword = "Slack";
                url = "https://www.slack.com";
              }  
            ];
          }
        ];
        search = {
          force = true;
          default = "DuckDuckGo";
          engines = {
            "Nix Packages" = {
                urls = [{
                    template = "https://search.nixos.org/packages";
                    params = [
                        { name = "type"; value = "packages"; }
                        { name = "query"; value = "{searchTerms}"; }
                    ];
                }];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
            };
            "Google".metaData.hidden = true;
            "Amazon.com".metaData.hidden = true;
          };
        };
        # Extra profile settings
        extraConfig = ''
          user_pref("app.update.silent", true);
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("full-screen-api.ignore-widgets", true);
          user_pref("media.ffmpeg.vaapi.enabled", true);
          user_pref("media.rdd-vpx.enabled", true);
        '';
        # User Chrome inspired by SimpleFox
        userChrome = builtins.readFile ./assets/userChrome.css;
        userContent = builtins.readFile ./assets/userContent.css;
      };
    };
  };

  # Open browser script
  home.file = {
    ".local/bin/wm-open-web-browser.sh" = {
      enable = pkgs.stdenv.isDarwin;
      executable = true;
      source = ../scripts/wm-open-web-browser-darwin.sh;
      target = "${config.home.homeDirectory}/.local/bin/wm-open-web-browser.sh";
    };
  };

}