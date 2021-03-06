
local if_nil = vim.F.if_nil

local default_header = {
    type = "text",
    val = {
        [[======================================================]],
        [[                                                      ]],
        [[                    ▄▄██████████▄▄                    ]],
        [[                    ▀▀▀   ██   ▀▀▀                    ]],
        [[            ▄██▄   ▄▄████████████▄▄   ▄██▄            ]],
        [[          ▄███▀  ▄████▀▀▀    ▀▀▀████▄  ▀███▄          ]],
        [[         ████▄ ▄███▀              ▀███▄ ▄████         ]],
        [[        ███▀█████▀▄████▄      ▄████▄▀█████▀███        ]],
        [[        ██▀  ███▀ ██████      ██████ ▀███  ▀██        ]],
        [[         ▀  ▄██▀  ▀████▀  ▄▄  ▀████▀  ▀██▄  ▀         ]],
        [[            ███           ▀▀           ███            ]],
        [[            ██████████████████████████████            ]],
        [[        ▄█  ▀██  ███   ██    ██   ███  ██▀  █▄        ]],
        [[        ███  ███ ███   ██    ██   ███▄███  ███        ]],
        [[        ▀██▄████████   ██    ██   ████████▄██▀        ]],
        [[         ▀███▀ ▀████   ██    ██   ████▀ ▀███▀         ]],
        [[          ▀███▄  ▀███████    ███████▀  ▄███▀          ]],
        [[            ▀███    ▀▀██████████▀▀▀   ███▀            ]],
        [[              ▀    ▄▄▄    ██    ▄▄▄    ▀              ]],
        [[                    ▀████████████▀                    ]],
        [[                                                      ]],
        [[======================================================]],
    },
    opts = {
        position = "center",
        hl = "Type"
        -- wrap = "overflow";
    }
}

local footer = {
    type = "text",
    val = '===================== JoseFelix007 =====================',
    opts = {
        position = "center",
        hl = "Number",
    }
}

--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    -- if keybind then
    --     keybind_opts = if_nil(keybind_opts, {noremap = true, silent = true, nowait = true})
    --     opts.keymap = {"n", sc_, keybind, keybind_opts}
    -- end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
        vim.api.nvim_feedkeys(key, "normal", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local buttons = {
    type = "group",
    val = {
        button("<leader> d n", " Nuevo archivo ..."       ),
        button("<leader> d f", " Buscar archivo ..."      ),
        button("<leader> d h", " Recientes ... "          ),
        button("<leader> d a", " Buscar palabras ..."     ),
        button("<leader> d b", " Marcadores ..."          ),
        button("<leader> d l", " Ultima sesion ..."       ),
        button("<leader> d e", " Configuracion nvim ..."  ),
    },
    opts = {
        spacing = 1
    }
}

local section = {
    header = default_header,
    buttons = buttons,
    footer = footer,
}

local opts = {
    layout = {
        {type = "padding", val = 2},
        section.header,
        {type = "padding", val = 2},
        section.buttons,
        section.footer,
    },
    opts = {
        margin = 5
    },
}

local dashboard = {
    d = {
        name = "Dashboard",
        s = {"<C-u>SessionSave<CR>", "Save session"},
        l = {"<C-u>SessionLoad<CR>", "Load session"},
        h = {":Telescope oldfiles<CR>", "History"},
        f = {":Telescope find_files<CR>", "Find files"},
        a = {":Telescope live_grep<CR>", "Find words"},
        b = {":Telescope marks<CR>", "Marks"},
        n = {":ene<CR>", "New file"},
        e = {":e /home/jjfelix/.config/nvim/init.lua<CR>", "Configuration"},
        d = {":Alpha<CR>", "Load dashboard"},
    }
}
local dashboard_opts = require "plugins.config.which-key" . opts('n')
require("which-key") . register(dashboard, dashboard_opts)

return {
    button = button,
    section = section,
    opts = opts,
}
