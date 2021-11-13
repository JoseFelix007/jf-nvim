
local M = {}

--
-- =========================== LUALINE ===========================
--         +-------------------------------------------------+
--         | A | B | C                             X | Y | Z |
--         +-------------------------------------------------+
-- ===============================================================
--

local function mode()
    return [[]]
end

local conditions = {
    buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
    hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end
}

local gitdiff = {
    'diff',
    colored = true,
    symbols = {
        added     = '  ',
        modified  = '  ',
        removed   = '  '
    },
    diff_color = {
        added     = { fg = '#00aea0' },
        modified  = { fg = '#fcca00' },
        removed   = { fg = '#ee0000' },
    },
    source = nil,
    cond = conditions.hide_in_width
}

local filename = {
    'filename',
    file_status = true,
    path = 1,
    shorting_target = 40
}

local sections = {
    lualine_a = {
        { mode, cond = conditions.hide_in_width }
    },
    lualine_b = {
        { 'branch', cond = conditions.hide_in_width }
    },
    lualine_c = { 
        'filename',
        gitdiff,
        { 'diagnostics', sources = { 'nvim_lsp', 'coc' } }
    },
}

local tabline = {
    lualine_a = { 'buffers' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = { filename },
    lualine_z = { 'tabs' }
}

function M.load(lualine_theme)
    require "lualine" . setup {
        options   = { theme = require("themes.statusline.lualine.themes." .. lualine_theme) },
        sections  = sections,
        tabline   = tabline
    }
end

return M

