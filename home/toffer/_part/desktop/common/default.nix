{ pkgs, ... }: {
  imports = [ ./firefox.nix ./foot ./pavucontrol.nix ];

  home.packages = with pkgs; [ wl-clipboard ];
}
