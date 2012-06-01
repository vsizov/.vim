let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set nocompatible
set t_Co=256
set background=dark
colorscheme ir_black
filetype on 
filetype plugin indent on
:set mouse=a
compiler ruby
map <Tab> <C-W>W:cd %:p:h<CR>:<CR>
set selectmode=mouse
set mousef

set runtimepath+=/usr/share/vim/addons

set clipboard=autoselect,unnamed,exclude:cons\|linux
set history=10000
set ic   
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nowrap
set showmatch "Show matching brackets
set mat=5     "Bracket blinking
"set list      "Show list of end line

" no ~ backup files
set nobackup
set nowb
set noswapfile

nmap <F2> :w!<CR>
imap <F2> <Esc>:w!<CR>
vmap <F2> <Esc>:w!<CR>

nmap <F10> :q<CR>
imap <F10> <Esc>:q<CR>
vmap <F10> <Esc>:q<CR>

nmap <F11> :q!<CR>
imap <F11> <Esc>:q!<CR>
vmap <F11> <Esc>:q!<CR>

nmap <C-d> :tabnext<CR>
imap <C-d> <ESC>:tabnext<CR>
vmap <C-d> <ESC>:tabnext<CR>

nmap <C-t> :CommandT<CR>
imap <C-d> <ESC>:CommandT<CR>
vmap <C-d> <ESC>:CommandT<CR>

nmap <F8> :NERDTree<CR>
imap <F8> <ESC>:NERDTree<CR>
vmap <F8> <ESC>:NERDTree<CR>

nmap <C-a> :tabprevious<CR>
imap <C-a> <ESC>:tabprevious<CR>
vmap <C-a> <ESC>:tabprevious<CR>

nmap <F7> /
imap <F7> <ESC>/
vmap <F7> <ESC>/

nmap <F9> :nohlsearch<CR>
imap <F9> <Esc>:nohlsearch<CR>
vmap <F9> <Esc>:nohlsearch<CR>

set ai        "Automatically set the indent of a new line
set si        "smartindent

set cursorline
"set cursorcolumn


" Searching *******************************************************************
set hlsearch " highlight search
set incsearch " incremental search, search as you type
set ignorecase " Ignore case when searching
set smartcase " Ignore case when searching lowercase


" Status Line *****************************************************************
set showcmd
set ruler " Show ruler
"set ch=2 " Make command line two lines high

" make p in visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Misc
" ************************************************************************
set backspace=indent,eol,start
set number " Show line numbers
set matchpairs+=<:>
set vb t_vb= " Turn off bell, this could be more annoying, but I'm not sure how

set laststatus=2 "Show status line

syntax on

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
"autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
"autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

" Omni Completion
" *************************************************************
autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
