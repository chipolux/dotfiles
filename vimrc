" Vundle stuff
set rtp +=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'guns/vim-clojure-static'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'elzr/vim-json'
Plugin 'plasticboy/vim-markdown'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'klen/python-mode'
Plugin 'groenewege/vim-less'
Plugin 'tpope/vim-fugitive'
call vundle#end()

syntax enable
filetype plugin indent on

" Favorite defaults
set backspace=2
set laststatus=2
set tabstop=4
set shiftwidth=4
set expandtab
set number
set nowrap
set hlsearch
set incsearch
set ttyfast
set mouse=a
set wildmenu
set wildchar=<Tab>

" Some of my favorites aren't on old vim versions :(
if exists('&colorcolumn')
    set colorcolumn=79
endif

" Enable project specific .vimrcs, disable shell execution
set exrc
set secure

" Close buffer without killing split
nmap <silent> <leader>d :bp\|bd #<CR>
nmap <silent> <leader>D :bp!\|bd #<CR>

" Remove trailing whitespace
nmap <silent> <leader>s :%s/\s\+$//<CR>

" Quickly open file tree
" You can use let g:netrw_liststyle=1-4
" To change tree display
nmap <leader>t :Explore<CR>

" Toggle highlighting cursor column and line
nmap <leader>v :set cursorline! cursorcolumn!<CR>

" Vim-Pymode Stuff
let g:pymode_rope = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_options_max_line_length = 79

" Airline stuff
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

" Vim JSON stuff
let g:vim_json_syntax_conceal = 0

" Statusline if airline/powerline not available
set statusline=%t\ %m%=%c,%l/%L\ %P

" Folding stuff
au FileType javascript call JavaScriptFold()
au FileType json setlocal foldmethod=syntax

" Enable spellcheck for some stuff
au FileType mail,mkd,rst setlocal spell spelllang=en_us

" Display stuff
if has("gui_running")
    set guifont=Inconsolata\ for\ Powerline:h11
else
    let g:solarized_termcolors = 256
endif
silent! colorscheme solarized
set background=dark
