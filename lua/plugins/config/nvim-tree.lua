
local M = {}

function M.setup()

    local setup = {
        disable_netrw       = true, -- disables netrw completely
        hijack_netrw        = true, -- hijack netrw window on startup
        open_on_setup       = false, -- open the tree when running this setup function
        ignore_ft_on_setup  = {}, -- will not open on setup if the filetype is in this list
        auto_close          = true, -- closes neovim automatically when the tree is the last **WINDOW** in the view
        open_on_tab         = false, -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
        update_to_buf_dir   = { -- hijacks new directory buffers when they are opened.
            enable = true, -- enable the feature
            auto_open = true, -- allow to open the tree if it was previously closed
        },
        hijack_cursor       = false, -- hijack the cursor in the tree to put it at the start of the filename
        update_cwd          = false, -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
        diagnostics = { -- show lsp diagnostics in the signcolumn
            enable = true,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            }
        },
        update_focused_file = { -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
            enable      = true, -- enables the feature
            -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
            -- only relevant when `update_focused_file.enable` is true
            update_cwd  = false,
            -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
            -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
            ignore_list = {}
        },
        system_open = { -- configuration options for the system open command (`s` in the tree by default)
            cmd  = nil, -- the command to run this, leaving nil should work in most cases
            args = {} -- the command arguments as a list
        },
        view = {
            -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
            width = 30,
            -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
            height = 30,
            -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
            side = 'left',
            -- if true the tree will resize itself after opening a file
            auto_resize = false,
            mappings = {
                -- custom only false will merge the list with the default mappings
                -- if true, it will only use your list to set the mappings
                custom_only = false,
                -- list of mappings to set on the tree manually
                list = {}
            }
        }
    }

    require'nvim-tree'.setup(setup)

    local g_opts = {
        show_icons = {
            git = 1,
            folders = 1,
            files = 1,
            folder_arrows = 1,
            tree_width = 30,
        },
        ignore = { ".git", "node_modules", ".cache" },
        quit_on_open = 0,
        hide_dotfiles = 1,
        git_hl = 1,
        root_folder_modifier = ":t",
        allow_resize = 1,
        auto_ignore_ft = { "startify", "dashboard" },
        icons = {
            default = "",
            symlink = "",
            git = {
                unstaged = "",
                staged = "S",
                unmerged = "",
                renamed = "➜",
                deleted = "",
                untracked = "U",
                ignored = "◌",
            },
            folder = {
                arrow_open = "כּ",
                arrow_closed = "ךּ",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
            },
        }
    }

    for opt, val in pairs(g_opts) do
        g["nvim_tree_" .. opt] = val
    end

    local commands = {
        e = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    }
    local opts = require "plugins.config.which-key" . opts('n')

    require("which-key") . register(commands, opts)
end

return M
