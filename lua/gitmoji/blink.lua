--- @module 'blink.cmp'
--- @class GitmojiBlinkSource : blink.cmp.Source
--- @field opts GitmojiConfig
local source = {}

--- @param opts GitmojiConfig
function source.new(opts)
    local self = setmetatable({}, { __index = source })
    local default_opts = require("GitmojiConfig")

    self.opts = vim.tbl_extend("force", default_opts, opts)
    self:_validate_config()
    return self
end

    function source:_validate_config()
        vim.validate({
            filetypes = { self.opts.filetypes, "table" },
            ["completion.append_space"] = { self.opts.completion.append_space, "boolean" },
            ["completion.complete_as"] = { self.opts.completion.complete_as, "string" },
        })
    end

    function source:is_available()
        if not self.opts or vim.tbl_isempty(self.opts.filetypes) then
            return true
        end

        local ft = vim.bo.filetype
        return vim.tbl_contains(self.opts.filetypes, ft)
    end

    function source:get_trigger_characters()
        return { ":" }
    end

    function source:get_keyword_pattern()
        return [[\%(\s\|^\)\zs:\w*:\?]]
    end

    function source:complete(_, callback)
        if not self:is_available() then
            return callback()
        end

        if not self.items then
            ---@type lsp.CompletionItem[]
            self.items = {}
            local gitmoji_items = require("gitmoji.items")
            for _, item in ipairs(gitmoji_items) do
                item.insertText = item[self.opts.completion.complete_as]
                    .. (self.opts.completion.append_space and " " or "")
                table.insert(self.items, item)
            end
        end

        callback(self.items)
    end

    return source
