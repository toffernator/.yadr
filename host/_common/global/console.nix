{ lib, ... }: {
  console = {
    font = lib.mkDefault "Lat2-Terminus16";
    keyMap = lib.mkDefault "us";
  };
}
