local M = {}

local gitmoji_source = "gitmoji"

function M.setup(opts)
	local ok, cmp = pcall(require, "cmp")
	if not ok then
		return
	end
	local utils = require("gitmoji.utils")

	require("gitmoji.sources").setup()

	local merged_opts = require("gitmoji.config")

	for k, v in pairs(opts or {}) do
		merged_opts[k] = v
	end

	for _, ft in ipairs(merged_opts.filetypes) do
		if not utils.contains_source(gitmoji_source, ft) then
			local ft_config = cmp.get_config(ft)
			table.insert(ft_config.sources, {
				name = gitmoji_source,
			})
			cmp.setup.filetype(ft, ft_config)
		end
	end
end

function M.source_name()
	return gitmoji_source
end

return M
