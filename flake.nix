{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
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
      };
      let
        screen-key = vimUtils.buildVimPlugin {
          name = "screen-key-nvim";
          src = fetchFromGitHub {
            owner = "NStefan002";
            repo = "screenkey.nvim";
            rev = "fb71120b49b075bc7e75b0756c1b0faa4fc4066d";
            sha256 = "q0hMAtwP4RkmCfFGyEBvw+E/clnC+oRE8FB9TDgZCzo=";
          };
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
            screen-key
            codesnap-nvim
            snacks-nvim
            lazy-nvim
            nvim-web-devicons
            noice-nvim
            lazygit-nvim
            nvim-treesitter
            nvim-treesitter-parsers.nix
            nvim-lspconfig
            lualine-nvim
          ];
        };
        formatter = nixfmt-rfc-style;
      }
    );
}
