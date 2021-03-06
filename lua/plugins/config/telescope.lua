
local M = {}

function M.setup()

    local status_ok, actions = pcall(require, "telescope.actions")
    if not status_ok then
        return
    end

    require('telescope').setup({
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "descending",
            layout_strategy = "horizontal",
            layout_config = {
                width = 0.75,
                preview_cutoff = 120,
                horizontal = { mirror = false },
                vertical = { mirror = false },
            },
            file_sorter = require("telescope.sorters").get_fzy_sorter,
            file_ignore_patterns = {},
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            path_display = { shorten = 5 },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            use_less = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

            -- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            mappings = {
                i = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
                ["<C-j>"] = actions.cycle_history_next,
                ["<C-k>"] = actions.cycle_history_prev,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<CR>"] = actions.select_default + actions.center,
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-t>"] = trouble.open_with_trouble,
                -- ["<c-x>"] = false,
                -- ["<esc>"] = actions.close,
                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.select_horizontal,
                -- Add up multiple actions
                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
                },
                n = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- ["<c-t>"] = trouble.open_with_trouble,
                -- ["<C-i>"] = my_cool_custom_action,
                },
            },
            
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '--ignore-file',
                '.gitignore'
            },
        },
        pickers = {
            -- ...
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },
        },
    })

    local commands = {
        f = {
            name = 'Files',
            f = {":lua require('telescope.builtin').find_files()<cr>", "Find"},
            g = {":lua require('telescope.builtin').live_grep()<cr>", "Grep"},
            b = {":lua require('telescope.builtin').buffers()<cr>", "Buffers"},
            h = {":lua require('telescope.builtin').help_tags()<cr>", "Tags"},
        },
    }
    local opts = require "plugins.config.which-key" . opts('n')

    require("which-key") . register(commands, opts)
end

return M
