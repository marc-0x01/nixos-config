# nushell: A new type of shell

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.nushell = {
    enable = true;
    configFile.text = ''
      # Nushell Config File
      $env.config = {
        show_banner: false
        use_ansi_coloring: false
        bracketed_paste: true
        edit_mode: vi
        shell_integration: true
        ls: {
          use_ls_colors: false
          clickable_links: true
        }
        rm: {
          always_trash: false
        }
        cursor_shape: {
          vi_insert: blink_block
          vi_normal: underscore
        }
        table: {
          mode: rounded
          index_mode: auto
          show_empty: true
          trim: {
            methodology: truncating  
            truncating_suffix: "..."
          }
        }
        completions: {
          case_sensitive: false
          quick: true
          partial: true
          algorithm: prefix
          external: {
            enable: true
            max_results: 100 
            completer: null
          }
        }
        history: {
          max_size: 100_000
          sync_on_enter: true 
          file_format: sqlite
        }
        filesize: {
          metric: true
          format: auto
        }
      }
      
    '';
    # TODO: find a way to source profile and nix automatically
    envFile.text = ''
      # Nushell Env File
      # Indicators, almost none cause i am using starship
      $env.PROMPT_INDICATOR = {|| "" }
      $env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
      $env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
      $env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
      # Usual suspects
      $env.EDITOR = 'hx'
      $env.VISUAL = 'hx'
      $env.PAGER = 'less -R'
      # Nix
      $env.NIX_PATH = $'($env.HOME)/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels'
      $env.NIX_PROFILES = $'/nix/var/nix/profiles/default /run/current-system/sw /etc/profiles/per-user/($env.USER) ($env.HOME)/.nix-profile'
      $env.NIX_REMOTE = 'daemon'
      $env.NIX_SSL_CERT_FILE = '/etc/ssl/certs/ca-certificates.crt'
      $env.NIX_USER_CONF_FILES = $"($env.HOME)/Devel/nix-config"
      $env.NIX_USER_CONF_REPOSITORY = $"github:/marc-0x01/nixos-config"
      $env.NIX_USER_DEV_REPOSITORY = $"github:/marc-0x01/dev-workspaces"
      $env.TERMINFO_DIRS = $"($env.HOME)/.nix-profile/share/terminfo:/etc/profiles/per-user/($env.USER)/share/terminfo:/run/current-system/sw/share/terminfo:/nix/var/nix/profiles/default/share/terminfo:/usr/share/terminfo"
      # Path
      $env.PATH = (
        $env.PATH
        | split row (char esep)
        | append '/run/wrappers/bin'
        | append $"($env.HOME)/.local/share/flatpak/exports/bin"
        | append '/var/lib/flatpak/exports/bin'
        | append $"/($env.HOME)/.nix-profile/bin"
        | append '/nix/profile/bin'
        | append $"($env.HOME)/.local/state/nix/profile/bin"
        | append $"/etc/profiles/per-user/($env.USER)/bin"
        | append '/nix/var/nix/profiles/default/bin'
        | append '/run/current-system/sw/bin'
        | append $"($env.HOME)/.local/bin"
      )
    '';
    shellAliases = {
      # Programs
      cls = "clear";
      tree = "tree -NFC -dirsfirst";
      grep = "rg";
      btm = "btm -T";
      top = "btm -b";
      htop = "btm -b";
      cat = "bat --plain";
      bat = "bat --style='numbers,rule,snip,header,changes'";
      dust = "dust -r";
      diff = "difft";
      about = "macchina -i=en0";
      # List
      ll = "ls -l";
      la = "ls -la";
      # Compress, Uncompress
      z = "ouch c";
      uz = "ouch d";
      # Git, linking git aliases
      gl = "git l";
      ga = "git a";
      gap = "git ap";
      gc = "git c";
      gca = "git ca";
      gcm = "git cm";
      gcam = "git cam";
      gm = "git m";
      gd = "git d";
      gds = "git ds";
      gdc = "git dc";
      gs = "git s";
      gco = "git co";
      gcob = "git cob";
      gb = "git b";
      gla = "git la";
      gui = "lazygit";
      # Development workspaces
      nixdev = "nix develop --impure $'($env.NIX_USER_DEV_REPOSITORY)#nix'";
      rsdev = "nix develop --impure $'($env.NIX_USER_DEV_REPOSITORY)#rust-stable'";
      pydev = "nix develop --impure $'($env.NIX_USER_DEV_REPOSITORY)#python-stable'";
      jsdev = "nix develop --impure $'($env.NIX_USER_DEV_REPOSITORY)#javascript-stable'";
      tfdev = "nix develop --impure $'($env.NIX_USER_DEV_REPOSITORY)#terraform-stable'";
    }; 
  };

}
