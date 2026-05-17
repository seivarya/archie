return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",

		},
		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")

			-- on_attach
			local on_attach = function(client, _)
			end

			-- capabilities
			local capabilities = cmp_lsp.default_capabilities()

			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true
			}

			capabilities.textDocument.completion.completionItem = {
				documentationFormat = { "markdown", "plaintext" },
				snippetSupport = true,
				preselectSupport = true,
				insertReplaceSupport = true,
				labelDetailsSupport = true,
				deprecatedSupport = true,
				commitCharactersSupport = true,
				tagSupport = { valueSet = { 1 } },
				resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				},
			}

			local servers = {
				"html", "pyright", "emmet_ls", "clangd",
				"cssls", "rnix", "hls", "gopls",
				"astro", "volar"
			}

			for _, server in ipairs(servers) do
				vim.lsp.config(server, {
					on_attach = on_attach,
					capabilities = capabilities,
				})
				vim.lsp.enable(server)
			end

			-- rust
			vim.lsp.config("rust_analyzer", {
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "rustup", "run", "stable", "rust-analyzer" },
			})
			vim.lsp.enable("rust_analyzer")

			-- lua
			vim.lsp.config("lua_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace"
						},
						diagnostics = {
							globals = {
								"vim", "awesome", "client",
								"screen", "mouse", "tag"
							},
						},
					},
				}
			})
			vim.lsp.enable("lua_ls")
		end,
	},
}
