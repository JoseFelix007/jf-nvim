
local M={}

function M.setup()
    local commands = {
        n = { ":SymbolsOutline<CR>", "Symbols" },
    }
    local opts = require "plugins.config.which-key" . opts('n')

    require("which-key") . register(commands, opts)
end

return M
