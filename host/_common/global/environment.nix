{ pkgs, ... }: { environment = { systemPackages = with pkgs; [ coreutils ]; }; }

