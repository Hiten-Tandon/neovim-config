return {
  { "folke/trouble.nvim" },
  { "jalvesaq/Nvim-R" },
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_config = {
          prompt_position = "top",
        },
      },
    },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {
          settings = {},
        },
        hls = { mason = false },
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    opts = {
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
    -- your lsp config or other stuff
  },
  { "simrat39/rust-tools.nvim" },
  { "nvim-treesitter/nvim-treesitter-context", opts = {} },
  { "sputnick1124/uiua.vim" },
  { "ziglang/zig.vim" },
  { "nvim-neotest/nvim-nio" },
  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim" },
    opts = {},
  },
  {
    "stevearc/overseer.nvim",
    commit = "68a2d344cea4a2e11acfb5690dc8ecd1a1ec0ce0",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
  { "OXY2DEV/markview.nvim", lazy = false },
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "Konfekt/vim-latexencode" },
    config = function()
      require("render-markdown").setup({})
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
  { "olimorris/onedarkpro.nvim", priority = 1000, name = "onedarkpro" },
  { "navarasu/onedark.nvim", priority = 1000, opts = { style = "warmer" } },
  { "eldritch-theme/eldritch.nvim", priority = 1000, opts = {} },
  { "EdenEast/nightfox.nvim" },
  {
    "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup({ options = { transparent = true } })
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Recommended - see "Configuring" below for more config options
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
        terminal_colors = true,
      })
    end,
  },
  { "sainnhe/sonokai" },
  { "mofiqul/dracula.nvim" },
  { "LazyVim/LazyVim", opts = { colorscheme = "cyberdream" } },
  {
    "neovim/nvim-lspconfig",
    opts = {
      codelens = {
        enabled = true,
      },

      servers = {
        gleam = {
          mason = false,
        },
        ruff = {
          mason = false,
          cmd = { "ruff", "server", "--preview" },
        },
        ruff_lsp = { mason = false },
      },
    },
  },
  { "Jezda1337/nvim-html-css" },
  { "LhKipp/nvim-nu" },
  {
    "arminveres/md-pdf.nvim",
    branch = "main", -- you can assume that main is somewhat stable until releases will be made
    lazy = true,
    keys = {
      {
        "<leader>m",
        function()
          require("md-pdf").convert_md_to_pdf()
        end,
        desc = "Markdown preview",
      },
    },
    opts = {
      toc = false,
      preview_cmd = function()
        return "brave"
      end,
    },
  },
  {
    "realprogrammersusevim/md-to-html.nvim",
    cmd = { "MarkdownToHTML", "NewMarkdownToHTML" },
  },
  {
    "Exafunction/codeium.nvim",
    opts = {
      enable_chat = true,
    },
  },
  {
    "LukasPietzschmann/telescope-tabs",
    config = function()
      require("telescope").load_extension("telescope-tabs")
      require("telescope-tabs").setup({
        -- Your custom config :^)
      })
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "mistricky/codesnap.nvim",
    build = "make",
    opts = {
      watermark = "Hiten Tandon",
    },
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    opts = {
      bin_path = "/home/hitentandon/Public/bin",
    },
  }, -- lazy.nvim:
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>M",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
  },
}
