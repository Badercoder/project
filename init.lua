---[ AUTOCMD ]---------------------------------------------------------{{{
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


---[ Settings ]--------------------------------------------------------{{{
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.scrolloff = 6
vim.opt.isfname:append("@-@")
---------[ Backups ]------------
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

---[ Remaps ]----------------------------------------------------------{{{
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
---------[ Basics ]-------------
vim.keymap.set("n","<leader>l",":Lazy<Cr>", {})
vim.keymap.set("n","<leader>w",":w<Cr>", {})
vim.keymap.set("n","<leader>q",":q<Cr>", {})
vim.keymap.set("n","<leader>ex",":Ex<Cr>", {})
vim.keymap.set("n","<leader>so",":source ~/.config/nvim/init.lua<Cr>", {})
---------[ Buffer Mgt ]---------
vim.keymap.set("n","<leader>bd",":bd<Cr>", {})
vim.keymap.set("n","<A-PageUp>",":bprev<Cr>", {})
vim.keymap.set("n","<A-PageDown>",":bnext<Cr>", {})
---------[ Navigations ]--------
vim.keymap.set("n","<PageUp>","26k", {})
vim.keymap.set("n","<PageDown>","26j", {})
vim.keymap.set("n","<C-UP>","<C-y>", {})
vim.keymap.set("n","<C-Down>","<C-e>", {})
---------[ Editing ]------------
vim.keymap.set("n","<leader>c",":set colorcolumn=", {})
vim.keymap.set("v","<C-c>",[["+y"]], {})
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "p", [["_dP]])
vim.keymap.set("n", "<A-Up>", "$V0", {})
vim.keymap.set("n", "<A-Down>", "0V$", {})
---------[ Tabs ]---------------
vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

---[ Plugins ]---------------------------------------------------------{{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
   spec = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-lua/plenary.nvim" },
      { "MunifTanjim/nui.nvim" },
      { 'akinsho/bufferline.nvim', version = "*", opts = {} },
      {
         'nvim-lualine/lualine.nvim',
         opts = {
            options = {
               icons_enabled = true,
               theme = 'powerline',
               section_separators = { left = '', right = '' },
               component_separators = { left = ' ', right = '' },
               disabled_filetypes = {
                  statusline = { "neo-tree" },
                  winbar = {},
               },
            },
            sections = {
               lualine_a = {'mode'},
               lualine_b = {'branch', 'diff', 'diagnostics'},
               lualine_c = {'filename', 'filesize'},
               lualine_x = {'filetype'},
               lualine_y = {'progress'},
               lualine_z = {'location'}
            }
         }

      },
      { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
      {
         "nvim-treesitter/nvim-treesitter",
         version = false, -- last release is way too old and doesn't work on Windows
         build = ":TSUpdate",
         event = { "VeryLazy" },
         opts = {},
         config = function()
            require'nvim-treesitter.configs'.setup{
               ensure_installed = {
                  "bash",
                  "lua",
                  "luadoc",
                  "luap",
                  "vim",
                  "vimdoc",
                  "html",
                  "css",
                  "javascript",
                  "jsdoc",
               },
               highlight = { enable = true },
               indent = { enable = true },
            }
         end
      },
      { "folke/todo-comments.nvim", opts = {} },
      {
         "nvim-neo-tree/neo-tree.nvim",
         branch = "v3.x",
         opts = {},
         config = function()
            require("neo-tree").setup({
               window = {
                  position = "right",
                  width = 32,
               },
            })
            vim.keymap.set("n", "<leader>t", ":Neotree toggle<Cr>", {})
            -- vim.cmd("Neotree")
         end
      },
      { 'echasnovski/mini.starter', version = '*', opts = {} },
      { 'brenoprata10/nvim-highlight-colors', opts = {} },
   },
   install = { colorscheme = { "retrobox" } },
   -- checker = { enabled = true },
})

---[ On Start/ After plugins load ]------------------------------------{{{
vim.cmd.colorscheme("retrobox")
vim.cmd([[ highlight ColorColumn ctermbg=green guibg=green ]])
vim.cmd([[ hi Visual  guifg=#000000 guibg=#8fd9fb gui=none ]])

