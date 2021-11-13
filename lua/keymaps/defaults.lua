
local M = {}

function M.load()
    local defaults = {
        function_mode = {
            ['OpenTerminal'] = [[
                au BufEnter * if &buftype == 'terminal' | :startinsert | endif
                function! OpenTerminal()
                    split term://zsh
                    resize 10
                endfunction
            ]]
        },

        --@usage change or add keymappings for insert mode
        insert_mode = {
            -- 'jk' for quitting insert mode
            ["jk"] = "<ESC>",
            -- 'kj' for quitting insert mode
            ["kj"] = "<ESC>",
            -- 'jj' for quitting insert mode
            ["jj"] = "<ESC>",
            -- Move current line / block with Alt-j/k ala vscode.
            ["<C-j>"] = "<Esc>:m .+1<CR>==gi",
            -- Move current line / block with Alt-j/k ala vscode.
            ["<C-k>"] = "<Esc>:m .-2<CR>==gi",
            -- navigation
            ["<A-Up>"] = "<C-\\><C-N><C-w>k",
            ["<A-Down>"] = "<C-\\><C-N><C-w>j",
            ["<A-Left>"] = "<C-\\><C-N><C-w>h",
            ["<A-Right>"] = "<C-\\><C-N><C-w>l",
            -- navigate tab completion with <c-j> and <c-k>
            -- runs conditionally
            ["<A-j>"] = { 'pumvisible() ? "\\<down>" : "\\<C-j>"', { expr = true, noremap = true } },
            ["<A-k>"] = { 'pumvisible() ? "\\<up>" : "\\<C-k>"', { expr = true, noremap = true } },
        },

        ---@usage change or add keymappings for normal mode
        normal_mode = {
            ["<C-q>"] = ":q<CR>",
            ["<A-q>"] = ":q!<CR>",
            ["<C-s>"] = ":w<CR>",

            -- Better window movement
            ["<A-h>"] = "<C-w>h",
            ["<A-j>"] = "<C-w>j",
            ["<A-k>"] = "<C-w>k",
            ["<A-l>"] = "<C-w>l",

            -- Resize with arrows
            ["<C-Up>"] = ":resize -2<CR>",
            ["<C-Down>"] = ":resize +2<CR>",
            ["<C-Left>"] = ":vertical resize -2<CR>",
            ["<C-Right>"] = ":vertical resize +2<CR>",

            -- Tab switch buffer
            ["<C-n>n"] = ":enew<CR>",
            ["<C-n>h"] = ":new<CR>",
            ["<C-n>v"] = ":vnew<CR>",
            ["<TAB>"] = ":bnext<CR>",
            ["<S-TAB>"] = ":bprevious<CR>",
            ["<C-w>"] = ":bd<CR>",
            ["<A-w>"] = ":bd!<CR>",

            -- Tab switch tab
            ["<C-S-n>"] = ":tabnew<CR>",
            ["<"] = ":tabnext<CR>",
            [">"] = ":tabprevious<CR>",

            -- Move current line / block with Alt-j/k
            ["<C-j>"] = ":m .+1<CR>==",
            ["<C-k>"] = ":m .-2<CR>==",

            ["<C-t>"] = ":call OpenTerminal()<CR>",
        },

        ---@usage change or add keymappings for terminal mode
        term_mode = {
            -- Terminal window navigation
            ["<A-h>"] = "<C-\\><C-N><C-w>h",
            ["<A-j>"] = "<C-\\><C-N><C-w>j",
            ["<A-k>"] = "<C-\\><C-N><C-w>k",
            ["<A-l>"] = "<C-\\><C-N><C-w>l",
            ["<Esc>"] = "<C-\\><C-N>",
        },

        ---@usage change or add keymappings for visual mode
        visual_mode = {
            -- Better indenting
            ["<TAB>"] = ">gv",
            ["<S-TAB>"] = "<gv",
        },

        ---@usage change or add keymappings for visual block mode
        visual_block_mode = {
            -- Move selected line / block of text in visual mode
            ["K"] = ":move '<-2<CR>gv-gv",
            ["J"] = ":move '>+1<CR>gv-gv",

            -- Move current line / block with Alt-j/k
            ["<C-j>"] = ":m '>+1<CR>gv-gv",
            ["<C-k>"] = ":m '<-2<CR>gv-gv",
        },

        ---@usage change or add keymappings for command mode
        command_mode = {
            -- navigate tab completion with <c-j> and <c-k>
            -- runs conditionally
            ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
            ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
        },
    }
    return defaults
end

return M
