return {
	"nvim-treesitter/nvim-treesitter",

	build = ":TSUpdate",

	event = "BufReadPre",

	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"css",
				"diff",
				"gitignore",
				"html",
				"javascript",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"rust",
				"typescript",
				"vim",
				"vimdoc",
			},

			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = { enable = true },
		})
	end,
}
