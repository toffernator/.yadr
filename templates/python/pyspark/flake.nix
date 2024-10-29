{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        envWithScript = script:
          (pkgs.buildFHSUserEnv {
            name = "python-env";
            targetPkgs = pkgs:
              (with pkgs; [
                python3
                python3Packages.pip
                python3Packages.virtualenv
                # Support binary wheels from PyPI
                pythonManylinuxPackages.manylinux2014Package
                # Enable building from sdists
                cmake
                ninja
                gcc
                pre-commit
                # For spark
                jdk8_headless
              ]);
            runScript = "${
                pkgs.writeShellScriptBin "runScript" (''
                      set -e
                      test -d .nix-venv || ${pkgs.python3.interpreter} -m venv .nix-venv
                  source .nix-venv/bin/activate
                  export JAVA_HOME="${pkgs.jdk8_headless.home}"
                  set +e
                '' + script)
              }/bin/runScript";
          }).env;
      in { devShell = envWithScript "zsh"; });
}
