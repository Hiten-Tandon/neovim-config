{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    screen-key = {
      url = "github:NStefan002/screenkey.nvim";
      flake = false;
    };
    rose-pine = {
      url = "github:rose-pine/neovim";
      flake = false;
    };
    noice = {
      url = "github:folke/noice.nvim";
      flake = false;
    };
    nui = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
    which-key-nvim = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      neovim-nightly,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      with import nixpkgs {
        inherit system;
        overlays = [ neovim-nightly.overlays.default ];
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "codeium" ];
      };
      let
        screen-key = vimUtils.buildVimPlugin {
          name = "screen-key";
          src = inputs.screen-key;
        };
        rose-pine = vimUtils.buildVimPlugin {
          name = "rose-pine";
          src = inputs.rose-pine;
        };
        nui = vimUtils.buildVimPlugin {
          name = "nui";
          src = inputs.nui;
        };
        noice = vimUtils.buildVimPlugin {
          name = "noice";
          src = inputs.noice;
          dependencies = [ nui ];
          nvimRequireCheck = "noice";
        };
        which-key-nvim = vimUtils.buildVimPlugin {
          name = "which-key";
          src = inputs.which-key-nvim;
          nvimSkipModules = [ "which-key.docs" ];
        };
      in
      {
        packages.default = wrapNeovimUnstable neovim-unwrapped {
          viAlias = true;
          vimAlias = true;
          withPython3 = true;
          withRuby = true;
          withNodeJs = true;
          withPerl = true;
          neovimRcContent = builtins.readFile ./init.vim;
          luaRcContent = builtins.readFile ./init.lua;
          plugins = with vimPlugins; [
            rose-pine
            which-key-nvim
            cord-nvim
            screen-key
            codesnap-nvim
            snacks-nvim
            lazy-nvim
            nvim-web-devicons
            noice
            lazygit-nvim
            nvim-treesitter
            nvim-treesitter-textsubjects
            nvim-treesitter-textobjects
            nvim-treesitter-sexp
            nvim-treesitter-refactor
            nvim-treesitter-pyfold
            nvim-treesitter-parsers.nix
            nvim-lspconfig
            lualine-nvim
            windsurf-nvim
            mini-icons
            gitsigns-nvim
            mini-diff
            vim-nix
            vim-addon-nix
          ];
        };
        formatter = nixfmt-rfc-style;
      }
    );
}
