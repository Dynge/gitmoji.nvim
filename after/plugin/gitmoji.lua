local ok, cmp = pcall(require, "cmp")
if ok then
    local gitmoji = require("gitmoji")
    cmp.register_source(gitmoji.source_name(), gitmoji.get_source().new())
end
