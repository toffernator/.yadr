# The home manager configuration specific to my macbook
{ inputs, outputs, vars, lib, config, pkgs, ... }: {
  home = {
    packages = with pkgs;
      [ nh doctl ] ++ [
        (pkgs.python312.withPackages (ppkgs:
          with ppkgs; [
            ansible-core

            jmespath
            psycopg2
            azure-core
            boto3

            diagrams
            # pydo
            (ppkgs.buildPythonPackage rec {
              pname = "pydo";
              version = "0.6.0";
              format = "pyproject";

              nativeBuildInputs = [ poetry-core ];
              buildInputs =
                [ azure-core azure-identity msrest typing-extensions ];

              src = fetchPypi {
                inherit pname version;
                sha256 = "sha256-p7YNBSNWNBrj9Iua6YRs+Je80sXN1LrsOWWf0IXnEc0=";
              };
            })
            azure-identity
            msrest
            typing-extensions
          ]))
      ];
    username = vars.user;
    homeDirectory = vars.homeDir;
  };
}
