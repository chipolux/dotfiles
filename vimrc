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
set colorcolumn=81
set expandtab
set number
set nowrap
set hlsearch
set incsearch
set ttyfast
set mouse=a

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
let g:pymode_lint = 0
let g:pymode_rope_complete_on_dot = 0

" Airline stuff
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

" Vim JSON stuff
let g:vim_json_syntax_conceal = 0

" Statusline if airline/powerline not available
set statusline=%t\ %m%=%c,%l/%L\ %P

" Rainbow parenthesis stuff
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

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

" Change cursor shape in different modes
" iTerm2 and tmux on OSX
"let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
