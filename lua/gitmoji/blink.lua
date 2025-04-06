--- @module 'blink.cmp'
--- @class GitmojiBlinkSource : blink.cmp.Source
--- @field opts GitmojiConfig
local source = {}

--- @param opts GitmojiConfig
function source.new(opts)
    local self = setmetatable({}, { __index = source })
    local default_opts = require("gitmoji.config")

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

function source:get_completions(ctx, callback)
    if string.sub(ctx.line, -1, -1) ~= ":" then
        return callback({
            items = {},
            is_incomplete_backward = true,
            is_incomplete_forward = false,
        })
    end
    vim.notify(vim.inspect(ctx))

    ---@type lsp.CompletionItem[]
    self.items = {}
    local gitmoji_items = require("gitmoji.items")

    for _, item in ipairs(gitmoji_items) do
        item.textEdit = {
            newText = item[self.opts.completion.complete_as]
                .. (self.opts.completion.append_space and " " or ""),
            range = {
                start = {
                    line = ctx.bounds.line_number - 1,
                    character = ctx.bounds.start_col - 2,
                },
                ["end"] = {
                    line = ctx.bounds.line_number - 1,
                    character = ctx.bounds.start_col - 1,
                },
            },
        }
        table.insert(self.items, item)
    end

    callback({
        items = self.items,
        is_incomplete_backward = false,
        is_incomplete_forward = false,
    })
end

function source:execute(_, _, callback, default_implementation)
    default_implementation()
    callback()
end

return source
