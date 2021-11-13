
local M = {}

local generic_opts_any = { noremap = true, silent = true }

local generic_opts = {
  insert_mode = generic_opts_any,
  normal_mode = generic_opts_any,
  visual_mode = generic_opts_any,
  visual_block_mode = generic_opts_any,
  command_mode = generic_opts_any,
  term_mode = { silent = true },
}

local mode_adapters = {
  function_mode = "f",
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
}

function M.append_to_defaults(keymaps)
  for mode, mappings in pairs(keymaps) do
    for k, v in ipairs(mappings) do
      nvim.keys[mode][k] = v
    end
  end
end

function M.set_keymaps(mode, key, val)
  local opt = generic_opts[mode] and generic_opts[mode] or generic_opts_any
  if type(val) == "table" then
    opt = val[2]
    val = val[1]
  end
  if mode ~= mode_adapters.function_mode then
    vim.api.nvim_set_keymap(mode, key, val, opt)
  else
    cmd(val)
  end
end

function M.load_mode(mode, keymaps)
  mode = mode_adapters[mode] and mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
      M.set_keymaps(mode, k, v)
  end
end

function M.load_keymaps(keymaps)
  for mode, mapping in pairs(keymaps) do
      M.load_mode(mode, mapping)
  end
end

function M:load()
  g.mapleader = (nvim.leader == "space" and " ") or nvim.leader

  local keymaps = require "keymaps.defaults" . load()
  nvim = require "settings.defaults" : add_defaults('keys', keymaps)

  self.load_keymaps(nvim.keys)
end

return M
