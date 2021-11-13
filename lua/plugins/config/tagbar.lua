
local M={}

function M.setup()
    local commands = {
        m = { ":TagbarToggle<CR>", "Tagbar" },
    }
    local opts = require "plugins.config.which-key" . opts('n')

    require("which-key") . register(commands, opts)
end

return M
