
local M = {}

local compile_path = get_config_dir() .. "/plugin/packer_compiled.lua"

function M:init(opts)
    opts = opts or {}

    local install_path = opts.install_path
    local package_root = opts.package_root

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
        cmd "packadd packer.nvim"
    end

    local packer_ok, packer = pcall(require, "packer")
    if not packer_ok then
        return
    end

    packer.init {
        package_root = package_root,
        compile_path = compile_path,
        git = { clone_timeout = 300 },
        display = {
            open_fn = function() return require("packer.util").float { border = "rounded" } end,
        },
    }

    self.packer = packer
    self.list   = require "plugins.plugins" . list()
    return self
end

function M:load()
	return self.packer.startup(function(use)
		for _, plugins in ipairs(self.list) do
			for _, plugin in ipairs(plugins) do
				use(plugin)
			end
		end
	end)
end

function M:config()
	for _, plugins in ipairs(self.list) do
		if plugins.setup then
			plugins.setup()
		end
	end
end

return M
