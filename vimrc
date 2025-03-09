"
" Vundle
"
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tinted-theming/tinted-vim'
Plugin 'preservim/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'sheerun/vim-polyglot'
call vundle#end()            " required
filetype plugin indent on    " required


"
" Defaults
"
syntax on
set hlsearch
set incsearch
let mapleader=','
set wildignore=.git,.next,node_modules,__pycache__,.build,.cache,compile_commands.json,*.db,*.o
autocmd FileType * setlocal ts=2 sts=2 sw=2 expandtab smartindent cindent
autocmd FileType markdown setlocal spell spelllang=en,cjk
autocmd FileType c setlocal noexpandtab cc=80
autocmd FileType cpp setlocal noexpandtab cc=80
autocmd FileType make setlocal noexpandtab cc=80
autocmd BufRead,BufNewFIle *.S setlocal filetype=asm
autocmd BufRead,BufNewFIle *.s setlocal filetype=asm
set autowriteall
autocmd BufLeave * if &filetype != 'nerdtree' && &modifiable && argc() != 0 | silent! w | endif
set backspace=indent,eol,start


"
" Lists
"
let g:location_list_open = 0
let g:quickfix_list_open = 0
function! ToggleList(pfx)
  if a:pfx == 'l'
    if g:location_list_open
      lclose
      let g:location_list_open = 0
    else
      lopen
      wincmd J
      8wincmd _
      wincmd p
      let g:location_list_open = 1
    endif
  elseif a:pfx == 'c'
    if g:quickfix_list_open
      cclose
      let g:quickfix_list_open = 0
    else
      copen
      wincmd K
      8wincmd _
      wincmd p
      let g:quickfix_list_open = 1
    endif
  endif
endfunction
map <leader>l :call ToggleList('c')<CR>
imap <leader>l <C-o>:call ToggleList('c')<CR>
map <leader>L :call ToggleList('l')<CR>
imap <leader>L <C-o>:call ToggleList('l')<CR>

function! LocationListHandler()
  let l:is_empty = empty(getloclist(0))
  if l:is_empty && g:location_list_open
    lclose
    let g:location_list_open = 0
  elseif !l:is_empty && !g:location_list_open
    lopen
    8wincmd _
    wincmd p
    let g:location_list_open = 1
  endif
endfunction
autocmd CursorHold,CursorHoldI * call LocationListHandler()


"
" Colours
"
if filereadable(expand("$HOME/.config/tinted-theming/set_theme.vim"))
	let base16_colorspace=256
	let base16colorspace=256
	let tinted_colorspace=256
	source $HOME/.config/tinted-theming/set_theme.vim
endif


"
" Nerdtree
"
map <leader><Space> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeShowHidden=1
let g:NERDTreeMapOpenExpl=''
let g:NERDTreeMapOpenSplit=''
let g:NERDTreeMapOpenVSplit=''
let g:NERDTreeMenuUp='s'
let g:NERDTreeMenuDown='r'
let g:NERDTreeMapRefresh='a'
let g:NERDTreeMapCustomOpen='t'
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


"
" Airline
"
let g:airline#extensions#tabline#enabled = 1


"
" YCM
"
map <leader>a :YcmCompleter GoToAlternateFile<CR>
imap <leader>A <C-o>:YcmCompleter GoToAlternateFile<CR>
map <leader>r :YcmCompleter GoToReferences<CR>
imap <leader>r <C-o>:YcmCompleter GoToReferences<CR>
map <leader>g :YcmCompleter GoTo<CR>
imap <leader>g <C-o>:YcmCompleter GoTo<CR>
map <leader>o <Plug>(YCMFindSymbolInWorkspace)
imap <leader>o <C-o><Plug>(YCMFindSymbolInWorkspace)
let g:ycm_autoclose_preview_window_after_completion = 1
" Auto location list
let g:ycm_always_populate_location_list = 1


"
" Mapping
"
" colemak
noremap a h
noremap A b
noremap r j
noremap R J
noremap s k
noremap t l
noremap T w
noremap e a
noremap E A
noremap O R
" Window
map <leader>q :wqall<CR>
imap <leader>q <C-[>:wqall<CR>
map <leader>w :w<CR>
imap <leader>w <C-o>:w<CR>
map <leader>C <C-w>c
imap <leader>C <C-w>c
map <leader>s :split<CR>
imap <leader>s <C-o>:split<CR>
map <leader>S :vsplit<CR>
imap <leader>S <C-o>:vsplit<CR>
" Folding
map <leader>f za
imap <leader>f <C-o>za
map <leader>F zR
imap <leader>F <C-o>zR
" Buffer
map <leader>c :bd<CR>
imap <leader>c <C-[>:bd<CR>
map <leader>h :bprevious<CR>
imap <leader>h <C-o>:bprevious<CR>
map <leader>. :bnext<CR>
imap <leader>. <C-o>:bnext<CR>
" Cursor
map <leader><Left> <C-w>h
imap <leader><Left> <C-w>h
map <leader><Right> <C-w>l
imap <leader><Right> <C-w>l
map <leader><Up> <C-w>k
imap <leader><Up> <C-w>k
map <leader><Down> <C-w>j
imap <leader><Down> <C-w>j
map <PageUp> <C-u>
map <PageDown> <C-d>
" Sizing
map <leader>+ <C-w>5+
imap <leader>+ <C-w>5+
map <leader>- <C-w>5-
imap <leader>- <C-w>5-
map <leader>< <C-w>5<
imap <leader>< <C-w>5<
map <leader>> <C-w>5>
imap <leader>> <C-w>5>
map <leader>= <C-w>=
imap <leader>= <C-w>=
map <leader>_ <c-w>_
imap <leader>_ <c-w>_
map <leader>\| <c-w>\|
imap <leader>\| <c-w>\|
" Etc
map <leader>m :noh<CR>
imap <leader>m <C-o>:noh<CR>
map <leader>n :cn<CR>
imap <leader>n <C-o>:cn<CR>
map <leader>p :cp<CR>
imap <leader>p <C-o>:cp<CR>
map <leader>z <C-o>
imap <leader>z <C-o><C-o>
