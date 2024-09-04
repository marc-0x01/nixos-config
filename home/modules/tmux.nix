# Tmux: Terminal Multiplexer

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.tmux = {
    enable = true;
    # Session Manager
    tmuxp.enable = true;
    # Plugins
    plugins = with pkgs; [
      # Using official plugins
      tmuxPlugins.sensible
      tmuxPlugins.tmux-window-name
      tmuxPlugins.sessionist
      tmuxPlugins.pain-control
      tmuxPlugins.prefix-highlight
      tmuxPlugins.yank
    ];
    # Config
    extraConfig = ''''; 
  };

}