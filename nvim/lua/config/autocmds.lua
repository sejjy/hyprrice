-- highlight cursorline
local cursor_group = vim.api.nvim_create_augroup("CursorGroup", { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", {
	group = cursor_group,
	callback = function()
		vim.opt.cursorline = true
	end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
	group = cursor_group,
	callback = function()
		vim.opt.cursorline = false
	end,
})

-- save folds
local fold_group = vim.api.nvim_create_augroup("FoldGroup", { clear = true })

vim.api.nvim_create_autocmd("BufWinLeave", {
	group = fold_group,
	pattern = "*",
	callback = function()
		if vim.fn.expand("%") ~= "" then
			vim.cmd("mkview")
		end
	end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = fold_group,
	pattern = "*",
	callback = function()
		if vim.fn.expand("%") ~= "" then
			vim.cmd("silent! loadview")
		end
	end,
})

-- highlight text after yank
local yank_group = vim.api.nvim_create_augroup("YankGroup", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = yank_group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- lsp
local lsp_group = vim.api.nvim_create_augroup("LspGroup", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	callback = function(event)
		-- on attach...
		local bufnum = event.buf
		-- highlight references
		local hl_group = vim.api.nvim_create_augroup("HlGroup", { clear = false })

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = hl_group,
			buffer = bufnum,
			callback = function()
				local clients = vim.lsp.get_clients({ bufnr = bufnum })
				for _, client in ipairs(clients) do
					if client:supports_method("textDocument/documentHighlight") then
						vim.lsp.buf.document_highlight()
						return
					end
				end
			end,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = hl_group,
			buffer = bufnum,
			callback = vim.lsp.buf.clear_references,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			group = lsp_group,
			callback = function(detach_event)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = hl_group, buffer = detach_event.buf })
			end,
		})

		-- lsp keymaps
		local picker = require("snacks").picker
		local function gdesc(desc)
			return { desc = "LSP: goto " .. desc }
		end
		local function ldesc(desc)
			return { desc = "LSP: " .. desc }
		end

		-- goto
		vim.keymap.set("n", "grd", vim.lsp.buf.declaration, gdesc("[d]eclaration"))
		vim.keymap.set("n", "gd", picker.lsp_definitions, gdesc("[d]efinition"))
		vim.keymap.set("n", "grr", picker.lsp_references, gdesc("[r]eferences"))
		vim.keymap.set("n", "gri", picker.lsp_implementations, gdesc("[i]mplementation"))

		vim.keymap.set("n", "grn", vim.lsp.buf.rename, ldesc("re[n]ame"))
		vim.keymap.set("n", "grt", picker.lsp_type_definitions, ldesc("[t]ype definition"))
		vim.keymap.set("n", "<Leader>sd", picker.lsp_symbols, ldesc("[d]ocument symbols"))
		vim.keymap.set("n", "<Leader>sw", picker.lsp_workspace_symbols, ldesc("[w]orkspace symbols"))

		vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
		vim.keymap.set({ "n", "x" }, "gra", vim.lsp.buf.code_action, ldesc("code [a]ctions"))

		vim.keymap.set("n", "<Leader>th", function()
			local lsp_hint = { bufnr = bufnum }
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(lsp_hint), lsp_hint)
		end, ldesc("toggle inlay [h]ints"))
	end,
})

-- fix for https://github.com/folke/lazy.nvim/issues/1951
local lazy_group = vim.api.nvim_create_augroup("LazyGroup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = lazy_group,
	pattern = "lazy_backdrop",
	callback = function(ctx)
		local win = vim.fn.win_findbuf(ctx.buf)[1]
		vim.api.nvim_win_set_config(win, { border = "none" })
	end,
})
