---@alias gitmoji.complete_type
---| "emoji"
---| "text"

---@class gitmoji.completion
---@field append_space boolean append space after completion?
---@field complete_as gitmoji.complete_type complete as emoji or text?

---@class gitmoji.config
---@field filetypes string[] array of filetypes to add gitmoji completions for.
---@field complete_as gitmoji.completion
return {
    filetypes = { "gitcommit" },
    completion = {
        append_space = false,
        complete_as = "emoji",
    },
}
