local minidoc = require("mini.doc")

local files = {
    "./lua/gitmoji.lua",
    "./lua/gitmoji/config.lua",
}

local hooks = vim.deepcopy(minidoc.default_hooks)

hooks.write_pre = function(lines)
    -- Remove first two lines with `======` and `------` delimiters to comply
    -- with `:h local-additions` template
    table.remove(lines, 1)
    table.remove(lines, 1)
    return lines
end

minidoc.generate(files, "./doc/gitmoji.txt", { hooks = hooks })
