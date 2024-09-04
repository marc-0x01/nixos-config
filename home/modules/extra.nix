# Extra Applications

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  # Extra packages or not yet in home-manager
  # Look for new addition or rust alternatives: lolcrab (better lolcat)
  home.packages = with pkgs; [

    # Desktop Apps
    obsidian                  # Digital Garden and noote taking
    jetbrains.gateway         # Remote development, alternative to vim in a professional environment

    # Terminal
    charasay                  # Cow have voice in terminal, better coesay (charasay)
    lolcat                    # Rainbow! (lolcat)
    steampipe                 # Query like it's 1992 (steampipe)
    uutils-coreutils          # Better coreutils in rust, hamonize on darwin (*)
    ouch                      # Compression swiss-army knife (ouch)
    rsign2                    # Signing cli compatible with minisign (rsign)
    rage                      # A simple, secure and modern encryption tool (age)
    age-plugin-yubikey        # -- Integration of age with yubikey
    difftastic                # Better diff (difft), mostly for git
    macchina                  # System info fetcher (macchina)
    xh                        # Replacement for httpie, curl (xh)
    du-dust                   # More intuitive du (dust)
    vulnix                    # Nix scurity scanner

  ];

}