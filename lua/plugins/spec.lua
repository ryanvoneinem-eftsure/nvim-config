return {
			 {
			     "rose-pine/neovim",
			     styles = { italic = false },
			     lazy = false,
			     priority = 1000,
			     config = function()
			require("rose-pine").setup{
				styles = {
					italic = false
				}
			}
			         vim.cmd([[colorscheme rose-pine]])
			     end,
			 },
			 {
			     "nvim-treesitter/nvim-treesitter",
			     build = ":TSUpdate",
			     config = function()
			          require("nvim-treesitter.configs").setup{
			             highlight = {
			                 enable = true,
			                 additional_vim_regex_highlighting = false,
			             },
			         }
			     end
			 },
			 {
			     "windwp/nvim-autopairs",
			     event = "VeryLazy",
                 opts = {}
			 },
             {
                 'nvim-telescope/telescope.nvim', tag = '0.1.8',
                 dependencies = { 'nvim-lua/plenary.nvim' }
             },
             {
                 'nvim-tree/nvim-web-devicons', opts = {}
             },
	   {
	       "williamboman/mason.nvim",
	       lazy = false,
	       opts = {},
	       config = function()
	           require("mason").setup()
	       end,
	   },
	   {
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		config = function()
			local cmp = require('cmp')

			cmp.setup({
				sources = {
					{name = 'nvim_lsp'},
				},
				mapping = cmp.mapping.preset.insert({
					['<C-Space>'] = cmp.mapping.complete(),
					-- ['<C-u>'] = cmp.mapping.scroll_docs(-4),
					-- ['<C-d>'] = cmp.mapping.scroll_docs(4),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
	                   ["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
	                           cmp.select_next_item()
						else
							fallback()
						end
					end, {"i","s","c",}),
	                   ["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
	                           cmp.select_prev_item()
						else
							fallback()
						end
					end, {"i","s","c",}),
				}),
				-- snippet = {
				-- 	expand = function(args)
				-- 		vim.snippet.expand(args.body)
				-- 	end,
				-- },
			})
		end
	   },
	{
	   'neovim/nvim-lspconfig',
	   cmd = {'LspInfo', 'LspInstall', 'LspStart'},
	   event = {'BufReadPre', 'BufNewFile'},
	   dependencies = {
	     {'hrsh7th/cmp-nvim-lsp'},
	     {'williamboman/mason.nvim'},
	     {'williamboman/mason-lspconfig.nvim'},
	   },
	   init = function()
	     -- Reserve a space in the gutter
	     -- This will avoid an annoying layout shift in the screen
	     vim.opt.signcolumn = 'yes'
	   end,
	   config = function()
	     local lsp_defaults = require('lspconfig').util.default_config

	     -- Add cmp_nvim_lsp capabilities settings to lspconfig
	     -- This should be executed before you configure any language server
	     lsp_defaults.capabilities = vim.tbl_deep_extend(
	       'force',
	       lsp_defaults.capabilities,
	       require('cmp_nvim_lsp').default_capabilities()
	     )

	     -- LspAttach is where you enable features that only work
	     -- if there is a language server active in the file
	     vim.api.nvim_create_autocmd('LspAttach', {
	       desc = 'LSP actions',
	       callback = function(event)
	         local opts = {buffer = event.buf}

	         vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	         vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	         vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	         vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	         vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	         vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	         vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	         vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	         vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
	         vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
	       end,
	     })

	     require('mason-lspconfig').setup({
	       ensure_installed = {},
	       handlers = {
	         -- this first function is the "default handler"
	         -- it applies to every language server without a "custom handler"
	         function(server_name)
	           require('lspconfig')[server_name].setup({})
	         end,
	       }
	     })
	   end
	 },
	{
	  "yetone/avante.nvim",
	  event = "VeryLazy",
	  version = "0.0.23", -- Never set this value to "*"! Never!
	  opts = {
		-- add any opts here
		-- for example
		provider = "gemini",
        gemini = {
            model = "gemini-2.5-flash-preview-04-17"
        },
		auto_suggestions_provider = "gemini",
		behaviour = {
            --auto_suggestions = true,
            --auto_suggestions_respect_ignore = true,
			enable_cursor_planning_mode = true,
			enable_claude_text_editor_tool_mode = true,
		},
		web_search_engine = {
			provider = "google",
		},
	  },
	  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	  build = "make BUILD_FROM_SOURCE=true",
	  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	  dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
		  -- support for image pasting
		  "HakonHarnes/img-clip.nvim",
		  event = "VeryLazy",
		  opts = {
			-- recommended settings
			default = {
			  embed_image_as_base64 = false,
			  prompt_for_file_name = false,
			  drag_and_drop = {
				insert_mode = true,
			  },
			  -- required for Windows users
			  use_absolute_path = true,
			},
		  },
		},
		{
		  -- Make sure to set this up properly if you have lazy=true
		  'MeanderingProgrammer/render-markdown.nvim',
		  opts = {
			file_types = { "markdown", "Avante" },
		  },
		  ft = { "markdown", "Avante" },
		},
	  },
	}
}
