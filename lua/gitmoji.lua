local M = {}

function M.setup(opts)
	local ok, cmp = pcall(require, "cmp")
	if not ok then
		return
	end

	require("gitmoji.sources").setup()

	local merged_opts = require("gitmoji.defaults")

	for k, v in pairs(opts or {}) do
		merged_opts[k] = v
	end

	for ft in merged_opts.filetypes do
		cmp.setup.filetype(ft, {
			sources = { {
				name = "gitmoji",
			} },
		})
	end
end

M.setup() -- default opts

return M
