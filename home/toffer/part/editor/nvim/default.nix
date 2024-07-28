{ config, lib, pkgs, vars, ... }:

let
  cfg = config.neovim;
  # TODO: Update neovim config to split servers dictionary in lsp.lua into individual files and add to the servers dict 
  # from a central lsp.lua file. Then each lib.mkIf in here can also include that file with home.file to ensure only 
  # the servers installed are run. That are do some exception handling.
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
in {
  imports = [ ];
  options = {
    neovim = {
      enable = lib.mkEnableOption (lib.mdDoc "neovim");
      configurationFiles = lib.mkOption {
        type = lib.types.path;
        default = "./config";
        description =
          lib.mdDoc "The folder to place under the path $HOME/.config/nvim.";
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
            source = cfg.configurationFiles;
            target = ".config/nvim";
            recursive = true;
          };
        };
      };
    }

    (lib.mkIf (builtins.elem "docker" cfg.technologies) {
      home.packages = with pkgs; [
        dockerfile-language-server-nodejs
        docker-compose-language-service
      ];
    })

    (lib.mkIf (builtins.elem "dotnet" cfg.technologies) {
      home = {
        packages = with pkgs; [ dotnet-sdk_8 omnisharp-roslyn ];
        file.omnisharp = {
          enable = true;
          source = "${vars.homeDir}/.yadr/dotfiles/omnisharp";
          target = ".omnisharp";
          recursive = true;
        };
      };
    })

    (lib.mkIf (builtins.elem "go" cfg.technologies) {
      home.packages = with pkgs; [ gopls go templ ];
    })

    (lib.mkIf (builtins.elem "haskell" cfg.technologies) {
      home.packages = with pkgs; [ haskell-language-server ];
    })

    (lib.mkIf (builtins.elem "lua" cfg.technologies) {
      home.packages = with pkgs; [ lua-language-server ];
    })

    (lib.mkIf (builtins.elem "nix" cfg.technologies) {
      home.packages = with pkgs; [ nil nixd nixfmt ];
    })

    (lib.mkIf (builtins.elem "python" cfg.technologies) {
      home.packages = with pkgs; [
        # Python312 might be needed by techonolgies other than Python.
        python312
        pyright
      ];
    })

    (lib.mkIf (builtins.elem "rust" cfg.technologies) {
      home.packages = with pkgs; [
        # Cargo might be neede by technologies than Rust.
        cargo
        rustc
        rust-analyzer
      ];
    })

    (lib.mkIf (builtins.elem "typst" cfg.technologies) {
      home.packages = with pkgs; [ typst-lsp ];
    })

    (lib.mkIf (builtins.elem "webdev" cfg.technologies) {
      home.packages = (with pkgs; [
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
    })
  ]);
}

