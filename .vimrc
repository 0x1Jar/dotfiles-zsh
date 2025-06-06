set nocompatible

" Use vim-plug for plugin management
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go'
" HTML, CSS, JavaScript, JSON, and formatting plugins
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'elzr/vim-json'
Plug 'Chiel92/vim-autoformat'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'maksimr/vim-jsbeautify'
Plug 'ryanoasis/vim-devicons'
call plug#end()

filetype plugin indent on
syntax on
set encoding=utf-8

" Ensure Vim uses Zsh for external commands
if executable('/bin/zsh')
    set shell=/bin/zsh
elseif executable('/usr/local/bin/zsh')
    set shell=/usr/local/bin/zsh
endif
set shellcmdflag=-c

" Airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish'

set history=50
set ls=2
set showmode
set showcmd
set modeline
set ruler
set title
set nu
set nowrap
set linebreak
set showbreak=▹
set autoindent
set ignorecase
set smartcase
set gdefault
set hlsearch
set showmatch
set hidden
set backspace=eol,start,indent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set shiftround
set expandtab
set mouse=

" Colorscheme
if &t_Co == 256
    try
        color xoria256
    catch /^Vim\%((\a\+)\)\=:E185/
        " Oh well
    endtry
endif

" Tab navigation
nnoremap 8 <Esc>:tabe<CR>
nnoremap 9 gT
nnoremap 0 gt
nnoremap 7 :tabclose<CR>

" Direction keys for wrapped lines (normal mode only)
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> <Up> gk
nnoremap <silent> <Down> gj

" Hapus semua mapping arrow key di insert mode agar arrow key berfungsi normal
iunmap <Up>
iunmap <Down>
iunmap <Left>
iunmap <Right>

" Bash / emacs keys for command line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Base64 decode word under cursor
nmap <Leader>b :!echo <C-R><C-W> | base64 -d<CR>

" grep recursively for word under cursor
nmap <Leader>g :tabnew|read !grep -Hnr '<C-R><C-W>'<CR>

" sort the buffer removing duplicates
nmap <Leader>s :%!sort -u --version-sort<CR>

set wildmenu

command! W w
command! -bang Qall qall

set nofoldenable

if $VIMENV == 'prev'
  noremap <Space> :n<CR>
  noremap <Backspace> :N<CR>
  noremap <C-D> :call delete(expand('%')) | argdelete % | bdelete<CR>
  set noswapfile
endif

set noesckeys

noremap <Home> ^
noremap <End> $
inoremap <Home> <C-O>^
inoremap <End> <C-O>$

if has('gui_macvim')
    set macmeta
endif

nnoremap <leader>z :term zsh<CR>
nnoremap <leader>p :Prettier<CR>

" Info: :!sh tidak akan membuka shell interaktif penuh, gunakan :term zsh atau <leader>z
