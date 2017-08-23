" Vundle stuff
set rtp +=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Look And Feel
Plugin 'tomasr/molokai'
Plugin 'itchyny/lightline.vim'

" Filetype Specific
Plugin 'klen/python-mode'
Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'plasticboy/vim-markdown'
Plugin 'sudar/vim-arduino-syntax'
Plugin 'wavded/vim-stylus'
Plugin 'PProvost/vim-ps1'
Plugin 'wannesm/wmgraphviz.vim'
Plugin 'fatih/vim-nginx'
Plugin 'kchmck/vim-coffee-script'
Plugin 'a-watson/vim-gdscript'
Plugin 'JuliaLang/julia-vim'
Plugin 'peterhoeg/vim-qml'

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
set nocompatible  " ensure we aren't maintaining vi compatibility (default)
set backspace=indent,eol,start  " allow backspace to go over indentation, eol, and start of current insert
set laststatus=2  " always show statusline
set guioptions-=e  " don't use GUI tabs when in a gui like gvim
set tabstop=4  " tabs display as 4 spaces wide
set shiftwidth=4  " (auto)indent to 4 spaces
set expandtab  " pressing tab inserts spaces
set modeline  " enable modeline comments to set vim options (security risk)
set number  " show line numbers
set nowrap  " do not soft-wrap lines
set hlsearch  " highlight search pattern matches
set incsearch  " as you type a search pattern start trying to match
set ttyfast  " our terminal is fast so send more characters for smoother display
set mouse=a  " enable mouse control
set wildmenu  " pop up completions over statusline when tabbing in command line
set wildchar=<Tab>  " ensure tab activates wildmenu (default)

" Unbind the Shift+K man page binding
map <S-k> <Nop>

" Useful re-bindings
" command WQ wq
" command Wq wq
" command W w
" command Q q
" nnoremap ; :

" set statusline=%([%H%W]\ %)%.25f\ %y[%{&ff}]%m%r%=%c,%l/%L\ %P

" Some of my favorites aren't on old vim versions :(
if exists('&colorcolumn')
    set colorcolumn=80
endif

" Enable project specific .vimrcs, disable shell execution
set exrc
set secure

" Jump to last known position in a file after opening it, same as doing `"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

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

" Format selected json using python
vmap <leader>j !python -m json.tool<CR>

" Show current byte offset
nmap <leader>b :echo eval(line2byte(line('.')) + col('.') - 1)<CR>

" Vim-Pymode Stuff
let g:pymode_rope = 0
let g:pymode_doc = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_lint_cwindow = 0
let g:pymode_lint_unmodified = 1
nmap <leader>l :let g:pymode_lint_cwindow = 1 <bar> :PymodeLint<CR>

" Vim JSON stuff
let g:vim_json_syntax_conceal = 0

" Enable spellcheck for some stuff
au FileType mail,mkd,rst setlocal spell spelllang=en_us

" Don't auto-wrap lines when editing mail, do interpret a line ending in
" whitespace as meaning the next line continues the same paragraph.
au FileType mail setlocal formatoptions-=t formatoptions+=w
" tcql aw
" croql

" Makefiles need tabs instead of spaces
au FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0

" Coffescript files should set foldmethod to indent
au FileType coffee setlocal foldmethod=indent

" Ugh omni-complete for sql files is bound to a shitty key by default
let g:ftplugin_sql_omni_key = '<C-j>'

" Display stuff
if has("gui_running")
    set guifont=Inconsolata\ for\ Powerline:h14
endif
silent! colorscheme molokai
