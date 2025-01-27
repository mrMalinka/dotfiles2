{ ... }:

{

home.file."~/.config/nvim/init.lua".text = ''
require("config.lazy")

-- basic setup
vim.cmd("colorscheme lushwal") -- colors

vim.g.loaded_netrw = 1 -- nvim tree told me to do this
vim.g.loaded_netrwPlugin = 1

vim.opt.tabstop = 4 -- tab width
vim.opt.shiftwidth = 4
vim.opt.smarttab = true -- autodetect tab width

vim.opt.number = true -- line numbers
vim.opt.cursorline = true -- line number highlight
vim.opt.relativenumber = true -- relative line numbers

vim.opt.list = true -- tab characters
vim.opt.listchars = {tab="󰶻 ", trail=""}
vim.g.transparent_groups = vim.list_extend(
	vim.g.transparent_groups or {},
	{ "Whitespace" } -- vim gamer god
)

-- disable arrow keys
for _, mode in pairs({ 'n', 'i' }) do
	for _, key in pairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
		vim.keymap.set(mode, key, function ()
			vim.cmd("echo \"stawp it\"")
		end)
	end
end


-- scrolloff
vim.opt.scrolloff = 6

-- nvim tree setup
require("nvim-tree").setup()

-- code folding setup (ufo)
vim.opt.foldcolumn = '1' -- Show fold column
vim.opt.foldlevel = 99   -- Set high fold level to open most folds by default
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {"treesitter", "indent"}
    end
})

-- autocomplete setup *(cmp / luasnip)
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
	end,
	},
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item(),
		["<Down>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		['<S-Tab>'] = cmp.mapping.confirm({ select = true }),
		["<C-Tab>"] = cmp.mapping.complete()
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "luasnip" },
	}
})
'';

home.file.".config/nvim/lua/config/lazy.lua".text = ''
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
'';

home.file.".config/nvim/lua/plugins/plugins.lua".text = ''
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
'';

}
