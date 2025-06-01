set nocompatible

" Use vim-plug instead of Vundle
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

call plug#end()

filetype plugin indent on

syntax on
set encoding=utf-8

" Ensure Vim uses Zsh for external commands
" User might need to adjust this path if Zsh is installed elsewhere (e.g., /usr/local/bin/zsh for Homebrew)
if executable('/bin/zsh')
    set shell=/bin/zsh
elseif executable('/usr/local/bin/zsh')
    set shell=/usr/local/bin/zsh
endif
" Use shell options to ensure :!sh, :!bash, and :!zsh run zsh
set shellcmdflag=-c
" Alias :!sh and :!bash to zsh
command! -nargs=* Sh execute '!zsh <args>'
command! -nargs=* Bash execute '!zsh <args>'
" Now, inside vim, :!sh or :!bash will run a temporary zsh
" and return to vim after completion
" Example: :Sh ls -al
" or :Bash echo hello
" For :!sh it can still be used, but it will run the set shell (zsh)
" and not the user's default shell

" Airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish'

" History
set history=50

" Display
set ls=2
set showmode
set showcmd
set modeline
set ruler
set title
set nu

" Line wrapping
set nowrap
set linebreak
set showbreak=▹

" Auto indent what you can
set autoindent

" Searching
set ignorecase
set smartcase
set gdefault
set hlsearch
set showmatch

" Enable jumping into files in a search buffer
set hidden 

" Make backspace a bit nicer
set backspace=eol,start,indent

" Indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set shiftround
set expandtab

" Disable mouse
set mouse=

" Colorscheme
if &t_Co == 256
    try
        color xoria256
    catch /^Vim\%((\a\+)\)\=:E185/
        " Oh well
    endtry
endif

" Switch tabs
nnoremap 8 <Esc>:tabe
nnoremap 9 gT
nnoremap 0 gt
" Custom: Close current tab with 7
nnoremap 7 :tabclose<CR>

" Direction keys for wrapped lines
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> <Up> gk
nnoremap <silent> <Down> gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Bash / emacs keys for command line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Base64 decode word under cursor
nmap <Leader>b :!echo <C-R><C-W> \| base64 -d<CR>

" grep recursively for word under cursor
nmap <Leader>g :tabnew\|read !grep -Hnr '<C-R><C-W>'<CR>

" sort the buffer removing duplicates
nmap <Leader>s :%!sort -u --version-sort<CR>

" Visual prompt for command completion
set wildmenu

" I type these wrong often
command! W w
command! -bang Qall qall

" folding
set nofoldenable

" a mode for quickly looking at lots of files
if $VIMENV == 'prev'
  noremap <Space> :n<CR>
  noremap <Backspace> :N<CR>
  noremap <C-D> :call delete(expand('%')) <bar> argdelete % <bar> bdelete<CR>
  set noswapfile
endif

set noesckeys

" Map Home and End keys explicitly because Mac might need fn key
noremap <Home> ^
noremap <End> $
inoremap <Home> <C-O>^
inoremap <End> <C-O>$

" Map Option key as Meta key (might need terminal app to set "Use Option as Meta key")
if has("gui_macvim")
    set macmeta
endif

" Keybinding: <leader>z untuk buka terminal zsh di dalam Vim
nnoremap <leader>z :term zsh<CR>

" Info: :!sh tidak akan membuka shell interaktif penuh, gunakan :term zsh atau <leader>z
