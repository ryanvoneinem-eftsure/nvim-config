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
        event = "InsertEnter",
        config = true
    },
}
