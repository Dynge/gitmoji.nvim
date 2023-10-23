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

	for _, ft in ipairs(merged_opts.filetypes) do
		local ft_config = cmp.get_config(ft)
		local missing = true
		for _, group in ipairs(ft_config.sources) do
			for key, value in pairs(group) do
				if key == "name" and value == "gitmoji" then
					missing = false
				end
			end
		end
		if missing then
			table.insert(ft_config.sources, {
				name = "gitmoji",
			})
			cmp.setup.filetype(ft, ft_config)
		end
	end
end

M.setup() -- default opts

return M
