{
  inputs = {
    auto-setup-lsp = {
      url = "github:Massolari/lsp-auto-setup.nvim";
      flake = false;
    };
    mini-icons = {
      url = "github:echasnovski/mini.icons";
      flake = false;
    };
    gitsigns-nvim = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    mini-diff = {
      url = "github:echasnovski/mini.diff";
      flake = false;
    };
    vim-nix = {
      url = "github:LnL7/vim-nix";
      flake = false;
    };
    lualine = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };
    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    lazygit-nvim = {
      url = "github:kdheepak/lazygit.nvim";
      flake = false;
    };
    nvim-web-devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };
    snacks = {
      url = "github:folke/snacks.nvim";
      flake = false;
    };
    codesnap-nvim = {
      url = "github:mistricky/codesnap.nvim";
      flake = false;
    };
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
    cord-nvim = {
      url = "github:vyfor/cord.nvim";
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs@{ nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      with import nixpkgs { inherit system; };
      let
        basePlugins = builtins.mapAttrs (name: src: vimUtils.buildVimPlugin { inherit name src; }) (
          builtins.removeAttrs inputs [
            "nixpkgs"
            "self"
            "flake-utils"
          ]
        );
        plugins = basePlugins // {
          snacks = basePlugins.snacks.overrideAttrs {
            nvimSkipModules = [
              "snacks.dashboard"
              "snacks.debug"
              "snacks.dim"
              "snacks.git"
              "snacks.image.convert"
              "snacks.image.image"
              "snacks.image.init"
              "snacks.image.placement"
              "snacks.indent"
              "snacks.input"
              "snacks.lazygit"
              "snacks.notifier"
              "snacks.picker.actions"
              "snacks.picker.config.highlights"
              "snacks.picker.core.list"
              "snacks.scratch"
              "snacks.scroll"
              "snacks.terminal"
              "snacks.win"
              "snacks.words"
              "snacks.zen"
              "trouble.sources.profiler"
              "snacks.picker.util.db"
            ];
          };
          noice = basePlugins.noice.overrideAttrs {
            dependencies = [ basePlugins.nui ];
            nvimRequireCheck = "noice";
          };
          which-key-nvim = basePlugins.which-key-nvim.overrideAttrs {
            nvimSkipModules = [ "which-key.docs" ];
          };
          cord-nvim =
            let
              version = "nightly";
              src = inputs.cord-nvim;
              rustPackage = rustPlatform.buildRustPackage {
                pname = "cord.nvim-rust";
                inherit version src;
                RUSTC_BOOTSTRAP = true;

                cargoHash = "sha256-5BsJJDQC/6VqkBIQf5SwBN5n6Ow3Hupr0Gfda5hG5WU=";

                installPhase =
                  let
                    cargoTarget = stdenv.hostPlatform.rust.cargoShortTarget;
                  in
                  ''
                    install -D target/${cargoTarget}/release/cord $out/lib/cord
                  '';
              };
            in
            vimUtils.buildVimPlugin {
              pname = "cord.nvim";
              inherit version src;

              nativeBuildInputs = [
                rustPackage
              ];

              buildPhase = ''
                install -D ${rustPackage}/lib/cord cord
              '';

              installPhase = ''
                install -D cord $out/lua/cord
              '';

              doInstallCheck = true;
              nvimRequireCheck = "cord";

              meta = {
                homepage = "https://github.com/vyfor/cord.nvim";
              };
            };

          codesnap-nvim =
            let
              version = "nightly";
              src = runCommandNoCCLocal "writable-codesnap-src" { } ''
                cp -r ${inputs.codesnap-nvim}/generator $out
              '';
              codesnap-lib = rustPlatform.buildRustPackage {
                pname = "codesnap";
                inherit version src;

                cargoHash = "sha256-tg4BO4tPzHhJTowL7RiAuBo4i440FehpGmnz9stTxfI=";
                nativeBuildInputs = [
                  pkg-config
                  rustPlatform.bindgenHook
                ];

                buildInputs =
                  [
                    libuv.dev
                  ]
                  ++ lib.optionals stdenv.hostPlatform.isDarwin [
                    darwin.apple_sdk.frameworks.AppKit
                  ];
              };
            in
            vimUtils.buildVimPlugin {
              pname = "codesnap.nvim";
              inherit version;
              src = inputs.codesnap-nvim;

              postInstall =
                let
                  extension = if stdenv.hostPlatform.isDarwin then "dylib" else "so";
                in
                ''
                  rm -rf $out/lua/*.so
                  cp ${codesnap-lib}/lib/libgenerator.${extension} $out/lua/generator.so
                '';

              doInstallCheck = true;
              nvimRequireCheck = "codesnap";
            };
        };
      in
      {
        packages = plugins;
        formatter = nixfmt-tree;
      }
    );
}
