" Vundle stuff
set rtp +=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Look And Feel
Plugin 'altercation/vim-colors-solarized'
Plugin 'itchyny/lightline.vim'

" Filetype Specific
Plugin 'klen/python-mode'
Plugin 'elzr/vim-json'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'plasticboy/vim-markdown'
Plugin 'sudar/vim-arduino-syntax'
Plugin 'wavded/vim-stylus'
Plugin 'PProvost/vim-ps1'
Plugin 'wannesm/wmgraphviz.vim'

" Utility
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'
call vundle#end()

syntax enable
filetype plugin indent on

" Favorite defaults
set backspace=2
set laststatus=2
set guioptions-=e
set tabstop=4
set shiftwidth=4
set modeline
set expandtab
set number
set nowrap
set hlsearch
set incsearch
set ttyfast
set mouse=a
set wildmenu
set wildchar=<Tab>

set statusline=%([%H%W]\ %)%.25f\ %y%m%r%=%c,%l/%L\ %P

" Some of my favorites aren't on old vim versions :(
if exists('&colorcolumn')
    set colorcolumn=80
endif

" Enable project specific .vimrcs, disable shell execution
set exrc
set secure

" Close buffer without killing split
nmap <silent> <leader>d :bp <bar> :bd #<CR>
nmap <silent> <leader>D :bp! <bar> :bd #<CR>

" Remove trailing whitespace
nmap <silent> <leader>s :%s/\s\+$//<CR>

" Quickly open file tree
" You can use let g:netrw_liststyle=1-4
" To change tree display
nmap <leader>t :Explore<CR>

" Toggle highlighting cursor column and line
nmap <leader>v :set cursorline! cursorcolumn!<CR>

" Toggle folding by syntax
nmap <leader>f :setlocal foldmethod=syntax<CR>

" Vim-Pymode Stuff
let g:pymode_rope = 0
let g:pymode_doc = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_lint_cwindow = 0
let g:pymode_lint_unmodified = 1
nmap <leader>l :let g:pymode_lint_cwindow = 1 <bar> :PymodeLint<CR>

" Vim JSON stuff
let g:vim_json_syntax_conceal = 0

" Folding stuff
au FileType javascript call JavaScriptFold()

" Enable spellcheck for some stuff
au FileType mail,mkd,rst setlocal spell spelllang=en_us

" Some wrapping stuff for editing mail
au FileType mail setlocal fo+=aw

" Makefiles need tabs instead of spaces
au FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0

" Ugh omni-complete for sql files is bound to a shitty key by default
let g:ftplugin_sql_omni_key = '<C-j>'

" Display stuff
if has("gui_running")
    set guifont=Inconsolata\ for\ Powerline:h14
else
    let g:solarized_termcolors = 256
endif
silent! colorscheme solarized
set background=dark
