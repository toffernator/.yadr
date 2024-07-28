{ config, lib, pkgs, vars, ... }:

let
  cfg = config.neovim;
  dotfilesDir = config.lib.file.mkOutOfStoreSymlink config.neovim.dotfiles;
  # TODO: Update neovim config to split servers dictionary in lsp.lua into individual files and add to the servers dict from a central lsp.lua file.
  # Then each lib.mkIf in here can also include that file with home.file to ensure only the servers installed are run. That are do some exception handling.
  technologies = [
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

  dockerDependencies = with pkgs; [
    dockerfile-language-server-nodejs
    docker-compose-language-service
  ];
  dotnetDependencies = with pkgs; [ dotnet-sdk_8 omnisharp-roslyn ];
  goDependencies = with pkgs; [ gopls go templ ];
  haskellDependencies = with pkgs; [ haskell-language-server ];
  luaDependencies = with pkgs; [ lua-language-server ];
  nixDependencies = with pkgs; [ nil nixd nixfmt ];
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
      dotfiles = lib.mkOption {
        type = lib.types.path;
        default = "${vars.homeDir}/.yadr/dotfiles/nvim";
        description = lib.mdDoc "The path to the dotfiles configuring neovim";
      };
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
        packages = with pkgs; [ neovim gcc ripgrep fd ];
        file = {
          "nvim" = {
            enable = true;
            source = "${dotfilesDir}";
            target = ".config/nvim";
            recursive = true;
          };
        };
      };
    }

    (lib.mkIf (builtins.elem "docker" cfg.technologies) {
      home.packages = dockerDependencies;
    })

    (lib.mkIf (builtins.elem "dotnet" cfg.technologies) {
      home = {
        packages = dotnetDependencies;
        file.omnisharp = {
          enable = true;
          source = "${vars.homeDir}/.yadr/dotfiles/omnisharp";
          target = ".omnisharp";
          recursive = true;
        };
      };
    })

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

