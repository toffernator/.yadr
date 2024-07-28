{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    font-awesome
    corefonts # Microsoft Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
