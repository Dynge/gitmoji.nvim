--- *gitmoji.nvim*
---
--- ==============================================================================
---
--- Gitmoji is a plugin to help you use gitmojis in your commits.
---
--- The default setting enables gitmoji for `gitcommit` filetypes.
--- Then, with the help of nvim-cmp, you can type `:` - and get a list of
--- completions for all gitmojis emojis.
---

--- Table of Contents
---@tag gitmoji-table-of-contents
---@toc

local M = {}

local gitmoji_source = "gitmoji"

local gitmoji_config = require("gitmoji.config")

---@toc_entry Setup
---@tag gitmoji-setup
---
---@text Setup function. This method simply merges default configs with opts table.
--- You can read more about the possible settings at |gitmoji-configuration|.
---
---@param opts GitmojiConfig configurations for gitmoji.nvim
---
---@usage require("gitmoji").setup({}) -- replace `{}` with your config table
function M.setup(opts)
    gitmoji_config = vim.tbl_deep_extend("force", gitmoji_config, opts)

    -- User commands
    vim.api.nvim_create_user_command("Gitmoji", function()
        vim.cmd.startinsert()
        vim.api.nvim_input(":")
        require("cmp").complete({
            config = {
                sources = {
                    {
                        name = "gitmoji",
                        option = {
                            filetypes = {},
                        },
                    },
                },
            },
        })
    end, {})
end

function M.get_source()
    local source = {}

    source.new = function()
        local self = setmetatable({}, { __index = source })
        self.items = nil
        return self
    end

    ---@return GitmojiConfig
    source._validate_config = function(_, params)
        local opts = vim.tbl_deep_extend("force", gitmoji_config, params.option or {})
        vim.validate({
            filetypes = { opts.filetypes, "table" },
            ["completion.append_space"] = { opts.completion.append_space, "boolean" },
            ["completion.complete_as"] = { opts.completion.complete_as, "string" },
        })
        return opts
    end

    source.is_available = function(_, opts)
        if not opts or vim.tbl_isempty(opts.filetypes) then
            return true
        end

        local ft = vim.bo.filetype
        return vim.tbl_contains(opts.filetypes, ft)
    end

    source.get_trigger_characters = function()
        return { ":" }
    end

    source.get_keyword_pattern = function()
        return [[\%(\s\|^\)\zs:\w*:\?]]
    end

    source.complete = function(self, params, callback)
        local opts = self:_validate_config(params)

        if not self:is_available(opts) then
            return callback()
        end

        if not self.items then
            ---@type lsp.CompletionItem[]
            self.items = {}
            local gitmoji_items = require("gitmoji.items")
            for _, item in ipairs(gitmoji_items) do
                item.insertText = item[opts.completion.complete_as]
                    .. (opts.completion.append_space and " " or "")
                table.insert(self.items, item)
            end
        end

        callback(self.items)
    end

    return source
end

---
---@tag gitmoji-source
---@text Small helper function to get the name of the gitmoji source.
---
---@return string source name of the gitmoji source
---
---@usage require("gitmoji").source_name()
function M.source_name()
    return gitmoji_source
end

return M
