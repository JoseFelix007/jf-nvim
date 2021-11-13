
local M = {}

function M:init(opts)
    opts = opts or {}
    self.path = opts.path

    if vim.tbl_isempty(nvim or {}) then
        nvim = require "settings.defaults" : init()
    end

    require "settings.alias"     .   load()
    require "settings.options"   .   load()
    require "settings.commands"  .   load()
end

return M
