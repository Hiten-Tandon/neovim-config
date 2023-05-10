return {
	{ "ErichDonGubler/lsp_lines.nvim" },
	{
		"nvim-tree/nvim-web-devicons",
		opts = {
			override = {
				zsh = {
					icon = "",
					color = "#428850",
					cterm_color = "65",
					name = "Zsh"
				}
			},
			color_icons = true,
			default = true,
			strict = true,
			override_by_filename = {
				[".gitignore"] = {
					icon = "",
					color = "#f1502f",
					name = "Gitignore"
				}
			},
			override_by_extension = {
				["log"] = {
					icon = '',
					color = "#81e043",
					name = "Log"
				}
			},
		}

	},
	{ "windwp/nvim-autopairs",        opts = {} },
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local rust_tools = require('rust-tools')
			rust_tools.setup {}
			rust_tools.inlay_hints.enable()
		end
	},
	{ "davidgranstrom/nvim-markdown-preview" },
	{ "windwp/nvim-ts-autotag",              opts = {} },

}
