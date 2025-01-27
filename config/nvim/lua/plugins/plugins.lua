return {
	"xiyaowong/transparent.nvim", -- transparency

	{ -- pywal color scheme
		"oncomouse/lushwal.nvim",
		cmd = { "LushwalCompile" },
		dependencies = {
			{ "rktjmp/lush.nvim" },
			{ "rktjmp/shipwright.nvim" },
		},
		lazy = false,
	},

	-- autocomplete setup
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',   -- LSP source
	'hrsh7th/cmp-buffer',     -- Buffer source
	'hrsh7th/cmp-path',       -- Path source
	'saadparwaiz1/cmp_luasnip', -- LuaSnip source
	'L3MON4D3/LuaSnip',       -- Snippet engine

	{ -- for code folding
		"kevinhwang91/nvim-ufo",
		dependencies = {
			{ "kevinhwang91/promise-async" }
		}
	},

	"nvim-tree/nvim-tree.lua", -- tree file explorer
	opts = {}
}
