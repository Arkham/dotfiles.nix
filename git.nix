{
  programs.git = {
    enable = true;
    ignores = [ "*~" ".DS_Store" ".direnv" ".env" ".rgignore" ];
    settings = {
      user = {
        name = "Ju Liu";
        email = "liuju86@gmail.com";
      };
      init = { defaultBranch = "main"; };
      pull = { ff = "only"; };
      push = { autoSetupRemote = "true"; };
      alias = {
        ci = "commit";
        co = "checkout";
        di = "diff";
        dc = "diff --cached";
        addp = "add -p";
        shoe = "show";
        st = "status";
        unch = "checkout --";
        br = "checkout";
        bra = "branch -a";
        newbr = "checkout -b";
        rmbr = "branch -d";
        mvbr = "branch -m";
        cleanbr =
          "!git remote prune origin && git co master && git branch --merged | grep -v '*' | xargs -n 1 git branch -d && git co -";
        as = "update-index --assume-unchanged";
        nas = "update-index --no-assume-unchanged";
        al =
          "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /'";
        pub = "push -u origin HEAD";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
