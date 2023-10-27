--- Configuration
---
--- Configuration of gitmoji consists of a few fields as seen below:
---
---@class gitmoji.config
---@field filetypes string[] array of filetypes to add gitmoji completions for.
---@field completion gitmoji.completion configurations for what to write after selection
local config = {
    filetypes = { "gitcommit" },
    completion = {
        append_space = false,
        complete_as = "emoji",
    },
}

--- Completion table
---
--- The completion table consists of two simple fields as can be seen below:
---
---@class gitmoji.completion
---@field append_space boolean append space after completion?
---@field complete_as gitmoji.complete_type complete as emoji or text?
--

--- Completion type
---
--- Currently there are two different completion types provided.
---
---@alias gitmoji.complete_type
---| "emoji"
---| "text"

return config
