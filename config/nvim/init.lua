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
