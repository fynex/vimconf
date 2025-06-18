-- ============================================================================
-- BASIC SETUP
-- ============================================================================

-- Create necessary directories
vim.fn.system('mkdir -p ' .. vim.fn.expand('~/.config/nvim/{swap,undo}'))

-- Leader key (must be set before plugins)
-- vim.g.mapleader = ','
vim.g.mapleader = ' '

-- ============================================================================
-- CORE OPTIONS
-- ============================================================================

local opt = vim.opt

-- UI Settings
opt.cursorline = true                    -- Highlight cursor line
opt.number = true                        -- Line numbers
opt.numberwidth = 5                      -- Width of line numbers
opt.scrolloff = 3                        -- Lines above/below cursor
opt.showcmd = true                       -- Show commands being typed
opt.title = true                         -- Set window title
opt.wildmenu = true                      -- Better command completion
opt.wildmode = 'longest,list'            -- Bash-like completion
opt.wildignore = {                       -- Ignore these files
  '*.a', '*.o', '*.so', '*.pyc', '*.jpg', '*.jpeg', '*.png', '*.gif',
  '*.pdf', '*.git', '*.swp', '*.swo'
}

-- Disable bells and visual flash
opt.visualbell = true
opt.errorbells = false

-- General Settings
opt.hidden = true                        -- Allow buffer switching without saving
opt.history = 1000                       -- Command history
opt.laststatus = 2                       -- Always show statusline
opt.linebreak = true                     -- Don't break words when wrapping
opt.listchars = { tab = '>\\ ' }         -- Show tabs as >
opt.list = true                          -- Show listchars
opt.mouse = ''                           -- Disable mouse
opt.showmode = false                     -- Don't show mode (airline does this)
opt.startofline = false                  -- Keep cursor column when moving
opt.wrap = false                         -- Don't wrap lines
opt.shortmess:append('I')                -- Don't show intro message
opt.splitbelow = true                    -- Split below current window
opt.splitright = true                    -- Split right of current window

-- Folding
opt.foldcolumn = '0'                     -- Hide fold column
opt.foldlevel = 99                       -- Start with folds open
opt.foldmethod = 'indent'                -- Fold by indentation
opt.foldnestmax = 10                     -- Max 10 nested folds
-- opt.foldlevelstart = 99                 
-- Search
opt.gdefault = true                      -- Default to global search/replace
opt.incsearch = true                     -- Incremental search
opt.ignorecase = true                    -- Ignore case by default
opt.smartcase = true                     -- Case sensitive with uppercase

-- Matching
opt.matchtime = 2                        -- Time to show matching brackets
opt.matchpairs:append('<:>')             -- Match < and > as well
opt.showmatch = true                     -- Show matching brackets

-- Files
opt.autochdir = true                     -- Change to file's directory
opt.autoread = true                      -- Reload files changed outside vim
opt.confirm = true                       -- Confirm before closing unsaved files
opt.autowrite = false                    -- Don't auto-write files
opt.backup = false                       -- Don't create backup files

-- Persistent undo
opt.undodir = vim.fn.expand('~/.config/nvim/undo/')
opt.undofile = true
opt.undolevels = 500
opt.undoreload = 10000

-- Swap files (only if not using sudo)
if vim.fn.strlen(vim.env.SUDO_USER or '') == 0 then
  opt.directory = vim.fn.expand('~/.config/nvim/swap/') .. '//'
  opt.swapfile = true
  opt.updatecount = 50
else
  opt.swapfile = false
end

-- Text formatting
opt.autoindent = true                    -- Preserve indentation
opt.backspace = { 'indent', 'eol', 'start' }  -- Smart backspace
opt.expandtab = true                     -- Use spaces instead of tabs
opt.shiftround = true                    -- Round indent to shiftwidth
opt.shiftwidth = 4                       -- Indent width
opt.smarttab = true                      -- Smart tab behavior
opt.softtabstop = 4                      -- Soft tab width
opt.tabstop = 4                          -- Tab width
opt.formatoptions:append('j')            -- Remove comment leader when joining

-- System integration
opt.clipboard = 'unnamedplus'            -- Use system clipboard
opt.background = 'dark'                  -- Dark background
opt.termguicolors = true                 -- True color support

-- Enable syntax and filetype detection
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

-- ============================================================================
-- KEY MAPPINGS
-- ============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Config editing shortcuts
keymap('n', '<leader>ve', ':edit $MYVIMRC<CR>', opts)
keymap('n', '<leader>vs', ':source $MYVIMRC<CR>', opts)

-- System clipboard
keymap({'n', 'v'}, '<leader>y', '"+y', opts)

-- Folding
-- keymap('n', '<Space>', '@=(foldlevel(".") ? "za" : "\\<Space>")<CR>', { expr = true, silent = true })
keymap('n', '<Tab>', 'za', opts)
keymap('v', '<Tab>', 'zf', opts)

-- Better navigation (keeping your custom layout)
keymap({'n', 'v'}, 'ö', 'l', opts)       -- ö moves right
keymap({'n', 'v'}, ';', 'l', opts)       -- ; moves right
keymap({'n', 'v'}, 'l', 'gk', opts)      -- l moves up (with wrapped line support)
keymap({'n', 'v'}, 'k', 'gj', opts)      -- k moves down (with wrapped line support)
keymap({'n', 'v'}, 'j', 'h', opts)       -- j moves left

-- Scrolling
keymap({'n', 'v'}, '<C-k>', '<C-d>', opts)  -- Scroll down
keymap({'n', 'v'}, '<C-l>', '<C-u>', opts)  -- Scroll up

-- Insert mode escapes
keymap('i', '<C-j>', '<Esc>', opts)
keymap('i', '<M-j>', '<Esc>', opts)
-- keymap('i', '<C-o>', '<Esc>', opts)
-- keymap('n', '<C-o>', 'i', opts)

-- Disable help and ex mode
keymap({'i', 'n', 'v'}, '<F1>', '<nop>', opts)
keymap('n', 'Q', '<nop>', opts)

-- Buffer navigation
keymap('n', 'gn', ':bnext<CR>', opts)
keymap('n', 'gN', ':bprevious<CR>', opts)
keymap('n', 'gd', ':bdelete<CR>', opts)
keymap('n', 'gf', '<C-^>', opts)

-- Function keys
keymap('n', '<F1>', ':NERDTreeToggle<CR>', opts)
keymap('n', '<F3>', ':set wrap!<CR>', opts)
keymap('n', '<F4>', ':set hlsearch!<CR>', opts)
keymap('n', '<F5>', ':TagbarToggle<CR>', opts)
keymap('n', '<F6>', ':setlocal spell! spelllang=de_de<CR>', opts)

-- -- Plugin shortcuts (will work after plugins are loaded)
-- keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
-- keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
-- keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
-- keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

-- fzf
keymap('n', '<leader>ff', ':Files<CR>', opts)   -- Finding files in current dir
keymap('n', '<leader>fb', ':Buffers<CR>', opts) -- Finding buffers
keymap('n', '<leader>fl', ':BLines<CR>', opts)  -- Finding lines in current buffer
keymap('n', '<leader>fg', ':Rg<CR>', opts)
keymap('n', '<leader>fh', ':History<CR>', opts)

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

-- Toggle syntax highlighting
local function toggle_syntax_highlighting()
  if vim.g.syntax_on then
    vim.cmd('syntax off')
  else
    vim.cmd('syntax on')
  end
end

-- Toggle overlength highlighting
local function toggle_overlength()
  if vim.g.overlength_enabled == 0 then
    vim.fn.matchadd('OverLength', '\\%79v.*')
    vim.g.overlength_enabled = 1
    print('OverLength highlighting turned on')
  else
    vim.fn.clearmatches()
    vim.g.overlength_enabled = 0
    print('OverLength highlighting turned off')
  end
end

-- Toggle relative line numbers
local function number_toggle()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    vim.wo.number = true
  else
    vim.wo.relativenumber = true
    vim.wo.number = false
  end
end

-- Toggle text wrapping
local function wrap_toggle()
  if vim.wo.wrap then
    vim.wo.list = true
    vim.wo.wrap = false
  else
    vim.wo.list = false
    vim.wo.wrap = true
  end
end

-- Delete multiple empty lines
local function delete_multiple_empty_lines()
  vim.cmd('g/^\\_$\\n\\_^$/d')
end

-- Split to relative header/source
local function split_rel_src()
  local fname = vim.fn.expand('%:t:r')
  local ext = vim.fn.expand('%:e')

  if ext == 'h' then
    vim.wo.splitright = false
    vim.cmd('vsplit ' .. vim.fn.fnameescape(fname .. '.cpp'))
    vim.wo.splitright = true
  elseif ext == 'cpp' then
    vim.cmd('vsplit ' .. vim.fn.fnameescape(fname .. '.h'))
  end
end

-- Function key bindings
keymap('n', '<leader>s', toggle_syntax_highlighting, opts)
keymap('n', '<leader>h', toggle_overlength, opts)
keymap('n', '<leader>r', number_toggle, opts)
keymap('n', '<leader>w', wrap_toggle, opts)
keymap('n', '<leader>ld', delete_multiple_empty_lines, opts)
keymap('n', '<leader>le', split_rel_src, opts)

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- File type specific settings
augroup('FileTypeRules', { clear = true })
autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'FileTypeRules',
  pattern = '*.md',
  callback = function()
    vim.opt_local.filetype = 'markdown'
    vim.opt_local.textwidth = 79
  end,
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  group = 'FileTypeRules',
  pattern = '*.tex',
  callback = function()
    vim.opt_local.filetype = 'tex'
    vim.opt_local.textwidth = 79
  end,
})

-- Return to last edit position
augroup('LastPosition', { clear = true })
autocmd('BufReadPost', {
  group = 'LastPosition',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Strip trailing whitespace on save
local function strip_trailing_whitespace()
  local save_cursor = vim.fn.getpos('.')
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setpos('.', save_cursor)
end

augroup('StripTrailingWhitespace', { clear = true })
autocmd('BufWritePre', {
  group = 'StripTrailingWhitespace',
  pattern = { '*.c', '*.cpp', '*.cfg', '*.conf', '*.css', '*.html', '*.py', '*.sh', '*.tex' },
  callback = strip_trailing_whitespace,
})

-- YAML specific settings
autocmd('FileType', {
  pattern = 'yaml',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Ignore swap files in certain directories
augroup('SwapIgnore', { clear = true })
autocmd({ 'BufNewFile', 'BufReadPre' }, {
  group = 'SwapIgnore',
  pattern = { '/tmp/*', '/mnt/*', '/media/*' },
  callback = function()
    vim.opt_local.swapfile = false
  end,
})

-- ============================================================================
-- COLORS AND HIGHLIGHTING
-- ============================================================================

-- Use vim commands for maximum compatibility
augroup('ColorSchemeSetup', { clear = true })

-- Apply custom highlighting with vim commands (more compatible)
local function custom_highlighting()
  -- Transparent background using vim commands
  vim.cmd([[
    highlight Normal ctermbg=NONE
    highlight NonText ctermbg=NONE
    highlight LineNr ctermbg=NONE
    highlight SignColumn ctermbg=NONE
    highlight EndOfBuffer ctermbg=NONE
    highlight CursorLine ctermbg=235
  ]])

  -- Try to set guibg if termguicolors is available
  if vim.opt.termguicolors:get() then
    vim.cmd([[
      highlight Normal guibg=NONE
      highlight NonText guibg=NONE
      highlight LineNr guibg=NONE
      highlight SignColumn guibg=NONE
      highlight EndOfBuffer guibg=NONE
    ]])
  end

  -- Custom annotation colors
  vim.cmd([[
    highlight AnnRed ctermfg=Red guifg=#E01B1B
    highlight AnnBrown ctermfg=Brown guifg=#E0841B
    highlight AnnYellow ctermfg=DarkYellow guifg=#E0D91B
  ]])
end

-- Apply highlighting on colorscheme change
autocmd('ColorScheme', {
  group = 'ColorSchemeSetup',
  callback = custom_highlighting,
})

-- Highlight special keywords
autocmd('Syntax', {
  group = 'ColorSchemeSetup',
  pattern = '*',
  callback = function()
    pcall(vim.fn.matchadd, 'Todo', '\\W\\zs\\(TODO\\|FIXME\\|CHANGED\\|Q?\\|BUG\\|HACK\\)')
    pcall(vim.fn.matchadd, 'AnnYellow', '\\W\\zs\\(NOTE\\|INFO\\|IDEA\\)')
    pcall(vim.fn.matchadd, 'AnnRed', '\\W\\zs\\(WARNING\\|ATTENTION\\|DEBUG\\)')
  end,
})

-- OverLength highlighting setup
vim.g.overlength_enabled = 0
vim.cmd('highlight OverLength ctermbg=238 guibg=#444444')

-- Apply custom highlighting immediately
custom_highlighting()

-- ============================================================================
-- PLUGIN MANAGEMENT (LAZY.NVIM)
-- ============================================================================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications (safe minimal set)
require("lazy").setup({
  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',
    keys = {
      { '<leader>ff', '<cmd>Telescope find_files<cr>' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>' },
    },
  },

  -- Status line
  {
    'vim-airline/vim-airline',
    dependencies = { 'vim-airline/vim-airline-themes' },
    config = function()
      vim.g['airline#extensions#tabline#enabled'] = 1
      vim.g.airline_powerline_fonts = 1
    end,
  },

  -- File explorer
  {
    'preservim/nerdtree',
    keys = { { '<F1>', ':NERDTreeToggle<CR>' } },
  },

  -- Easy motion
  { 'easymotion/vim-easymotion' },

  -- Colorscheme
  {
    'nanotech/jellybeans.vim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme jellybeans')
    end,
  },

  -- Text manipulation
  { 'tpope/vim-surround' },

  -- Snippets
  { 'honza/vim-snippets' },

  -- Start screen
  {
    'mhinz/vim-startify',
    config = function()
      vim.g.startify_bookmarks = {
        '~/.config/nvim/init.lua',
      }
      vim.g.startify_custom_header = {
        '   You are flying with Neovim',
        ''
      }
    end,
  },

  -- Git integration
  { 'mhinz/vim-signify' },

  -- Code navigation
  {
    'preservim/tagbar',
    keys = { { '<F5>', ':TagbarToggle<CR>' } },
    config = function()
      vim.g.tagbar_left = 0
      vim.g.tagbar_width = 30
      vim.opt.tags = 'tags;/'
    end,
  },

  -- Signatures and marks
  { 'kshenoy/vim-signature' },

  -- Text alignment
  { 'godlygeek/tabular' },

  -- Notes (optional)
  {
    'xolox/vim-notes',
    dependencies = { 'xolox/vim-misc' },
    cmd = { 'Note', 'NoteFromSelectedText' },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ft = "yaml",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    "junegunn/fzf",
    build = function()
      vim.cmd "helptags ALL" -- Optional: wenn du die Hilfeseiten haben möchtest
    end,
  },
  { "junegunn/fzf.vim" },
})

-- ============================================================================
-- LOCAL CONFIGURATION
-- ============================================================================

-- Load local configuration files if they exist
local local_files = {
  vim.fn.expand('~/.config/nvim/local_first.lua'),
  vim.fn.expand('~/.config/nvim/local_last.lua')
}

for _, file in ipairs(local_files) do
  if vim.fn.filereadable(file) == 1 then
    pcall(dofile, file)  -- Safe loading
  end
end

-- ============================================================================
-- END OF CONFIGURATION
-- ============================================================================

