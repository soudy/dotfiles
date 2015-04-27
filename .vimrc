" basic settings
syntax enable
set nocompatible
set autoindent
set hidden
set smarttab
set showmatch
set ruler
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
set ttyfast
set lazyredraw
set showcmd
set softtabstop=4
set backspace=eol,start,indent
set colorcolumn=80
set noshowmode
set sj=-50
set cursorline
set title
set autoread
filetype plugin indent on

set completeopt=longest,menuone

" wildmenu
set wildmenu
set wildmode=list:longest,full

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

set wildignore+=*.luac                           " Lua byte code

set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code

set wildignore+=*.orig " Merge resolution files

" new splits default to right, or below
set splitbelow
set splitright

set nowrap
set nopaste
set textwidth=80
set formatoptions=trqlcj

" tabs for makefiles
au FileType make setlocal noexpandtab

au! FileType css,scss setlocal iskeyword+=-

" highlighting
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.md set ft=markdown spell

colorscheme dc2
let &titleold=getcwd()

" enable pathogen
call pathogen#infect()

" handle swp files
set directory=~/.vim/swap,~/tmp,.
set noswapfile

"backup
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" enable clipboard
set clipboard=unnamed

" Automatically source vimrc on save.
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" enable utf8
set encoding=utf8
set termencoding=utf-8

" searching
set incsearch
set hlsearch
set smartcase
set ignorecase

" persistent undo history
set undofile                 " Save undo's after file closes
set undodir=~/.vim/undo,/tmp " where to save undo histories
set undolevels=1000          " How many undos
set undoreload=10000         " number of lines to save for undo

" return to last edit position when opening file
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif"`'")"'")

" switching between number mode
function! ToggleNumberMode()
    if &relativenumber == 1
        set norelativenumber
        set number
        echo "normal numbering"
        " elseif &number == 1
        " set nonumber
        " echo "numbering off"
    else
        set relativenumber
        echo "relative numbering"
    endif
    return
endfunc

function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent>j <C-R>=OmniPopup('j')<CR>
inoremap <silent>k <C-R>=OmniPopup('k')<CR>

" maps
noremap 0 ^
noremap ^ 0
nnoremap <C-o> :NERDTreeToggle<cr>
map Y y$
nnoremap Z :bprev<cr>
nnoremap X :bnext<cr>
nnoremap <M-Z> :tabprev<cr>
nnoremap <M-X> :tabnext<cr>
imap <C-BS> <C-W>

" switch to pwd
map <leader>cd :cd %:p:h<cr>:pwd<cr>

map <C-k> ddkP
map <C-j> ddp

" emacs binds in insert mode
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$

" paste mode toggle
set pastetoggle=<F2>

" bind Ctrl+<movement> keys to move around the windows, instead of using
" Ctrl+w + <movement>
" noremap <C-j> <c-w>j
" noremap <C-k> <c-w>k
" noremap <C-l> <c-w>l
" noremap <C-h> <c-w>h
"
" toggle spell check
nnoremap <leader>sc :setlocal spell!<cr>

" tabular
nnoremap <leader>t :Tab /=<cr>

" disable Ex mode and help
noremap <F1> <nop>
nnoremap Q :bw<cr>

" reselect after indenting selection
vnoremap < <gv
vnoremap > >gv

" commenting
map <C-c> <Leader>cm<cr>
map <C-x> <Leader>cu<cr>
map <C-a> <Leader>cs<cr>

" number sign fix
inoremap # X<c-h>#

" search will center on the line it's found in.
nnoremap N Nzz
nnoremap n nzz

" swap : with ;
noremap ; :
noremap : ;

" surrounds
map <Leader>s ysiw

nnoremap <CR> :noh<CR>

" write to read only file
cnoremap w!! w !sudo tee % >/dev/null

" toggle invisible characters
nnoremap <leader>i :set list!<cr>

" reformat file
nnoremap <Leader>f mzgg=G`z`

" reformat block
nnoremap <Leader>b =iB

" toggle number mode
nnoremap <f6> :call ToggleNumberMode()<cr>
vnoremap <f6> :call ToggleNumberMode()<cr>
inoremap <f6> <c-o>:call ToggleNumberMode()<cr>

" system clipboard pasting
nnoremap <Leader>y :call system('xclip', @0)<cr>
nnoremap <Leader>p "+p

" deleting without saving to default register
nnoremap <Leader>d "_d
nnoremap <Leader>D "_D
nnoremap <Leader>C "_C
nnoremap <Leader>c "_c
nnoremap <Leader>x "_x

" taglist
nnoremap <F3> :TlistToggle<cr>

" resizing
noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W><
noremap <right> 3<C-W>>

" move visual block
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

" switching between tab modes
"nmap <Leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<cr>
"nmap <Leader>T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<cr>
"
" remove ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
"
" remove trailing whitespace
nnoremap <Leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<cr>

" easy filetype switching
nnoremap <Leader>md :set ft=markdown<CR>
nnoremap <Leader>hd :set ft=htmldjango<CR>
nnoremap <Leader>jt :set ft=htmljinja<CR>
nnoremap <Leader>js :set ft=javascript<CR>
nnoremap <Leader>pd :set ft=python.django<CR>

" open header file
nnoremap <F4> :AS<cr>

" switch between hex and dec
noremap <F10> :call HexMe()<CR>
let $in_hex=0
function! HexMe()
    set binary
    set noeol
    if $in_hex>0
        :%!xxd -r
        let $in_hex=0
    else
        :%!xxd
        let $in_hex=1
    endif
endfunction

" space after comment
let NERDSpaceDelims=1

" matchtag custom color
let g:mta_use_matchparen_group = 0
let g:mta_set_default_matchtag_color = 0

" disable php folding
let g:DisableAutoPHPFolding = 1

" powerline
set laststatus=2
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" tell syntastic to use c++11 standards
let g:syntastic_cpp_compiler_options = " -std=c++11"
let g:syntastic_aggregate_errors = 1
let g:syntastic_javascript_checkers = ['jshint']

let g:snips_author="soud"
let g:email="soud@protonmail.com"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" neocomplete
let g:neocomplete#enable_at_startup = 0
" let g:neocomplete#enable_smart_case = 1

" pymode
let g:pymode = 1
let g:pymode_syntax_all = 1
let g:pymode_warnings = 0
let g:pymode_indent = 1
let g:pymode_doc = 1
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_trim_whitespaces = 1
let g:pymode_options_max_line_length = 79
let g:pymode_folding = 0
let g:pymode_lint = 0

" rainbow parentheses
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces

let g:JSLintHighlightErrorLine = 0

let g:gtfo#terminals = { 'unix' : 'urxvt -cd' }
