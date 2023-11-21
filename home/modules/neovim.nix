# neovim: Hyperextensible Vim-based text editor

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  # This is a minimal nvim configuration
  programs.neovim = {
    enable = true;
    # Alias
    viAlias = true;
    vimAlias = true;
    # Plugins
    plugins = with pkgs.vimPlugins; [
      # Using mini.vim for a base editor
      mini-nvim
    ];
    # Config
    extraLuaConfig = ''
      require('mini.starter').setup()
      require('mini.basics').setup()
      require('mini.statusline').setup()
      require('mini.tabline').setup()
      require('mini.animate').setup()
      require('mini.bufremove').setup()
      require('mini.cursorword').setup()
      require('mini.indentscope').setup()
    '';
  };

}