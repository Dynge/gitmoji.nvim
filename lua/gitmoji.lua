local Gitmoji = {}

local gitmoji_source = "gitmoji"

local gitmoji_config = require("gitmoji.config")

--- Setup
---
--- Setup function. This method simply merges default configs with opts table.
---
---@param opts gitmoji.config configurations for gitmoji.nvim
function Gitmoji.setup(opts)
    gitmoji_config = vim.tbl_deep_extend("force", gitmoji_config, opts)
end

function Gitmoji.get_source()
    local source = {}

    source.is_available = function()
        local ft = vim.bo.filetype
        return vim.tbl_contains(gitmoji_config.filetypes, ft)
    end

    source.new = function()
        local self = setmetatable({}, { __index = source })
        self.items = nil
        return self
    end

    source.get_trigger_characters = function()
        return { ":" }
    end

    source.get_keyword_pattern = function()
        return [[\%(\s\|^\)\zs:\w*:\?]]
    end

    source.complete = function(self, request, callback)
        -- Avoid unexpected completion.
        if not vim.regex(self.get_keyword_pattern() .. "$"):match_str(request.context.cursor_before_line) then
            return callback()
        end

        if not self.items then
            ---@type lsp.CompletionItem[]
            self.items = {}
            local gitmoji_items = require("gitmoji.items")
            for _, item in ipairs(gitmoji_items) do
                item.insertText = item[gitmoji_config.completion.complete_as]
                    .. (gitmoji_config.completion.append_space and " " or "")
                table.insert(self.items, item)
            end
        end

        callback(self.items)
    end

    return source
end

--- Small helper function to get the name of the gitmoji source.
---
---@return string source name of the gitmoji source
function Gitmoji.source_name()
    return gitmoji_source
end

return Gitmoji
