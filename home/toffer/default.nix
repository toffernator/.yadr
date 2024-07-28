{ lib, os, ... }: {
  config = lib.mkMerge [
    (import ./common)
    (lib.mkIf (os == "darwin") (import ./darwin))
    (lib.mkIf (os == "nixos") (import ./nixos))
  ];
}
