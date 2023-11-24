" vim-plug stuff
call plug#begin('~/.vim/plugged')
" Look And Feel
Plug 'tomasr/molokai'
Plug 'itchyny/lightline.vim'
Plug 'dannyob/quickfixstatus'
Plug 'yutkat/confirm-quit.nvim'

" Utility
Plug 'editorconfig/editorconfig-vim'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'chrisbra/Colorizer'
Plug 'ciaranm/securemodelines'
Plug 'prettier/vim-prettier'
Plug 'junegunn/fzf'
" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'junegunn/rainbow_parentheses.vim' " my colorblindness makes this useless :(

" Filetype Specific
Plug 'tmhedberg/SimpylFold'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'nvie/vim-flake8'
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'plasticboy/vim-markdown'
Plug 'PProvost/vim-ps1'
Plug 'fatih/vim-nginx'
Plug 'kchmck/vim-coffee-script'
Plug 'peterhoeg/vim-qml'
" Plug 'calviken/vim-gdscript3' " calviken seems to have deleted their account!
Plug 'artoj/qmake-syntax-vim'
Plug 'kergoth/vim-bitbake'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'tbastos/vim-lua'
Plug 'bfrg/vim-cpp-modern'
Plug 'keith/swift.vim'
Plug 'leafoftree/vim-vue-plugin'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'
Plug 'rhysd/vim-clang-format'
Plug 'rust-lang/rust.vim'
call plug#end()

syntax enable
filetype off
filetype plugin indent on

" Favorite defaults
set nocompatible  " ensure we aren't maintaining vi compatibility (default)
set backspace=indent,eol,start  " allow backspace to go over indentation, eol, and start of current insert
set laststatus=2  " always show statusline
set guioptions-=e  " don't use GUI tabs when in a gui like gvim
set guioptions-=m  " don't show menubar in GUI
set guioptions-=T  " don't show toolbar in GUI
set guioptions-=r  " don't show right scrollbar
set guioptions-=L  " don't show left scrollbar
set scrolloff=5  " always keep 8 lines between the cursor and the top and bottom
set noshowmode  " since we have lightline we don't need to show the current mode
set noerrorbells  " don't play bell sound on errors
set novisualbell  " don't play bell sound for any reason
set belloff=all   " all events should not trigger bell
set tabstop=4  " tabs display as 4 spaces wide
set shiftwidth=4  " (auto)indent to 4 spaces
set expandtab  " pressing tab inserts spaces
set nomodeline  " disable modeline comments to set vim options (security risk)
set number  " show line numbers
set nowrap  " do not soft-wrap lines
set hlsearch  " highlight search pattern matches
set incsearch  " as you type a search pattern start trying to match
set ttyfast  " our terminal is fast so send more characters for smoother display
set wildmenu  " pop up completions over statusline when tabbing in command line
set wildchar=<Tab>  " ensure tab activates wildmenu (default)
set wildignore=*.qmlc,*.jsc,*.pyc
set encoding=utf-8  " prefer utf-8 for files
set listchars=tab:>·,trail:·,nbsp:·
set list
set shortmess-=F

" Unbind the Shift+K man page binding
map <S-k> <Nop>

" Some of my favorites aren't on old vim versions :(
if exists('&colorcolumn')
    set colorcolumn=80
endif

" Enable project specific .vimrcs, disable shell execution
set exrc
set secure

" Jump to last known position in a file after opening it, same as doing `"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Center search result in screen
"nnoremap n nzzzv
"nnoremap N Nzzzv
"nnoremap * *zzzv

" Command to copy all matches in file into specified register (+ by default)
function! CopyMatches(reg)
    let hits = []
    %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
    let reg = empty(a:reg) ? '+' : a:reg
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

" Close buffer without killing split
nmap <silent> <leader>d :bp <bar> :bd #<CR>
nmap <silent> <leader>D :bp! <bar> :bd! #<CR>

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
vmap <leader>j !python -m json.tool --indent 2<CR>

" Show current byte offset
nmap <leader>B :echo eval(line2byte(line('.')) + col('.') - 1)<CR>

" URL encode/decode selection
vnoremap <leader>en :!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>
vnoremap <leader>de :!python -c 'import sys,urllib;print urllib.unquote(sys.stdin.read().strip())'<cr>

" Add command to format xml
command FormatXML :%!python -c "import sys,xml.dom.minidom;print(xml.dom.minidom.parse(sys.stdin).toprettyxml(indent='  '))"

" map fzf to be Ctrl+p and Ctrl+k
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <C-k> :<C-u>FZF<CR>
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" TODO: once tmux 3.2 is released
" if exists('$TMUX')
"     let g:fzf_layout = { 'tmux': '-p90%,60%' }
" else
"     let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" endif

" 'zoom' the current pane
nnoremap <leader>z <C-w>_ \| <C-w>\|

" Disable markdown folding
let g:vim_markdown_folding_disabled = 1

" I always hold shift just a tiny bit too long
command WQ wq
command Wq wq
command W w
command Q q

" Some shorcuts for decoding and re-encoding binary as hex
command TH %!xxd
command FH %!xxd -r

" Rust Plugin Settings
let g:rust_fold = 1

" Clang Format Settings
function ClangFormat(path)
    if &modified
        echoerr 'save before formatting'
    else
        if executable('clang-format')
            let output = system('clang-format -i ' . a:path)
            if v:shell_error != 0
                echoerr 'clang-format error ' output
            endif
        else
            echoerr 'clang-format not found'
        endif
        edit!
    endif
endfunction
function SetCppOptions()
    map <buffer> <leader>p :call ClangFormat(shellescape(@%, 1))<CR>
endfunction
autocmd FileType cpp,c :call SetCppOptions()

" Python Plugin Settings
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_fold_import = 0
let g:flake8_show_in_gutter=1
let g:flake8_show_quickfix=1
function PythonFormat(path)
    if &modified
        echoerr 'save before formatting'
    else
        if executable('isort')
            let output = system('isort ' . a:path)
            if v:shell_error != 0
                echoerr 'isort error ' output
            endif
        else
            echoerr 'isort not found'
        endif
        if executable('black')
            let output = system('black ' . a:path)
            if v:shell_error != 0
                echoerr 'black error ' output
            endif
        else
            echoerr 'black not found'
        endif
        edit!
    endif
endfunction

function PythonLint()
    if executable('flake8')
        call Flake8()
    else
        echo 'flake8 not found'
    endif
endfunction

function PythonBreakpoint()
    let text = "import pdb; pdb.set_trace()"
    exe "normal! O" . text . "\<Esc>"
endfunction

autocmd FileType python :call SetPythonOptions()
function SetPythonOptions()
    map <buffer> <leader>l :call PythonLint()<CR>
    map <buffer> <leader>r :exec '!python' shellescape(@%, 1)<CR>
    map <buffer> <leader>p :call PythonFormat(shellescape(@%, 1))<CR>
    map <buffer> <leader>b :call PythonBreakpoint()<CR>
    syn keyword pythonSelf self
    highlight def link pythonSelf Special
endfunction

autocmd FileType cpp map <buffer> <leader>p :ClangFormat<CR>
autocmd FileType rust map <buffer> <leader>p :RustFmt<CR>

" QML Settings
autocmd FileType qml :call SetQmlOptions()
function SetQmlOptions()
    map <buffer><leader>r :silent exec '!qmlscene' shellescape(@%, 1)<CR>
    setlocal foldmethod=indent
endfunction

" lightline config
let g:lightline = {
      \ 'active': {
      \   'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']],
      \   'right': [['lineinfo'],
      \             ['percent'],
      \             ['charvaluehex', 'charoffsethex', 'fileformat', 'fileencoding', 'filetype']],
      \ },
      \ 'inactive': {
      \   'left': [['relativepath']],
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B',
      \   'charoffsethex': '%o',
      \ },
      \ }


" Vim JSON stuff
let g:vim_json_syntax_conceal = 0

" Enable spellcheck for some stuff
au FileType mail,mkd,rst setlocal spell spelllang=en_us

" Don't auto-wrap lines when editing mail, do interpret a line ending in
" whitespace as meaning the next line continues the same paragraph.
au FileType mail setlocal formatoptions-=t formatoptions+=w

" Makefiles need tabs instead of spaces
au FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0

" JSON, HTML, and XML files should use 2 space indents rather than 4
au FileType json,html,xml setlocal shiftwidth=2

" Several filetypes should have indent foldmethod
au FileType coffee,cpp,json setlocal foldmethod=indent

au FileType gdscript3,lua setlocal foldmethod=syntax noexpandtab

" Give git commits a distinct color scheme.
au FileType gitcommit colorscheme industry

" Treat vue components as html
"au BufRead,BufNewFile *.vue setlocal filetype=html

" Ugh omni-complete for sql files is bound to a shitty key by default
let g:ftplugin_sql_omni_key = '<C-j>'

" Display stuff
if has("win32")
    set mouse=a
    set guifont=Consolas:h11
    set noswapfile
elseif has("gui_macvim")
    set mouse=a
    set guifont=Menlo:h14
elseif has("gui_gtk")
    set mouse=a
    set guifont=Monospace\ 9
endif
silent! colorscheme molokai
hi MatchParen cterm=bold ctermfg=15 ctermbg=none guifg=#ffffff guibg=background gui=bold
autocmd BufRead,BufNewFile * syn match Braces /[\[\](){}]/ | hi Braces ctermfg=gray guifg=#b8b8b8
hi Special cterm=italic gui=italic
hi Comment cterm=italic gui=italic

" Finally, include local private vim config if present
if filereadable(expand("~/.private_vimrc"))
    source ~/.private_vimrc
endif
