{ config, lib, pkgs, ... }:

let
  cfg = config.neovim;
  technologies = [
    "ansible"
    "bash"
    "docker"
    "dotnet"
    "go"
    "haskell"
    "lua"
    "nix"
    "python"
    "rust"
    "typst"
    "webdev"
  ];
  bashDependencies = with pkgs.nodePackages_latest; [ bash-language-server ];
  ansibleDependencies = with pkgs; [ ansible-language-server ansible-lint ];
  dockerDependencies = with pkgs; [
    dockerfile-language-server-nodejs
    docker-compose-language-service
  ];
  dotnetDependencies = with pkgs; [ dotnet-sdk_8 omnisharp-roslyn ];
  goDependencies = with pkgs; [ gopls go templ ];
  haskellDependencies = with pkgs; [ haskell-language-server ];
  luaDependencies = with pkgs; [ lua-language-server ];
  nixDependencies = with pkgs; [ nil nixd nixfmt-classic ];
  pythonDependencies = with pkgs; [
    # Python312 might be needed by techonolgies other than Python.
    python312
    pyright
  ];
  rustDependencies = with pkgs; [
    # Cargo might be neede by technologies than Rust.
    cargo
    rustc
    rust-analyzer
  ];
  typstDependencies = with pkgs; [ typst-lsp ];
  webdevDependencies = (with pkgs; [
    nodejs_20
    prettierd
    # with nodePackages; followed by string name doesn't work
    nodePackages."@tailwindcss/language-server"
    nodePackages."@astrojs/language-server"
  ]) ++ (with pkgs.nodePackages_latest; [
    typescript-language-server
    # HTML/CSS/JSON/ESLint language servers extracted from vscode
    vscode-langservers-extracted
    prettier
  ]);
in {
  imports = [ ];
  options = {
    neovim = {
      enable = lib.mkEnableOption (lib.mdDoc "neovim");
      technologies = lib.mkOption {
        type = lib.types.listOf (lib.types.enum technologies);
        default = technologies;
        description =
          lib.mdDoc "A list of technologies to install the dependencies for.";
      };
    };
  };
  config = lib.mkIf (cfg.enable) (lib.mkMerge [
    {
      home = {
        packages = with pkgs; [ neovim gcc ripgrep fd yaml-language-server ];
        file = {
          "nvim" = {
            enable = true;
            source = ./nvim;
            target = ".config/nvim";
            recursive = true;
          };
        };
      };
    }

    (lib.mkIf (builtins.elem "ansible" cfg.technologies) {
      home.packages = ansibleDependencies;
    })

    (lib.mkIf (builtins.elem "bash" cfg.technologies) {
      home.packages = bashDependencies;
    })

    (lib.mkIf (builtins.elem "docker" cfg.technologies) {
      home.packages = dockerDependencies;
    })

    # (lib.mkIf (builtins.elem "dotnet" cfg.technologies) {
    #   home = {
    #     packages = dotnetDependencies;
    #     file.omnisharp = {
    #       enable = true;
    #       source = ./.omnisharp;
    #       target = ".omnisharp";
    #       recursive = true;
    #     };
    #   };
    # })

    (lib.mkIf (builtins.elem "go" cfg.technologies) {
      home.packages = goDependencies;
    })

    (lib.mkIf (builtins.elem "haskell" cfg.technologies) {
      home.packages = haskellDependencies;
    })

    (lib.mkIf (builtins.elem "lua" cfg.technologies) {
      home.packages = luaDependencies;
    })

    (lib.mkIf (builtins.elem "nix" cfg.technologies) {
      home.packages = nixDependencies;
    })

    (lib.mkIf (builtins.elem "python" cfg.technologies) {
      home.packages = pythonDependencies;
    })

    (lib.mkIf (builtins.elem "rust" cfg.technologies) {
      home.packages = rustDependencies;
    })

    (lib.mkIf (builtins.elem "typst" cfg.technologies) {
      home.packages = typstDependencies;
    })

    (lib.mkIf (builtins.elem "webdev" cfg.technologies) {
      home.packages = webdevDependencies;
    })
  ]);
}

