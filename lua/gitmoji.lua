local M = {}

local function contains_source(source, filetype)
	local ok, cmp = pcall(require, "cmp")
	if not ok then
		return
	end

	local ft_config = cmp.get_config(filetype)
	local contained = false
	for _, group in ipairs(ft_config.sources) do
		for key, value in pairs(group) do
			if key == "name" and value == source then
				contained = true
			end
		end
	end
	return contained
end

function M.setup(opts)
	local ok, cmp = pcall(require, "cmp")
	if not ok then
		return
	end

	if not contains_source("gitmoji") then
		require("gitmoji.sources").setup()
	end

	local merged_opts = require("gitmoji.defaults")

	for k, v in pairs(opts or {}) do
		merged_opts[k] = v
	end

	for _, ft in ipairs(merged_opts.filetypes) do
		if not contains_source("gitmoji", ft) then
			local ft_config = cmp.get_config(ft)
			table.insert(ft_config.sources, {
				name = "gitmoji",
			})
			cmp.setup.filetype(ft, ft_config)
		end
	end
end

M.setup() -- default opts

return M
