" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Initialize the plugin manager (Vim-Plug) and specify the directory where plugins will be installed.
call plug#begin('~/.vim/plugged')

" Define the list of plugins to be installed.
Plug 'tpope/vim-fugitive' " Git integration
Plug 'bling/vim-airline' " Status line
Plug 'vim-airline/vim-airline-themes' " Themes for vim-airline
Plug 'fatih/vim-go' " Go language support
Plug 'pangloss/vim-javascript' " JavaScript syntax highlighting
Plug 'maxmellon/vim-jsx-pretty' " JSX syntax highlighting for React
Plug 'othree/html5.vim' " HTML5 syntax highlighting and indentation
Plug 'hail2u/vim-css3-syntax' " CSS3 syntax highlighting
Plug 'elzr/vim-json' " JSON syntax highlighting and concealing
Plug 'Chiel92/vim-autoformat' " Autoformat code
Plug 'prettier/vim-prettier', { 'do': 'npm install' } " Prettier integration for Vim
Plug 'maksimr/vim-jsbeautify' " JSBeautify integration for Vim
Plug 'ryanoasis/vim-devicons' " File type icons for Vim

" End the plugin initialization.
call plug#end()

" Enable file type detection, plugins, and indentation.
filetype plugin indent on

" Enable syntax highlighting.
syntax on

" Set the character encoding used within Vim to UTF-8.
set encoding=utf-8

" Set the shell to zsh if it is available.
if executable('/bin/zsh')
    set shell=/bin/zsh
elseif executable('/usr/local/bin/zsh')
    set shell=/usr/local/bin/zsh
endif

" Set the shell command flag to -c.
set shellcmdflag=-c

" Enable powerline fonts for vim-airline.
let g:airline_powerline_fonts = 1

" Enable the tabline extension for vim-airline.
let g:airline#extensions#tabline#enabled = 1

" Set the vim-airline theme to 'powerlineish'.
let g:airline_theme='powerlineish'

" Set the number of commands that are stored in the command-line history.
set history=50

" Always show two status lines (one for the current window and one for any split window).
set ls=2

" Show the current mode (e.g., INSERT, NORMAL) on the last line.
set showmode

" Show partial commands on the last line of the screen.
set showcmd

" Allow modelines (settings that can be set within a file itself).
set modeline

" Show the cursor position on the last line of the screen.
set ruler

" Set the title of the window to the file name.
set title

" Display line numbers.
set nu

" Disable line wrapping.
set nowrap

" Break lines at word boundaries.
set linebreak

" Show a special character when a line is wrapped.
set showbreak=▹

" Copy indent from current line when starting a new line.
set autoindent

" Ignore case in search patterns.
set ignorecase

" Override the 'ignorecase' option if the search pattern contains upper case characters.
set smartcase

" Use the 'g' flag in search patterns by default.
set gdefault

" Highlight search matches.
set hlsearch

" Show matching brackets when the text indicator is over them.
set showmatch

" Hide buffers instead of closing them.
set hidden

" Configure backspace behavior.
set backspace=eol,start,indent

" Set the number of spaces used for each step of (auto)indent.
set shiftwidth=4

" Set the number of spaces that a <Tab> in the file counts for.
set tabstop=4

" Set the number of spaces that a <Tab> counts for while performing editing operations.
set softtabstop=4

" Round indent to a multiple of 'shiftwidth' when using '<' and '>' commands.
set shiftround

" Use spaces instead of tabs.
set expandtab

" Enable mouse support in all modes.
set mouse=a

" If the terminal supports 256 colors, try to use the xoria256 color scheme.
if &t_Co == 256
    try
        color xoria256
    catch /^Vim\%((\a\+)\)\=:E185/
    endtry
endif

" Set the mapleader key to ','.
let mapleader = ","

" Key mappings for tab management.
nnoremap 8 <Esc>:tabe<CR> " Open a new tab.
nnoremap 9 gT " Go to the previous tab.
nnoremap 0 gt " Go to the next tab.
nnoremap 7 :tabclose<CR> " Close the current tab.

" Normal mode mappings for line navigation.
nnoremap <silent> k gk " Move up one line (handles wrapped lines).
nnoremap <silent> j gj " Move down one line (handles wrapped lines).
nnoremap <silent> <Up> gk " Use the up arrow key to move up one line (handles wrapped lines).
nnoremap <silent> <Down> gj " Use the down arrow key to move down one line (handles wrapped lines).

" Command-line mode mappings for cursor movement.
cnoremap <C-a> <Home> " Move to the beginning of the command line.
cnoremap <C-e> <End> " Move to the end of the command line.

" Map <Leader>b to a function that decodes a Base64 word under the cursor.
nmap <Leader>b :call DecodeBase64Word()<CR>

function! DecodeBase64Word()
  let l:word = expand('<cword>')
  if empty(l:word)
    echo "No word under cursor"
    return
  endif
  let l:cmd = 'printf "%s" ' . shellescape(l:word) . ' | base64 -d 2>/dev/null | cat'
  let l:result = system(l:cmd)
  if v:shell_error || empty(l:result)
    echo "Failed to decode base64 or not valid base64 string"
    return
  endif
  tabnew
  call setline(1, split(l:result, "\n"))
endfunction

" Map <Leader>s to sort the current buffer uniquely and in version-sort order.
nmap <Leader>s :%!sort -u --version-sort<CR>

" Enable command-line completion with <Tab>.
set wildmenu

" Define a command :W that acts like :w.
command! W w

" Define a command :Qall that acts like :qall.
command! -bang Qall qall

" Disable folding.
set nofoldenable

" If VIMENV environment variable is set to 'prev', set up key mappings for a preview environment.
if $VIMENV == 'prev'
  noremap <Space> :n<CR> " Go to the next file.
  noremap <Backspace> :N<CR> " Go to the previous file.
  noremap <C-D> :call delete(expand('%')) | argdelete % | bdelete<CR> " Delete the current file and close the buffer.
  set noswapfile " Disable swap file creation.
endif

" Normal mode mappings for cursor movement to the beginning and end of a line.
noremap <Home> ^ " Move to the first non-blank character of the line.
noremap <End> $ " Move to the end of the line.

" Insert mode mappings for cursor movement to the beginning and end of a line.
inoremap <Home> <C-O>^ " Move to the first non-blank character of the line in insert mode.
inoremap <End> <C-O>$ " Move to the end of the line in insert mode.

" If running MacVim, set the Mac meta key option.
if has('gui_macvim')
    set macmeta
endif

" Map <leader>z to open a terminal in a new tab.
nnoremap <leader>z :term zsh<CR>

" Map <leader>p to run Prettier on the current buffer.
nnoremap <leader>p :Prettier<CR>

" Define a function to grep for the word under the cursor and display the results in a new tab.
function! GrepAndRead()
    let word = expand("<cword>")
    let command = "grep -Hnr " . shellescape(word) . " ."
    let result = system(command)
    if v:shell_error == 0
        tabnew
        put =result
    else
        echo "grep failed with error: " . result
    endif
endfunction

" Map <Leader>g to call the GrepAndRead function.
nmap <Leader>g :call GrepAndRead()<CR>
