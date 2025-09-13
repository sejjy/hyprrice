return {
	"folke/snacks.nvim",

	priority = 1000,

	opts = {
		picker = {
			prompt = " > ",
			formatters = { file = { filename_first = true } },

			icons = {
				undo = { saved = "" },
				ui = { selected = "", unselected = "" },
			},

			layout = {
				reverse = true,
				-- stylua: ignore
				layout = {
					box = "horizontal",
					backdrop = false,
					width = 0.8,
					height = 0.9,
					border = "none",
					{
						box = "vertical",
						{ win = "list", title = " Results ", title_pos = "center", border = "single" },
						{ win = "input", height = 1, border = "single", title = "{title} {live} {flags}", title_pos = "center" },
					},
					{ win = "preview", title = "{preview:Preview}", width = 0.45, border = "single", title_pos = "center" },
				},
			},

			sources = {
				buffers = { current = false },
				files = { hidden = true },
				grep_word = {
					search = function(prompt)
						return " " .. prompt:word()
					end,
				},
			},

			win = {
				input = {
					keys = {
						["<Esc>"] = { "close", mode = { "n", "i" } },
						["<C-u>"] = { "preview_scroll_up", mode = { "n", "i" } },
						["<C-d>"] = { "preview_scroll_down", mode = { "n", "i" } },
					},
				},
			},
		},
	},

	config = function(_, opts)
		require("snacks").setup(opts)
		local picker = require("snacks").picker

		local function sdesc(desc)
			return { desc = "search " .. desc }
		end

		vim.keymap.set("n", "<Leader><Leader>", picker.buffers, sdesc("open buffers"))
		vim.keymap.set("n", "<Leader>sb", picker.grep_buffers, { desc = "grep open [b]uffers" })
		vim.keymap.set("n", "<Leader>sf", picker.files, sdesc("[f]iles"))
		vim.keymap.set("n", "<Leader>sg", picker.grep, { desc = "[g]rep" })
		vim.keymap.set("n", "<Leader>sh", picker.help, sdesc("[h]elp pages"))
		vim.keymap.set("n", "<Leader>sk", picker.keymaps, sdesc("[k]eymaps"))
		vim.keymap.set("n", "<Leader>sm", picker.man, sdesc("[m]an pages"))
		vim.keymap.set("n", "<Leader>sr", picker.resume, { desc = "[r]esume search" })
		vim.keymap.set("n", "<Leader>su", picker.undo, sdesc("[u]ndo history"))
		vim.keymap.set("n", "<Leader>s.", picker.recent, sdesc("recent files"))

		vim.keymap.set({ "n", "x" }, "<Leader>sc", picker.grep_word, { desc = "grep [c]urrent word" })

		vim.keymap.set("n", "<Leader>sn", function()
			picker.files({ cwd = vim.fn.stdpath("config") })
		end, sdesc("[n]eovim files"))
	end,
}
