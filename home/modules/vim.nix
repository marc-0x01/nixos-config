# VIm: VI Improved 

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  # Still there...
  programs.vim = {
    enable = true;
  };
  
  # ... But we will use nvim as a replacement
  # - Using the the mini.vim plugins for a sensible configuration
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