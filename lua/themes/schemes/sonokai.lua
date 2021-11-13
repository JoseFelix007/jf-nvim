
local M = {}

function M.load()
    g.sonokai_style                     = 'andromeda'
    g.sonokai_enable_italic             = 1
    g.sonokai_disable_italic_comment    = 1
    cmd "colorscheme sonokai"
end

return M
