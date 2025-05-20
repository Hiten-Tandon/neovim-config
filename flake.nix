{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    plugins.url = ./plugins;
  };

  outputs =
    {
      nixpkgs,
      neovim-nightly,
      flake-utils,
      plugins,
      self,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      with import nixpkgs {
        inherit system;
        overlays = [ neovim-nightly.overlays.default ];
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "codeium" ];
      }; rec {
        languages = {
          rust = {
            lsp = rust-analyzer;
            formatter = rustfmt;
            tree-sitter = vimPlugins.nvim-treesitter-parsers.rust;
            programs = [ cargo rustc ];
            plugins = [ vimPlugins.rustaceanvim ];
          };
          typescript = {
            lsp = typescript-language-server;
            formatter = prettierd;
            tree-sitter = vimPlugins.nvim-treesitter-parsers.typescript;
            programs = [ nodejs_latest typescript live-server ];
            plugins = [vimPlugins.typescript-tools-nvim vimPlugins.typescript-nvim];
          };
        };
        packages = {
          default = symlinkJoin {
            name = "neovim";
            paths =
              ([
                fd
                packages.neovim
                tree-sitter
                imagemagick
                ghostscript
                (lua.withPackages (p: with p; [ lua-lsp ]))
                stylua
              ]
              ++ languages.rust.programs
              ++ (with languages.rust; [
                lsp
                formatter
              ])
              ++ (with languages.typescript; [
                lsp
                formatter
              ]));
            meta.mainProgram = "nvim";
          };
          neovim = (
            wrapNeovimUnstable neovim-unwrapped {
              viAlias = true;
              vimAlias = true;
              withPython3 = true;
              withRuby = true;
              withNodeJs = true;
              withPerl = true;
              neovimRcContent = builtins.readFile ./init.vim;
              luaRcContent = ''vim.opt.rtp:prepend('${plugins.outputs.packages.${system}.nvim-lspconfig}')
              ${ builtins.readFile ./init.lua}
              '';
              plugins =
                (builtins.attrValues plugins.outputs.packages.${system})
                ++ (
                  with vimPlugins;
                  [
                    nvim-treesitter
                    nvim-treesitter-textsubjects
                    nvim-treesitter-textobjects
                    nvim-treesitter-sexp
                    nvim-treesitter-refactor
                    nvim-treesitter-pyfold
                    nvim-treesitter-parsers.nix
                    nvim-treesitter-parsers.lua
                    windsurf-nvim
                  ]
                  ++ languages.rust.plugins
                  ++ [languages.rust.tree-sitter]
                  ++ languages.typescript.plugins
                  ++ [languages.typescript.tree-sitter]
                );
            }
          );
        };
        formatter = nixfmt-tree;
      }
    );
}
