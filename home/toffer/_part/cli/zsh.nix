{ ... }: {
  programs.zsh = {
    enable = true;

    enableCompletion = true;

    defaultKeymap = "viins";

    history = {
      size = 5000;
      save = 5000;
      ignoreAllDups = false;
    };

    shellAliases = {
      ls = "ls --color";
      ll = "ls -l --color";
    };

  };
}
