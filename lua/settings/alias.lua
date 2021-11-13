
local M = {}

function M.load()
    cmd                         = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
    g                           = vim.g      -- a table to access global variables
    fn                          = vim.fn    -- to call Vim functions e.g. fn.bufnr()
    opt                         = vim.opt  -- to set options
    map                         = vim.api.nvim_set_keymap
    loop                        = vim.loop
    line_wrap_cursor_movement   = vim.line_wrap_cursor_movement
    transparent_window          = vim.transparent_window
end

return M
