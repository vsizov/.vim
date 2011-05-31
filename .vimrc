"""""""" Set cursor """"""""""
if has("autocmd")
    au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
    au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
endif
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"""""""""""""""""" end cursor """""""""""
set nocompatible
set t_Co=256
set background=dark
colorscheme railscasts
filetype on 
filetype plugin indent on

compiler ruby
set autochdir
map <Tab> <C-W>W:cd %:p:h<CR>:<CR>
set selectmode=mouse
set mousef
:set mouse=a

set runtimepath+=/usr/share/vim/addons

set clipboard+=unamed  " Yanks go on clipboard instead
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

nmap <F2> :w!<CR>
imap <F2> <Esc>:w!<CR>
vmap <F2> <Esc>:w!<CR>

nmap <F3> :!p4 edit %<CR>
imap <F3> <Esc>:!p4 edit %<CR>
vmap <F3> <Esc>:!p4 edit %<CR>

nmap <F10> :q<CR>
imap <F10> <Esc>:q<CR>
vmap <F10> <Esc>:q<CR>

nmap <F11> :q!<CR>
imap <F11> <Esc>:q!<CR>
vmap <F11> <Esc>:q!<CR>

nmap <F12> :Project<CR><CR>
imap <F12> <ESC>:Project<CR><CR>
vmap <F12> <ESC>:Project<CR><CR>

nmap <C-d> :tabnext<CR>
imap <C-d> <ESC>:tabnext<CR>
vmap <C-d> <ESC>:tabnext<CR>

nmap <C-a> :tabprevious<CR>
imap <C-a> <ESC>:tabprevious<CR>
vmap <C-a> <ESC>:tabprevious<CR>

nmap <F5> :! /export/web/cnuapp/bin/cnu_env spec % --format=specdoc<cr>
imap <F5> <ESC>:! /export/web/cnuapp/bin/cnu_env spec % --format=specdoc<cr>
vmap <F5> <ESC>:! /export/web/cnuapp/bin/cnu_env spec % --format=specdoc<cr>

nmap <F6> :! sudo /export/web/cnuapp/bin/cnu_env cucumber % -r /export/web/stable_pi/cnu_cucumber <cr>
imap <F6> <ESC>:! sudo /export/web/cnuapp/bin/cnu_env cucumber % -r /export/web/stable_pi/cnu_cucumber <cr>
vmap <F6> <ESC>:! sudo /export/web/cnuapp/bin/cnu_env cucumber % -r /export/web/stable_pi/cnu_cucumber <cr>

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
" May require ruby compiled in


function MyTabLine()
  let tabline = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let tabline .= '%#TabLineSel#'
    else
      let tabline .= '%#TabLine#'
    endif
    let tabline .= '%' . (i + 1) . 'T'
    let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
  endfor
  let tabline .= '%#TabLineFill#%T'
  if tabpagenr('$') > 1
    let tabline .= '%=%#TabLine#%999XX'
  endif
  return tabline
endfunction

function MyTabLabel(n)
  let label = ''
  let buflist = tabpagebuflist(a:n)
  let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')
  if label == ''
    let label = '[No Name]'
  endif
  let label .= ' (' . a:n . ')'
  for i in range(len(buflist))
    if getbufvar(buflist[i], "&modified")
      let label = '[+] ' . label
      break
    endif
  endfor
  return label
endfunction

function MyGuiTabLabel()
  return '%{MyTabLabel(' . tabpagenr() . ')}'
endfunction

set tabline=%!MyTabLine()
set guitablabel=%!MyGuiTabLabel()

map <SID>xx <SID>xx
let s:sid = maparg("<SID>xx")
unmap <SID>xx
let s:sid = substitute(s:sid, 'xx', '', '')

"{{{ FoldText
function! s:Num2S(num, len)
    let filler = "                                                            "
    let text = '' . a:num
    return strpart(filler, 1, a:len - strlen(text)) . text
endfunction

execute 'set foldtext=' .  s:sid . 'MyNewFoldText()'
function! <SID>MyNewFoldText()
  let linenum = v:foldstart
  while linenum <= v:foldend
      let line = getline(linenum)
      if !exists("b:foldsearchprefix") || match(line, b:foldsearchprefix) == -1
    break
      else
    let linenum = linenum + 1
      endif
  endwhile
  if exists("b:foldsearchprefix") && match(line, b:foldsearchprefix) != -1
      " all lines matched the prefix regexp
      let line = getline(v:foldstart)
  endif
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  let diff = v:foldend - v:foldstart + 1
  return  '+ [' . s:Num2S(diff,4) . ']' . sub
endfunction

function! Foldsearch(search)
  setlocal fdm=manual
  let origlineno = line(".")
  normal zE
  normal G$
  let folded = 0     "flag to set when a fold is found
  let flags = "w"    "allow wrapping in the search
  let line1 =  0     "set marker for beginning of fold
  if a:search == ""
      if exists("b:foldsearchexpr")
    let searchre = b:foldsearchexpr
      else
    "Default value, suitable for Ruby scripts
    "\(^\s*\(\(def\|class\|module\)\s\)\)\|^\s*[#%"0-9]\{0,4\}\s*{\({{\|!!\)
    let searchre = '\v(^\s*(def|class|module|attr_reader|attr_accessor|alias_method)\s' .
                 \ '|^\s*\w+attr_(reader|accessor)\s|^\s*[#%"0-9]{0,4}\s*\{(\{\{|!!))' .
                 \ '|^\s*[A-Z]\w+\s*\='
    let b:foldsearchexpr = searchre
      endif
  else
      let searchre = a:search
  endif
  while search(searchre, flags) > 0
    let  line2 = line(".")
    while line2 - 1 >= line1 && line2 - 1 > 0 "sanity check
       let prevline = getline(line2 - 1)
       if exists("b:foldsearchprefix") && (match(prevline, b:foldsearchprefix) != -1)
           let line2 = line2 - 1
       else
           break
       endif
    endwhile
    if (line2 -1 >= line1)
      execute ":" . line1 . "," . (line2-1) . "fold"
      let folded = 1       "at least one fold has been found
    endif
    let line1 = line2     "update marker
    let flags = "W"       "turn off wrapping
  endwhile
  normal $G
  let  line2 = line(".")
  if (line2  >= line1 && folded == 1)
    execute ":". line1 . "," . line2 . "fold"
  endif
  execute "normal " . origlineno . "G"
endfunction

"{{{~folds Fold Patterns
" Command is executed as ':Fs pattern'"
command! -nargs=? -complete=command Fs call Foldsearch(<q-args>)
command! -nargs=? -complete=command Fold call Foldsearch(<q-args>)
"command! R Fs \(^\s*\(\(def\|class\|module\)\s\)\)\|^\s*[#%"0-9]\{0,4\}\s*{\({{\|!!\)
command! R Fs

