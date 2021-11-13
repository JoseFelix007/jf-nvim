
local M = {}

function M.load_scheme(scheme)
    require ("themes.schemes." .. scheme) . load()
end

function M.load_statusline(statusline, lualine_theme)
    require ("themes.statusline." .. statusline) . load(lualine_theme)
end

function M:load()
    self . load_scheme("sonokai")
    self . load_statusline("lualine", "dark_one")
end

return M
