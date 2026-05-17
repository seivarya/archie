local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({

	{ import = 'plugs.ui.lush' },
	{ import = 'plugs.util.shipwright' },
	{ import = 'plugs.lsp.init' },
	{ import = 'plugs.ui.lualine' },
	{ import = 'plugs.ui.cursor' },
	{ import = 'plugs.util.telescope' },
	{ import = 'plugs.ui.which-key' },
	{ import = 'plugs.util.treesitter' },
	{ import = 'plugs.ui.colorscheme' },
	{ import = 'plugs.util.todo' },
	{ import = 'plugs.snippets.luasnip' },
}, {
		ui = {
			icons = {},
			border = "rounded",
			wrap = true,
		},
	})
