# Firefox: The web browser

{ pkgs, lib, config, osConfig, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.firefox = {
    enable = true;
    # Using Firefox from unstable via overlay to avoid Node.js build issues
    package = pkgs.firefox;
    
    # Profiles configuration
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        
        # Extensions (new format for Home Manager)
        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            firefox-color
          ];
        };

        # Bookmarks
        bookmarks = {
          force = true;
          settings = [
            {
              name = "Standard";
              toolbar = true;
              bookmarks = [];
            }
          ];
        };

        # Search engines
        search = {
          force = true;
          default = "ddg";
          engines = {
            "ddg" = {
              urls = [{ template = "https://duckduckgo.com/?q={searchTerms}"; }];
              icon = "https://duckduckgo.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = [ "@ddg" ];
            };
            # Remove unwanted engines
            google.metaData.hidden = true;
            amazondotcom-us.metaData.hidden = true;
            bing.metaData.hidden = true;
            ebay.metaData.hidden = true;
          };
        };

        # Firefox settings (about:config)
        settings = {
        
          # Privacy & Security
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.trackingprotection.cryptomining.enabled" = true;
          "privacy.trackingprotection.fingerprinting.enabled" = true;
          "privacy.donottrackheader.enabled" = true;

          # Clear on Exit
          "privacy.clearOnShutdown.cache" = true;
          "privacy.clearOnShutdown.cookies" = true;
          "privacy.clearOnShutdown.downloads" = true;
          "privacy.clearOnShutdown.formdata" = true;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.sessions" = true;
          
          # Disable telemetry
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.server" = "";
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          
          # Disable experiments
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          
          # Performance
          "browser.cache.disk.enable" = true;
          "browser.cache.disk.capacity" = 1048576;          # 1GB cache
          "browser.cache.memory.enable" = true;
          "browser.cache.memory.capacity" = 524288;         # 512MB memory cache
          "browser.sessionhistory.max_total_viewers" = 4;
          "browser.tabs.animate" = false;
          "browser.fullscreen.animate" = false;
          
          # Appearance & UI
          "browser.toolbars.bookmarks.visibility" = "newtab";
          "browser.tabs.firefox-view" = false;
          "browser.tabs.tabClipWidth" = 140;
          "browser.tabs.tabMinWidth" = 76;
          "browser.uidensity" = 1; # Compact density
          "browser.compactmode.show" = true;
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          
          # Extensions
          "extensions.unifiedExtensions.enabled" = true;    # Use unified extensions menu
          "extensions.toolbar.visible" = false;             # Hide extension buttons from toolbar
          
          # Overflow
          "browser.tabs.tabmanager.enabled" = false;
          "browser.tabs.overflow" = "scroll"; 
          "browser.tabs.scrollIntoView" = true; 
          "browser.tabs.warnOnClose" = false;
          
          # Downloads
          "browser.download.useDownloadDir" = true;
          "browser.download.alwaysOpenPanel" = false;
          "browser.download.manager.addToRecentDocs" = false;
          "browser.download.animateNotifications" = false;
          
          # Homepage and new tab page
          "browser.startup.homepage" = "http://www.perdu.com";
          "browser.newtab.url" = "http://www.perdu.com";
          "browser.newtabpage.enabled" = false; # Disable default new tab page
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          
          # Security
          "security.tls.version.fallback-limit" = 3; # TLS 1.2 minimum
          "security.tls.version.min" = 3;
          "security.ssl.require_safe_negotiation" = true;
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;
          
          # Content blocking
          "browser.contentblocking.category" = "strict";
          "urlclassifier.malwareTable" = "goog-malware-proto,goog-unwanted-proto,moztest-harmful-simple,moztest-malware-simple,moztest-unwanted-simple";
          "urlclassifier.phishTable" = "goog-phish-proto,moztest-phish-simple";
          
          # Font rendering
          "gfx.font_rendering.cleartype_params.rendering_mode" = 5;
          "gfx.font_rendering.cleartype_params.cleartype_level" = 100;
          "gfx.font_rendering.cleartype_params.force_gdi_classic_for_families" = "";
          "gfx.font_rendering.cleartype_params.force_gdi_classic_max_size" = 6;
          "gfx.font_rendering.directwrite.enabled" = true;
          
          # Hardware acceleration
          "media.ffmpeg.vaapi.enabled" = true;
          "media.hardware-video-decoding.enabled" = true;
          "gfx.webrender.all" = true;
          "layers.acceleration.force-enabled" = true;
          
          # Scrolling
          "general.smoothScroll" = true;
          "general.smoothScroll.lines.durationMaxMS" = 125;
          "general.smoothScroll.lines.durationMinMS" = 125;
          "general.smoothScroll.mouseWheel.durationMaxMS" = 200;
          "general.smoothScroll.mouseWheel.durationMinMS" = 100;
          "general.smoothScroll.msdPhysics.enabled" = true;
          "general.smoothScroll.other.durationMaxMS" = 125;
          "general.smoothScroll.other.durationMinMS" = 125;
          "general.smoothScroll.pages.durationMaxMS" = 125;
          "general.smoothScroll.pages.durationMinMS" = 125;
          "mousewheel.min_line_scroll_amount" = 30;
          "mousewheel.system_scroll_override_on_root_content.enabled" = true;
          "mousewheel.system_scroll_override_on_root_content.horizontal.factor" = 175;
          "mousewheel.system_scroll_override_on_root_content.vertical.factor" = 175;
          "toolkit.scrollbox.horizontalScrollDistance" = 6;
          "toolkit.scrollbox.verticalScrollDistance" = 2;
          
          # Auto-updates
          "app.update.auto" = false;
          "app.update.enabled" = false;
          "extensions.update.autoUpdateDefault" = false;
          
          # Misc
          "browser.shell.checkDefaultBrowser" = false;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          "extensions.pocket.enabled" = false;
          "extensions.screenshots.disabled" = true;
          "identity.fxaccounts.enabled" = false;
          "signon.rememberSignons" = false;
          "browser.formfill.enable" = false;
          "places.history.enabled" = true;
          "browser.urlbar.suggest.history" = true;
          "browser.urlbar.suggest.bookmark" = true;
          "browser.urlbar.suggest.openpage" = true;
          "browser.urlbar.suggest.topsites" = false;
          
          # Developer tools
          "devtools.chrome.enabled" = true;
          "devtools.debugger.remote-enabled" = true;
          "devtools.theme" = "dark";
        };

        # User Chrome CSS for custom styling
        userChrome = ''
          /* Hide tab bar when using Tree Style Tab */
          #TabsToolbar {
            visibility: collapse !important;
          }
          
          /* Compact navigation bar */
          #nav-bar {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
          }
          
          /* Hide megabar expansion */
          .urlbarView {
            margin-inline: 0 !important;
            width: auto !important;
          }
          
          /* Remove spacers around URL field */
          #nav-bar .toolbarspring {
            display: none !important;
          }
          
          /* Remove flexible spacers in toolbar */
          #nav-bar toolbarspring {
            display: none !important;
          }
          
          /* Compact URL bar container */
          #urlbar-container {
            margin-left: 0 !important;
            margin-right: 0 !important;
            padding-left: 0 !important;
            padding-right: 0 !important;
          }
          
          /* Remove gaps between toolbar items */
          #nav-bar toolbarbutton {
            margin-left: 0 !important;
            margin-right: 0 !important;
          }
          
          /* Hide extension buttons from toolbar */
          #nav-bar .webextension-browser-action {
            display: none !important;
          }
          
          /* Hide unified extensions button if desired */
          #unified-extensions-button {
            display: none !important;
          }
          
          /* Hide extension overflow menu */
          #nav-bar-overflow-button {
            display: none !important;
          }
          
          /* Custom scrollbars */
          :root {
            scrollbar-width: thin;
          }
        '';

        # User Content CSS for web pages
        userContent = ''
          /* Dark mode for all websites */
          @-moz-document url-prefix() {
            :root {
              color-scheme: dark !important;
            }
          }
          
          /* Custom font rendering */
          * {
            font-family: "JetBrains Mono", "SF Pro Display", system-ui, sans-serif !important;
          }
        '';
      };

    };
  };

  # Platform-specific Firefox packages
  home.packages = with pkgs; lib.optionals pkgs.stdenv.isLinux [
    firefox-wayland
  ];

  # Theme for Firefox !
  stylix.targets.firefox.profileNames = [ "default" ];

}
