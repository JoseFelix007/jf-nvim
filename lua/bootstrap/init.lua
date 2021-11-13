
local M = {}

---Join path segments that were passed as input
---@return string
function _G.join_paths(...)
    local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"
    local result = table.concat({ ... }, path_sep)
    return result
end

---Get the full path to `$LUNARVIM_RUNTIME_DIR`
---@return string
function _G.get_runtime_dir()
    local runtime_dir = os.getenv "NVIM_RUNTIME_DIR"
    if not runtime_dir then
        -- when nvim is used directly
        return vim.fn.stdpath "config"
    end
    return runtime_dir
end

---Get the full path to `$NVIM_DIR`
---@return string
function _G.get_config_dir()
    local config_dir = os.getenv "NVIM_CONFIG_DIR"
    if not config_dir then
        return vim.fn.stdpath "config"
    end
    return config_dir
end

---Get the full path to `$NVIM_RUNTIME_DIR/cache`
---@return string
function _G.get_cache_dir()
    local cache_dir = os.getenv "NVIM_RUNTIME_DIR"
    if not cache_dir then
        return vim.fn.stdpath "cache"
    end
    return join_paths(cache_dir, "cache")
end

---Get the full path to the currently installed neovim repo
---@return string
local function get_install_path()
    local nvim_runtime_dir = os.getenv "NVIM_RUNTIME_DIR"
    if not nvim_runtime_dir then
      -- when nvim is used directly
      return vim.fn.stdpath "config"
    end
    return join_paths(nvim_runtime_dir, "nvim")
  end

function M:init()
    require "utils"

    self.runtime_dir    = get_runtime_dir()
    self.config_dir     = get_config_dir()
    self.cache_path     = get_cache_dir()
    self.install_path   = get_install_path()

    self.pack_dir           = vim.fn.stdpath "data" .. "/site/pack"
    self.packer_install_dir = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

    require "settings"  : init {
        path = join_paths(self.config_dir, "config.lua"),
    }

    require "bootstrap.gvim"

    require "plugins"   : init {
        package_root = self.pack_dir,
        install_path = self.packer_install_dir,
    }

    require "plugins" : config ()

    return self
end

return M
