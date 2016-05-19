"******************************************************************************
" basic settings
"******************************************************************************
syntax enable
filetype plugin indent on

set t_Co=256
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
set number
set ttyfast
set lazyredraw
set showcmd
set softtabstop=4
set backspace=eol,start,indent
set colorcolumn=80
set sj=-50
set cursorline
set title
set autoread
set completeopt=longest,menuone
set timeoutlen=500
set laststatus=2

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
set wildignore+=*/.bundle/*,*/.sass-cache/*
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/node_modules,*/.vagrant,*/vendor

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

colorscheme tnight
let &titleold=getcwd()

"******************************************************************************
" auto commands
"******************************************************************************

" enable rainbow parentheses when writing lisp.
au VimEnter *.l,*.cl,*.lsp,*.lisp RainbowParenthesesToggle
au Syntax *.l,*.cl,*.lsp,*.lisp   RainbowParenthesesLoadRound
au Syntax *.l,*.cl,*.lsp,*.lisp   RainbowParenthesesLoadSquare
au Syntax *.l,*.cl,*.lsp,*.lisp   RainbowParenthesesLoadBraces

au BufRead,BufNewFile *.l,*.cl,*.lsp,*.lisp set softtabstop=2 shiftwidth=2

" tabs for makefiles
au FileType make setlocal noexpandtab

au FileType php,vim set nocursorline norelativenumber

au! FileType css,scss setlocal iskeyword+=-

" automatically source vimrc on save.
au! bufwritepost $MYVIMRC source $MYVIMRC

" return to last edit position when opening file
au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" highlighting
au BufNewFile,BufRead *.md set ft=markdown spell

" recalculate trailing white space indicater when idle and after saving
augroup statline_trail
  autocmd!
  autocmd cursorhold,bufwritepost * unlet! b:statline_trailing_space_warning
augroup END

"******************************************************************************
" functions
"******************************************************************************

function! TrailingSpaceWarning()
    if !exists("b:statline_trailing_space_warning")
        let lineno = search('\s$', 'nw')
        if lineno != 0
            let b:statline_trailing_space_warning = '[trailing:'.lineno.']'
        else
            let b:statline_trailing_space_warning = ''
        endif
    endif
    return b:statline_trailing_space_warning
endfunction

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

inoremap <expr> <tab> InsertTabWrapper()

inoremap <silent>j <C-R>=OmniPopup('j')<CR>
inoremap <silent>k <C-R>=OmniPopup('k')<CR>

" maps
noremap 0 ^
noremap ^ 0
map Y y$
nnoremap Z :bprev<cr>
nnoremap X :bnext<cr>
nnoremap <M-Z> :tabprev<cr>
nnoremap <M-X> :tabnext<cr>
imap <C-BS> <C-W>
noremap <Leader>q :bw!<cr>

" switch to pwd
map <leader>cd :cd %:p:h<cr>:pwd<cr>

map <C-k> ddkP
map <C-j> ddp

" emacs binds in insert mode
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$

" toggle spell check
nnoremap <Leader>sc :setlocal spell!<cr>

" tabular
nnoremap <Leader>t :Tab /=<cr>

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

" reset hightlighted text
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

" switch through windows with tab and shift tab
nmap <Tab> <C-W>w
nmap <S-Tab> <C-W>W

"******************************************************************************
" plugins settins
"******************************************************************************

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_regexp = 1
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" space after comment
let NERDSpaceDelims=1

" ultisnips
let g:UltiSnipsExpandTrigger = "<c-@>"
let g:UltiSnipsJumpForwardTrigger = "<c-n>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"

let g:email = "soud@protonmail.com"

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

let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

" highlight trailing whitespace
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" go
let g:go_fmt_command = "goimports"

" rainbow parentheses
let g:rbpt_colorpairs = [
    \ ['darkred',     'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ]

" statusbar
hi clear StatusLine
hi clear StatusLineNC
hi StatusLine   term=bold cterm=bold ctermfg=White ctermbg=8

" highlight values in statusbar
hi User1                      ctermfg=4  ctermbg=8 " Identifier
hi User2 cterm=bold           ctermfg=2  ctermbg=8 " Statement
hi User3 term=bold cterm=bold ctermfg=1  ctermbg=8 " Error
hi User4                      ctermfg=1  ctermbg=8 " Special
hi User5                      ctermfg=10 ctermbg=8 " Comment
hi User6 term=bold cterm=bold ctermfg=1  ctermbg=8 " WarningMsg

set statusline=
set statusline+=%6*%m%r%*                          " modified, readonly
set statusline+=\ 
set statusline+=%5*%{expand('%:h')}/               " relative path to file's directory
set statusline+=%1*%t%*                            " file name
set statusline+=\ 
set statusline+=%=                                 " switch to RHS

set statusline+=\ 
set statusline+=\ 
set statusline+=%5*%L\ lines%*                     " number of lines
set statusline+=\ 
set statusline+=%3*%{TrailingSpaceWarning()}%*     " trailing whitespace
set statusline+=\ 
