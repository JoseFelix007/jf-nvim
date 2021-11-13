
local M = {}

function M.list()
    local list = {
        { 'wbthomason/packer.nvim' }, -- Packer Plugin
        { 'folke/which-key.nvim',
            setup = function()
                require "plugins.config.which-key" . setup()
            end,
        }, -- KeyMapping
        { 'sainnhe/sonokai' }, -- ColorScheme
        { 'kyazdani42/nvim-web-devicons' }, -- DevIcons
        { 'shadmansaleh/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        }, -- LuaLine
        { 'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            setup = function()
                require "plugins.config.nvim-tree" . setup()
            end,
        }, --Explorer
        { 'terrortylor/nvim-comment',
            setup = function()
                require "plugins.config.nvim-comment" . setup()
            end,
        }, --Commentary
        { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope.nvim',
            requires = { {'nvim-lua/plenary.nvim'} },
            setup = function()
                require "plugins.config.telescope" . setup()
            end,
        }, --Files
        { 'voldikss/vim-floaterm',
            setup = function()
                require "plugins.config.vim-floaterm" . setup()
            end,
        },
        { 'goolord/alpha-nvim',
            setup = function ()
                require'alpha'.setup(require'plugins.config.alpha-nvim'.opts)
            end
        },

        { 'neovim/nvim-lspconfig' }, 
        { 'nvim-lua/completion-nvim' },
        { 'onsails/lspkind-nvim' },
        { 'glepnir/lspsaga.nvim' },
        { 'ray-x/lsp_signature.nvim' },
        { 'williamboman/nvim-lsp-installer',
            setup = function()
                require "plugins.config.lspconfig" . setup()
            end,
        },

        { 'SirVer/ultisnips' },
        { 'honza/vim-snippets' },
        { 'hrsh7th/nvim-compe',
            setup = function()
                require "plugins.config.nvim-compe" . setup()
            end,
        },

        { 'preservim/tagbar',
            setup = function()
                require "plugins.config.tagbar" . setup()
            end,
        },
        { 'simrat39/symbols-outline.nvim',
            setup = function()
                require "plugins.config.symbols-outline" . setup()
            end,
        },

        { 'jiangmiao/auto-pairs' },
        { 'alvan/vim-closetag',
            setup = function()
                require "plugins.config.closetag" . setup()
            end,
        },
        { 'tpope/vim-surround' },
        { {'rrethy/vim-hexokinase', run = 'make hexokinase'} },
        { 'airblade/vim-rooter' }
    }

    return list
end

return M
