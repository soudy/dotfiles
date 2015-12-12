"******************************************************************************
" basic settings
"******************************************************************************

syntax enable
filetype plugin indent on

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
set completeopt=longest,menuone
set timeoutlen=500

" wildmenu
set wildmenu
set wildmode=list:longest,full
set wildignore+=.hg,.git,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest
set wildignore+=*.spl
set wildignore+=*.sw?
set wildignore+=*.DS_Store
set wildignore+=*.luac
set wildignore+=migrations
set wildignore+=*.pyc
set wildignore+=*.orig
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=node_modules/*

" new splits default to right, or below
set splitbelow
set splitright

set nowrap
set nopaste
set textwidth=80
set formatoptions=trqlcj

" handle swp files
set directory=~/.vim/swap,~/tmp,.
set noswapfile

"backup
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" use system clipboard by default
set clipboard=unnamed

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

" enable pathogen
call pathogen#infect()

colorscheme dc2
let &titleold=getcwd()

"******************************************************************************
" auto commands
"******************************************************************************

" tabs for makefiles
au FileType make setlocal noexpandtab

au FileType php set nocursorline norelativenumber

au! FileType css,scss setlocal iskeyword+=-

" Automatically source vimrc on save.
au! bufwritepost $MYVIMRC source $MYVIMRC

" return to last edit position when opening file
au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" highlighting
au BufNewFile,BufRead *.json set ft=javascript
au BufNewFile,BufRead *.md set ft=markdown spell

"******************************************************************************
" functions
"******************************************************************************

" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

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

"******************************************************************************
" mappings
"******************************************************************************

let mapleader = "\<Space>"

inoremap <silent>j <C-R>=OmniPopup('j')<CR>
inoremap <silent>k <C-R>=OmniPopup('k')<CR>

inoremap <expr> <tab> InsertTabWrapper()

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
nnoremap <Leader>p "*p

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

" remove ^M
noremap <Leader>m :%s/<C-V><C-M>//g<cr>
"
" remove trailing whitespace
nnoremap <Leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<cr>

" open header file
nnoremap <F4> :AS<cr>

" disable Ex and encryption
command! W :w
command! Q :q

" http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev X <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'x' : 'X')<cr>

" fix common mistypes
cnoremap ww w
cnoremap wW w
cnoremap Ww w

" don't save files named :, ; or )
cnoremap w; w
cnoremap W; w
cnoremap x; x
cnoremap X; x
cnoremap w: w
cnoremap W: w
cnoremap x: x
cnoremap X: x
cnoremap w) w
cnoremap W) w
cnoremap x) x
cnoremap X) x

"******************************************************************************
" plugins settins
"******************************************************************************

" space after comment
let NERDSpaceDelims=1

" powerline
set laststatus=2
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" syntastic
let g:syntastic_mode_map = { 'passive_filetypes': ['c', 'go'] }
let g:syntastic_cpp_compiler_options = " -std=c++11"
let g:syntastic_javascript_checkers = ['jshint']

let g:email="soud@protonmail.com"
"
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
