# Extra Applications

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  # Extra packages not yet in home-manager
  # Look for new addition or rust alternatives: 
  # lolcrab, charasay

  home.packages = with pkgs; [

    # Desktop Apps
    obsidian                  # Digital Garden and noote taking
    jetbrains.gateway         # Remote development, alternative to vim in a professional environment

    # Utils
    uutils-coreutils-noprefix # Better coreutils in rust, harmonize on darwin (*)
    ouch                      # Compression swiss-army knife (ouch)
    rage                      # A simple, secure and modern encryption tool (age)
    xh                        # Replacement for httpie, curl (xh)
    du-dust                   # More intuitive du (dust)
    macchina                  # System info fetcher (macchina)
    rsign2                    # Signing cli compatible with minisign (rsign)

    # Terminal
    steampipe                 # Query like it's 1992 (steampipe)
    
  ];

}