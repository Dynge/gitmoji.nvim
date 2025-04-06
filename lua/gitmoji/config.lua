---@toc_entry Configuration
---@tag gitmoji-configuration
---@text Configuration is a simple lua table with a few settings.
---
--- You can set a list of filetypes that you wish the gitmoji completions to
--- be active for, and you can set the completion type you wish (eg. emojis
--- or text). Finally it is possible to have the completion automatically add
--- a space after insertion in order to be ready for more text after gitmoji
--- insertion.
---
---@class GitmojiConfig
---
---@field filetypes string[] array of filetypes to add gitmoji completions for.
---@field completion (GitmojiCompletion) configurations for what to write after selection
---
---
---@text Default values:
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
local config = {
    filetypes = { "gitcommit" },
    completion = {
        append_space = false,
        complete_as = "emoji",
    },
}

---@tag gitmoji-completion-opts
---
---@text The completion table consists of two simple fields as can be seen below:
---
---@class GitmojiCompletion
---@field append_space boolean append space after completion?
---@field complete_as (gitmoji.complete_as) complete as emoji or text?
--- - see |gitmoji-complete-as|
--

---@tag gitmoji-complete-as
---
---@text Currently there are two different completion types provided:
---@alias gitmoji.complete_as
---| "emoji"  -- inserts emojis
---| "text"   -- insert text eg `:bug:`

return config
