
" NeoVim 'vimrc' of aika

" ## -- Plug --

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" https://github.com/junegunn/vim-plug#neovim
call plug#begin('~/.local/share/nvim/plugged')

" CtrlP fuzzy finder
" https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

" to deal with trailing whitespace
" https://github.com/ntpeters/vim-better-whitespace
Plug 'ntpeters/vim-better-whitespace'

" True snippet and additional text editing support
Plug 'sheerun/vim-polyglot'
" :CocInstall coc-rls coc-json coc-explorer coc-tsserver

" LSP and autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'josa42/nvim-lightline-lsp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" File Explorer
" Plug 'preservim/nerdtree'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'itchyny/lightline.vim'
Plug 'akinsho/nvim-bufferline.lua'

" Plug 'folke/tokyonight.nvim'
" Plug 'stsewd/ayu-vim', {'branch': 'fork-2'}
Plug 'k4yt3x/ayu-vim-darker'

" comments
" gcc for one line; gc for multiple
Plug 'tpope/vim-commentary'

" JSX syntax highlighting
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" Delete a buffer without changing the layout
Plug 'qpkorr/vim-bufkill'

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'tpope/vim-fugitive'  " Git wrapper

call plug#end()

" ## -- Plug --

" ## General

nnoremap <Space> <Nop>
let mapleader="\<SPACE>"

syntax on
filetype on
set relativenumber
set nu
set smartindent
set formatoptions-=o " don't continue comments on newlines
set termguicolors
set nojoinspaces " prevent two spaces in a row
set splitbelow splitright " normal splits ffs
set nostartofline " don't jump to first char of the line
set hidden nobackup nowritebackup
set cmdheight=2 " more space for messages
set updatetime=300
set shortmess+=c
" set completeopt=noinsert,menuone,noselect
set completeopt=menu,menuone,noselect
inoremap <c-c> <ESC>
command! Q q " map that annoying shift Q to normal q
command! WQ wq " and this annoying too

" unmap arrow keys :> i don't use them at all these days
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" ## Editor

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" yank to system clipboard
vnoremap <Leader>y "*y

" use bufkill for buffer deletion
nnoremap <silent> <Leader>q :BD<CR>
nnoremap <silent> <Leader>Q :bdelete!<CR>
nnoremap <silent> <Leader>k :BufferLineCycleNext<CR>
nnoremap <silent> <Leader>j :BufferLineCyclePrev<CR>
" nnoremap <silent><mymap> :BufferLineMoveNext<CR>
" nnoremap <silent><mymap> :BufferLineMovePrev<CR>

" placeholder replacer stolen from Luke Smith
" https://www.youtube.com/watch?v=cTBgtN-s2Zw
vnoremap <Leader><Tab> <Esc>/<++><CR>"_c4l
map <Leader><Tab> <Esc>/<++><CR>"_c4l

" clear last search pattern
map <Leader>/ :let @/ = ""<CR>

" trailing whitespace highlighting
highlight ExtraWhitespace ctermbg=16
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:strip_whitelines_at_eof=1 " strip blank lines at <eof>
let g:better_whitespace_skip_empty_lines=1

" active split selection
nmap <silent> <C-j> :wincmd h<CR>
nmap <silent> <C-k> :wincmd l<CR>

" ## Theme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:ayucolor="dark"
colorscheme ayu
let g:lightline = { 'colorscheme': 'ayu', }

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" line at column 160; this is optimal for a habit of writing good length
" code
set colorcolumn=160
hi ColorColumn NONE
hi link ColorColumn CursorLineNr

" turns off -- INSERT -- messages and such as they're not needed anymore
set noshowmode
set laststatus=2

" Highlights for errors
highlight QuickFixLine cterm=bold ctermfg=none ctermbg=none guifg=none
hi CursorLineNR guifg=#fff gui=bold cterm=bold
hi SignColumn guibg=NONE ctermbg=NONE
hi VertSplit guibg=NONE
hi NonText guifg=bg
hi link GitSignsCurrentLineBlame Comment

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" ## Polyglot
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

" ## NVimTree

let g:nvim_tree_side = 'left' "left by default
let g:nvim_tree_width = 40 "30 by default, can be width_in_columns or 'width_in_percent%'
let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ] "empty by default, don't auto open tree on specific filetypes.
let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
let g:nvim_tree_indent_markers = 0 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 0 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1, 'CMakeLists.txt': 1, 'README': 1, 'INSTALL': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 0,
    \ 'folder_arrows': 1,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': ' ',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>t :NvimTreeFindFile<CR>
" NvimTreeOpen and NvimTreeClose are also available if you need them

" a list of groups can be found at `:help nvim_tree_highlight`
" highlight NvimTreeFolderIcon guibg=blue

" ## LightLine

let g:lightline = {'colorscheme': 'ayu_dark'}
let g:lightline.enable = {'tabline': 0}
let g:lightline.separator = {'left': '', 'right': ''}
let g:lightline.component_function = {'gitbranch': 'FugitiveHead'}
let g:lightline.active = {}
let g:lightline.active.left = [
      \ ['mode', 'paste'],
      \ ['lsp_info', 'lsp_hints', 'lsp_errors', 'lsp_warnings', 'lsp_ok' ], [ 'lsp_status' ],
      \ ['gitbranch', 'readonly', 'filename', 'modified'],
      \]
let g:lightline.active.right = [
      \ ['lineinfo'], ['percent'], ['filetype'],
      \]

call lightline#lsp#register()

" ## Misc

" autoreload at save
" neovim vimrc
autocmd BufWritePost init.vim silent so %
" Xresources etc
autocmd BufWritePost ~/.Xresources,~/.Xdefaults silent !xrdb %

autocmd BufWritePost * silent lua vim.lsp.buf.formatting()

autocmd BufWritePost config.lua silent luafile %

" bottom bar
if !has('gui_running')
    set t_Co=256
endif

" fuzzy finder
nnoremap <Leader>e :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>

luafile $HOME/.config/nvim/config.lua
