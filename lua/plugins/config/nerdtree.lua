
local M = {}

function M.setup()
    g.NERDTreeShowHidden = 1
    g.NERDTreeMinimalUI = 1
    g.NERDTreeIgnore = {}
    g.NERDTreeStatusline = ''

    g.webdevicons_enable_nerdtree = 1
    g.NERDTreeDirArrowExpandable = '▸'
    g.NERDTreeDirArrowCollapsible = '▾'

    cmd [[
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

        function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
            exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
            exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
        endfunction

        call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
        call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
        call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
        call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
        call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
        call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
        call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
        call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
        call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
        call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
        call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
        call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
        call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
    ]]

    -- { 'preservim/nerdtree',
    --         setup = function()
    --             require "plugins.config.nerdtree" . setup()
    --         end,
    -- },

--     local commands = {
--         e = {":NERDTreeToggle<CR>", "Explorer"},
--     }
--     local opts = require "plugins.config.which-key" . opts('n')

--     require("which-key") . register(commands, opts)
end

return M
