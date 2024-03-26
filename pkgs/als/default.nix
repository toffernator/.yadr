{ lib, pkgs }:
let pname = "agda-language-server";
in pkgs.stdenv.mkDerivation {
  inherit pname;
  version = "0.1";
  src = pkgs.fetchFromGithub {
    owner = "agda";
    repo = pname;
    rev = "v0.2.6.4.0.3";
    sha256 = "";
  };

  nativeBuildInputs = with pkgs; [ stack ];

  buildPhase = "stack build";

  installPhase = "";

  meta = with lib; {
    description = "The agda language server";
    homepage = ""; # TODO
    license = licenses.unlicense; # TODO
    platforms = platforms.all;
    maintainers = with maintainers; [ toffernator ];
  };
}
