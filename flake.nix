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
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      with import nixpkgs {
        inherit system;
        overlays = [ neovim-nightly.overlays.default ];
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "codeium" ];
      }; {
        packages.default = wrapNeovimUnstable neovim-unwrapped {
          viAlias = true;
          vimAlias = true;
          withPython3 = true;
          withRuby = true;
          withNodeJs = true;
          withPerl = true;
          neovimRcContent = builtins.readFile ./init.vim;
          luaRcContent = builtins.readFile ./init.lua;
          plugins =
            (builtins.attrValues plugins.outputs.packages.${system})
            ++ (with vimPlugins; [
              nvim-treesitter
              nvim-treesitter-textsubjects
              nvim-treesitter-textobjects
              nvim-treesitter-sexp
              nvim-treesitter-refactor
              nvim-treesitter-pyfold
              nvim-treesitter-parsers.nix
              windsurf-nvim
            ]);
        };
        formatter = nixfmt-tree;
      }
    );
}
