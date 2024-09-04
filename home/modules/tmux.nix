# Tmux: Terminal Multiplexer

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.tmux = {
    enable = true;
    prefix = "C-a";
    # Session Manager
    tmuxp.enable = true;
    # Plugins
    plugins = with pkgs; [
      # Using official plugins
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.sessionist
      tmuxPlugins.pain-control
      tmuxPlugins.mode-indicator
      tmuxPlugins.prefix-highlight
    ];
    # Config
    extraConfig = ''''; 
  };

}