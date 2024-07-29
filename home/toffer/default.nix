{ os, ... }:
let
  darwinModuleOrEmpty = if (os == "darwin") then [ ./darwin ] else [ ];
  nixosModuleOrEmpty = if (os == "nixos") then [ ./nixos ] else [ ];
in { imports = ([ ./common ] ++ darwinModuleOrEmpty ++ nixosModuleOrEmpty); }
