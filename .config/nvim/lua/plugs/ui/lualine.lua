return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		priority = 1000,

		config = function()
			local mono = {
				-- sexy monochrome palette
				-- black       = "#0a0a0a",
				-- bg          = "#111111",
				-- bg_dark     = "#161616",
				-- bg_soft     = "#1d1d1d",
				-- bg_light    = "#262626",
				--
				-- gray_1      = "#3a3a3a",
				-- gray_2      = "#525252",
				-- gray_3      = "#737373",
				--
				-- white       = "#f5f5f5",
				-- text        = "#d4d4d4",
				-- subtext     = "#a1a1a1",
				--
				-- border      = "#2a2a2a",
			}

			local custom_theme = {
				normal = {
					a = { fg = mono.black, bg = mono.white, gui = 'bold' },
					b = { fg = mono.text, bg = mono.bg_soft },
					c = { fg = mono.subtext, bg = mono.bg },
					z = { fg = mono.black, bg = mono.white, gui = 'bold' },
				},

				insert = {
					a = { fg = mono.black, bg = "#d9d9d9", gui = 'bold' },
					b = { fg = mono.text, bg = mono.bg_soft },
					c = { fg = mono.subtext, bg = mono.bg },
					z = { fg = mono.black, bg = "#d9d9d9", gui = 'bold' },
				},

				visual = {
					a = { fg = mono.white, bg = mono.gray_2, gui = 'bold' },
					b = { fg = mono.text, bg = mono.bg_soft },
					c = { fg = mono.subtext, bg = mono.bg },
					z = { fg = mono.white, bg = mono.gray_2, gui = 'bold' },
				},

				replace = {
					a = { fg = mono.white, bg = mono.gray_1, gui = 'bold' },
					b = { fg = mono.text, bg = mono.bg_soft },
					c = { fg = mono.subtext, bg = mono.bg },
					z = { fg = mono.white, bg = mono.gray_1, gui = 'bold' },
				},

				command = {
					a = { fg = mono.black, bg = mono.gray_3, gui = 'bold' },
					b = { fg = mono.text, bg = mono.bg_soft },
					c = { fg = mono.subtext, bg = mono.bg },
					z = { fg = mono.black, bg = mono.gray_3, gui = 'bold' },
				},

				inactive = {
					a = { fg = mono.gray_2, bg = mono.bg, gui = 'none' },
					b = { fg = mono.gray_2, bg = mono.bg },
					c = { fg = mono.gray_3, bg = mono.bg },
					z = { fg = mono.gray_2, bg = mono.bg, gui = 'none' },
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
							color = { fg = mono.bg, bg = mono.bg }
						})
					end

					for idx, comp in ipairs(section) do
						if type(comp) ~= 'table' then
							comp = { comp }
							section[idx] = comp
						end

						comp.separator = left
						and { right = '' }
						or { left = '' }
					end
				end

				return sections
			end

			local function search_result()
				if vim.v.hlsearch == 0 then
					return ''
				end

				local last = vim.fn.getreg('/')

				if not last or last == '' then
					return ''
				end

				local count = vim.fn.searchcount({ maxcount = 9999 })

				return last .. '(' .. count.current .. '/' .. count.total .. ')'
			end

			local function modified()
				if vim.bo.modified then
					return '●'
				end

				if vim.bo.modifiable == false or vim.bo.readonly == true then
					return ''
				end

				return ''
			end

			require('lualine').setup({
				options = {
					theme = "tokyonight",

					component_separators = '',
					section_separators = {
						left = '',
						right = '',
					},

					globalstatus = true,
					icons_enabled = true,

					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
				},

				sections = process_sections({
					lualine_a = {
						{
							'mode',
							color = { gui = 'bold' },
						},
					},

					lualine_b = {
						{
							'branch',
							icon = '',
							color = { fg = mono.white },
						},

						{
							'diff',
							symbols = {
								added = '│+ ',
								modified = '│~ ',
								removed = '│- ',
							},
						},

						{
							'diagnostics',
							source = { 'nvim' },
							sections = { 'error', 'warn', 'info' },

							diagnostics_color = {
								error = { fg = "#ffffff", bg = mono.bg_soft },
								warn  = { fg = "#bdbdbd", bg = mono.bg_soft },
								info  = { fg = "#8c8c8c", bg = mono.bg_soft },
							},
						},

						{
							'filename',
							path = 1,
							color = { fg = mono.white },
						},

						{ modified },
					},

					lualine_c = {},

					lualine_x = {
						{
							search_result,
							color = { fg = mono.gray_3 },
						},

						{
							function()
								return os.date('%H:%M:%S')
							end,
							color = { fg = mono.white },
						},

						{
							"require'lsp-status'.status()",
							color = { fg = mono.subtext },
						},

						{
							'encoding',
							color = { fg = mono.gray_3 },
						},
					},

					lualine_y = {
						{
							'progress',
							color = { fg = mono.white },
						},
					},

					lualine_z = {
						{
							'%l:%c',
							color = { fg = mono.black, bg = mono.white, gui = 'bold' },
						},

						{
							'%p%%/%L',
							color = { fg = mono.black, bg = "#d0d0d0", gui = 'bold' },
						},
					},
				}),

				inactive_sections = {
					lualine_c = { '%f %y %m' },
					lualine_x = {},
				},

				extensions = {
					'nvim-tree',
					'quickfix',
					'fugitive',
				},
			})
		end,
	},
}
