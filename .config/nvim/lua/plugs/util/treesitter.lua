return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter").setup({
				--[[ ensure specified parsers are installed ]]
				ensure_installed = {
					"lua", "python", "c", "cpp",
					"html", "css", "javascript", "typescript",
					"rasi", "hyprlang", "jsonc", "bash", "ini", "toml"
				},

				sync_install = false,
				auto_install = true,

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},

				indent = {
					enable = true, --[[ enable language-specific indentation ]]
				},

				autotag = {
					enable = true,
					filetypes = {
						"html", "xml",
						"javascriptreact", "typescriptreact"
					},
				},

				rainbow = {
					enable = true,
					extended_mode = false,
					max_file_lines = nil,
				},
			})
		end,
	},
}

