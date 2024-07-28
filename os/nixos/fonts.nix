{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    carlito # NixOS
    vegur # NixOS
  ];
}

