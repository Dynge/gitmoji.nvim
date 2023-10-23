local M = {}

function M.contains_source(source, filetype)
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

return M
