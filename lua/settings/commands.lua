
local M = {}

function M.load()
    if line_wrap_cursor_movement then
        cmd "set whichwrap+=<,>,[,],h,l"
    end

    if transparent_window then
        cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
        cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
        cmd "au ColorScheme * hi NormalNC ctermbg=none guibg=none"
        cmd "au ColorScheme * hi MsgArea ctermbg=none guibg=none"
        cmd "au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none"
        cmd "au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none"
        cmd "let &fcs='eob: '"
    end
end

return M
