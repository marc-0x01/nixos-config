# Zsh: The Z Shell

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    # Core settings
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    # Plugins, nothing at the moment
    zplug = {
      enable = true;
      plugins = [];
    };
    # Config
    initExtra = '''';
  };

}