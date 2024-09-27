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
    # History settings
    history = {
      size = 1000;
      save = 1000;
      path = "~/.zsh_history";
      extended = true; # Save timestamp
      ignorePatterns = [ "&" "[ ]*" "exit" "ls" "bg" "fg" "history" "clear" ];
      ignoreSpace = true;
      ignoreDups = true;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
    };
    # Plugins, nothing at the moment
    # Do not want to be dependent to omz since it is not my main shell
    oh-my-zsh = {
      enable = false;
      plugins = [];
    };
    # Config
    initExtra = ''
    ## Make sure that core bindings are there
    export KEYTIMEOUT=1
    bindkey -v
    bindkey -M menuselect "h" vi-backward-char
    bindkey -M menuselect "k" vi-up-line-or-history
    bindkey -M menuselect "l" vi-forward-char
    bindkey -M menuselect "j" vi-down-line-or-history
    bindkey "^f" forward-char
    bindkey "^b" backward-char
    bindkey "^a" beginning-of-line
    bindkey "^e" end-of-line
    bindkey "^k" backward-kill-line
    bindkey "^l" clear-screen
    bindkey "^p" up-line-or-history
    bindkey "^n" down-line-or-history
    bindkey "^r" history-search-backward
    bindkey "^g" send-break
    bindkey "^u" undo
    '';
  };

}