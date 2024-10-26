{ pkgs, ... }: {
  imports = [ ./firefox.nix ./foot ./oh-my-posh.nix ./pavucontrol.nix ];

  home.packages = with pkgs; [ wl-clipboard ];
}
