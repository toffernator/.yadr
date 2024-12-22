{ buildPythonPackage, fetchPypi, lib, ... }:

buildPythonPackage rec {
  pname = "pydo";
  version = "0.6.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = lib.fakeSha256;
  };
}
