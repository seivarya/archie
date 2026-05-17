return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		priority = 1000,

		config = function()
			local ctp = {
				base = "#12131b",
				surface0 = "#0f1016",
				text = "#c0caf5",
				subtext1 = "#a9b1d6",
				blue = "#7aa2f7",
				green = "#9ece6a",
				mauve = "#bb9af7",
				red = "#f7768e",
				peach = "#ff9e64",
				yellow = "#e0af68",
				overlay0 = "#565f89",
				overlay1 = "#414868"
			}

			local custom_theme = {
				normal = {
					a = { fg = ctp.base, bg = ctp.blue, gui = 'none' },
					b = { fg = ctp.text, bg = ctp.surface0 },
					c = { fg = ctp.subtext1, bg = ctp.base },
					z = { fg = ctp.base, bg = ctp.blue, gui = 'none' },
				},
				insert = {
					a = { fg = ctp.base, bg = ctp.green, gui = 'none' },
					b = { fg = ctp.text, bg = ctp.surface0 },
					c = { fg = ctp.subtext1, bg = ctp.base },
					z = { fg = ctp.base, bg = ctp.green, gui = 'none' },
				},
				visual = {
					a = { fg = ctp.base, bg = ctp.mauve, gui = 'none' },
					b = { fg = ctp.text, bg = ctp.surface0 },
					c = { fg = ctp.subtext1, bg = ctp.base },
					z = { fg = ctp.base, bg = ctp.mauve, gui = 'none' },
				},
				replace = {
					a = { fg = ctp.base, bg = ctp.red, gui = 'none' },
					b = { fg = ctp.text, bg = ctp.surface0 },
					c = { fg = ctp.subtext1, bg = ctp.base },
					z = { fg = ctp.base, bg = ctp.red, gui = 'none' },
				},
				command = {
					a = { fg = ctp.base, bg = ctp.peach, gui = 'none' },
					b = { fg = ctp.text, bg = ctp.surface0 },
					c = { fg = ctp.subtext1, bg = ctp.base },
					z = { fg = ctp.base, bg = ctp.peach, gui = 'none' },
				},
				inactive = {
					a = { fg = ctp.overlay1, bg = ctp.base, gui = 'none' },
					b = { fg = ctp.overlay1, bg = ctp.base },
					c = { fg = ctp.overlay0, bg = ctp.base },
					z = { fg = ctp.overlay1, bg = ctp.base, gui = 'none' },
				},
			}

			local empty = require('lualine.component'):extend()
			function empty:draw(default_highlight)
				self.status = ''
				self.applied_separator = ''
				self:apply_highlights(default_highlight)
				self:apply_section_separators()
				return self.status
			end

			local function process_sections(sections)
				for name, section in pairs(sections) do
					local left = name:sub(9, 10) < 'x'
					for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
						table.insert(section, pos * 2, {
							empty,
							color = { fg = ctp.base, bg = ctp.base }
						})
					end

					for idx, comp in ipairs(section) do
						if type(comp) ~= 'table' then
							comp = { comp }
							section[idx] = comp
						end
						comp.separator = left and { right = '' } or { left = '' }
					end
				end
				return sections
			end

			local function search_result()
				if vim.v.hlsearch == 0 then return '' end
				local last = vim.fn.getreg('/')
				if not last or last == '' then return '' end
				local count = vim.fn.searchcount { maxcount = 9999 }
				return last .. '(' .. count.current .. '/' .. count.total .. ')'
			end

			local function modified()
				if vim.bo.modified then return '+' end
				if vim.bo.modifiable == false or vim.bo.readonly == true then return '-' end
				return ''
			end

			require('lualine').setup {
				options = {
					theme = custom_theme,
					component_separators = '',
					section_separators = { left = '', right = '' },
					globalstatus = true,
					icons_enabled = true,
				},

				sections = process_sections {
					lualine_a = {
						{ 'mode', color = { gui = 'none' } },
					},

					lualine_b = {
						{ 'branch', icon = 'branch:', color = { gui = 'none' } },
						{ 'diff', symbols = { added = '+', modified = '~', removed = '-' } },

						{
							'diagnostics',
							source = { 'nvim' },
							sections = { 'error' },
							diagnostics_color = {
								error = { fg = ctp.red, bg = ctp.surface0 }
							},
						},
						{
							'diagnostics',
							source = { 'nvim' },
							sections = { 'warn' },
							diagnostics_color = {
								warn = { fg = ctp.yellow, bg = ctp.surface0 }
							},
						},

						{ 'filename', path = 1 },
						{ modified },
					},

					lualine_c = {},

					lualine_x = {
						search_result,
						{ function() return os.date('%H:%M:%S') end },
						{ "require'lsp-status'.status()" },
						{ 'encoding' },
					},

					lualine_y = { 'progress' },

					lualine_z = { '%l:%c', '%p%%/%L' },
				},

				inactive_sections = {
					lualine_c = { '%f %y %m' },
					lualine_x = {},
				},

				extensions = { 'nvim-tree', 'quickfix', 'fugitive' },
			}
		end,
	},
}
