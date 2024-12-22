{ pkgs, ... }: {
  # FIXME: foot and pavucontrol are not supported on macos so it cannot be in common
  imports = [ 
  ./firefox.nix 
  # ./foot 
  # ./pavucontrol.nix
  ];

  home.packages = with pkgs; [ wl-clipboard ];
}
