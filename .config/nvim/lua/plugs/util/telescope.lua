return {
	{ -- Fuzzy Finder (files, lsp, etc)
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				'nvim-telescope/telescope-fzf-native.nvim',

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = 'make',

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			--[[ { 'nvim-telescope/telescope-ui-select.nvim' }, ]]
			--[[ { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, ]]
		},
		config = function()
			require('telescope').setup {
				extensions = {},
			}

			pcall(require('telescope').load_extension, 'fzf')

			local builtin = require 'telescope.builtin'

			vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[G]it [S]tatus' })
			vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })

			vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
			vim.keymap.set('n', '<leader>sf', builtin.buffers, { desc = '[ ] Find existing buffers' })

			vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
			vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

			vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
			vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

			-- all files
			vim.keymap.set('n', '<leader><leader>', function()
				require('telescope.builtin').find_files {
					cwd = vim.fn.expand '../../../../../../',
				}
			end, { desc = '[S]earch [A]ll [F]iles' })

			-- uh
			vim.keymap.set('n', '<leader>/', function()
				builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 3,
					previewer = true,
				})
			end, { desc = '[/] Fuzzily search in current buffer' })

			-- grep eh
			vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })

			-- live grep eh
			vim.keymap.set('n', '<leader>s/', function()
				builtin.live_grep {
					grep_open_files = true,
					prompt_title = 'Live Grep in Open Files',
				}
			end, { desc = '[S]earch [/] in Open Files' })

			-- search man pages
			vim.keymap.set('n', '<leader>z', function()
				builtin.man_pages {
					prompt_title = 'Man Pages',
				}
			end, { desc = '[S]earch [M]an [P]ages' })

			-- neovim config files uh
			vim.keymap.set('n', '<leader>sn', function()
				builtin.find_files {
					cwd = vim.fn.stdpath 'config',
				}
			end, { desc = '[S]earch [N]eovim files' })
		end,
	},
} 
