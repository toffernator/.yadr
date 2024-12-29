{ pkgs, ... }: {
  imports = [ 
    ./foot 
    ./pavucontrol.nix
    ./firefox.nix 
  ];

  home.packages = with pkgs; [ wl-clipboard ];
}
