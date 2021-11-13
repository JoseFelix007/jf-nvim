
local colors = {
    color0  = '#d9dcf3',
    color1  = '#252733',
    color2  = '#000048',
    color3  = '#003600',
    color4  = '#333600',
    color5  = '#330000',
    color6  = '#330048',
    color7  = '#001827',
    color8  = '#003648',
    color9  = '#333648',
}

return {
    normal = {
        a = { bg = colors.color2 , fg = colors.color0, gui = 'bold' },
        b = { bg = colors.color8 , fg = colors.color0 },
        c = { bg = colors.color1 , fg = colors.color0 }
    },
    insert = {
        a = { bg = colors.color3 , fg = colors.color0, gui = 'bold' },
        b = { bg = colors.color8 , fg = colors.color0 },
        c = { bg = colors.color1 , fg = colors.color0 }
    },
    visual = {
        a = { bg = colors.color4 , fg = colors.color0, gui = 'bold' },
        b = { bg = colors.color8 , fg = colors.color0 },
        c = { bg = colors.color1 , fg = colors.color0 }
    },
    replace = {
        a = { bg = colors.color5 , fg = colors.color0, gui = 'bold' },
        b = { bg = colors.color8 , fg = colors.color0 },
        c = { bg = colors.color1 , fg = colors.color0 }
    },
    command = {
        a = { bg = colors.color6 , fg = colors.color0, gui = 'bold' },
        b = { bg = colors.color8 , fg = colors.color0 },
        c = { bg = colors.color9 , fg = colors.color1 }
    },
    inactive = {
        a = { bg = colors.color7 , fg = colors.color0, gui = 'bold' },
        b = { bg = colors.color9 , fg = colors.color0 },
        c = { bg = colors.color1 , fg = colors.color0 }
    }
}
