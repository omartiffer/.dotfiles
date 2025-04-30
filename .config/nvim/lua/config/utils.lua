local M = {}

-- null-ls method mapping
local null_ls_ok, null_ls = pcall(require, "null-ls")

function M.get_active_tools()
	local buf_ft = vim.bo.filetype

	local formatters, linters = {}, {}

	-- From null-ls
	if null_ls_ok then
		local sources = require("null-ls.sources").get_available(buf_ft)
		for _, source in ipairs(sources) do
			for method in pairs(source.methods) do
				if method == null_ls.methods.FORMATTING then
					table.insert(formatters, source.name .. " (null-ls)")
				elseif method == null_ls.methods.DIAGNOSTICS then
					table.insert(linters, source.name .. " (null-ls)")
				end
			end
		end
	end

	-- From LSP clients
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		if client.server_capabilities then
			if client.server_capabilities.documentFormattingProvider then
				table.insert(formatters, client.name .. " (LSP)")
			end
			if
				client.server_capabilities.documentDiagnosticProvider
				or client.supports_method("textDocument/publishDiagnostics")
			then
				table.insert(linters, client.name .. " (LSP)")
			end
		end
	end

	-- remove duplicates
	local function dedup(list)
		local seen, result = {}, {}
		for _, item in ipairs(list) do
			if not seen[item] then
				table.insert(result, item)
				seen[item] = true
			end
		end
		return result
	end

	return {
		formatters = dedup(formatters),
		linters = dedup(linters),
	}
end

function M.active_tools()
	local active = M.get_active_tools()

	local formatters = #active.formatters > 0 and "🧹 " .. table.concat(active.formatters, ", ") or "none"
	local linters = #active.linters > 0 and "🧪 " .. table.concat(active.linters, ", ") or "none"

	return string.format("Fmt: %s | Lint: %s", formatters, linters)
end

return M
