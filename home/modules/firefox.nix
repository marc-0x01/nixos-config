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
          "browser.startup.blankWindow" = true;
          "browser.disableResetPrompt" = true;
          "browser.newtabpage.enabled" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.tabs.tabmanager.enabled" = false;
          "browser.tabs.firefox-view" = false;
          "browser.toolbars.bookmarks.visibility" = "never";
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          duckduckgo-privacy-essentials
          vimium
          bitwarden
        ];
        bookmarks = [
          {
            name = "Toolbar";
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
            "Bing".metaData.hidden = true;
            "eBay".metaData.hidden = true;
          };
        };
        # Extra profile settings
        extraConfig = ''
          user_pref("update_notifications.enabled", false);
          user_pref("extensions.pocket.enabled", false);
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
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