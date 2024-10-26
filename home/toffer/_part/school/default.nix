{ pkgs, ... }: {
  home.packages = with pkgs; [ zotero anki-bin ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      teabyii.ayu
      vscodevim.vim
      ms-toolsai.jupyter
      ms-python.python
    ];

    userSettings = {
      "files.autoSave" = "on";
      "editor.fontFamily" =
        "'JetBrains Mono', 'Droid Sans Mono', 'monospace', monospace";
      "editor.fontSize" = 18;
      "editor.fontLigatures" = true;
      "workbench.colorTheme" = "Ayu Dark";
    };
  };
}
