
local M = {}

function M:add_defaults(field, value)
    self.defaults = field_value_to_table(self.defaults, field, value)
    return self.defaults
end

function M.load()
    local defaults = {
        leader = "space",
        scheme = "sonokai",
        statusline = "lualine",
        lualine_theme = "dark_one",
        keys = {},
        autocommands = {},
        lang = {},
    }
    return defaults
end

function M:init()
    self.defaults = self.load()
    return self.defaults
end

return M
