"
" Vundle
"
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tinted-theming/tinted-vim'
Plugin 'scrooloose/nerdtree'
call vundle#end()            " required
filetype plugin indent on    " required

"
" Defaults
"
syntax on
set hlsearch
let mapleader=','

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

"
" Mapping
"
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
map <leader>q :wqall<CR>
imap <leader>q <C-[>:wqall<CR>
map <leader>w :w<CR>
imap <leader>w <C-o>:w<CR>
" Folding
map <leader>f za
imap <leader>f <C-o>za
map <leader>F zR
imap <leader>F <C-o>zR
