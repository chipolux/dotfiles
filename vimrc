" Pathogen stuff
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
execute pathogen#helptags()

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

" Close buffer without killing split
nmap <silent> <leader>d :bp\|bd #<CR>
nmap <silent> <leader>D :bp!\|bd #<CR>

" Remove trailing whitespace
nmap <silent> <leader>s :%s/\s\+$//<CR>

" Vim-Pymode Stuff
let g:pymode_lint = 0
let g:pymode_options_max_line_length = 80
let g:pymode_rope_complete_on_dot = 0
let g:pymode_breakpoint_cmd = ''

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
au FileType json set foldmethod=syntax

" Display stuff
if has("gui_running")
    set guifont=Inconsolata\ for\ Powerline:h11
else
    let g:solarized_termcolors = 256
endif
colorscheme solarized
set background=dark
