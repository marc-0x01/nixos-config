# git: --distributed-even-if-your-workflow-isnt

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.git = {
    enable = true;
    userName  = "Marc Guillen";
    userEmail = "marc@0x01.ooo";
    signing = {
      # TODO: add signing commit with minisign
      key = "";
      signByDefault = false;
    };
    # Aliases at git level, use: git xxx
    aliases = {
      l = "log --pretty=format:'%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --date=short";
      a = "add";
      ap = "add -p";
      c = "commit --verbose";
      ca = "commit -a --verbose";
      cm = "commit -m";
      cam = "commit -a -m";
      m = "commit --amend --verbose";
      d = "diff";
      ds = "diff --stat";
      dc = "diff --cached";
      s = "status -s";
      co = "checkout";
      cob = "checkout -b";
      b = "!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'";
      la = "!git config -l | grep alias | cut -c 7-";
      dft = "difftool";
      dl = "!f() { GIT_EXTERNAL_DIFF=difft git log -p --ext-diff; }; f";
    };
    # Behavior for some file types
    attributes = [
      "*.pdf diff=pdf"
      "*.jpg binary"
      "*.png binary"
      "*.gif binary"
    ];
    # Global ignore
    ignores = [
      ".DS_Store"
    ];
    # Better diffs
    difftastic = {
      enable = true;
      background = "dark";
    };
    lfs.enable = false;
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };

}