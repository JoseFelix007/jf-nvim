
local config = require('nvim_comment')

local M = {}

function M.setup()

    local setup = {
        -- Linters prefer comment and line to have a space in between markers
        marker_padding = true,
        -- Should comment out empty or whitespace only lines
        comment_empty = false,
        -- Should key mappings be created
        create_mappings = true,
        -- Normal mode mapping left hand side
        line_mapping = "<Space>cc",
        -- Visual/Operator mapping left hand side
        operator_mapping = "<Space>c",
        -- Hook function to call before commenting takes place
        hook = function()
            if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
                -- require("ts_context_commentstring.internal").update_commentstring()
            end
        end
    }

    config.setup(setup)

    local n_commands = {
        c = { name = "Comment" }
    }

    local nopts = require "plugins.config.which-key" . opts('n')

    require("which-key") . register(n_commands, nopts)
end

return M
