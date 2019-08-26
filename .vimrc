set incsearch

autocmd FileType perl set number

set hlsearch

set title

set wildmenu

set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png " ignore these list file extensions
    set wildmode=list:longest " turn on wild mode huge list
syntax on

set ts=2
set sw=4
set bg=light

" Magic stuff
autocmd FileType make setlocal noexpandtab
autocmd BufReadPost svn-commit*.tmp :call Svn_diff()
function! Svn_diff()
    silent exe "normal G"
    silent r!svn diff
    silent exe "1"
endfunction
"special cases regarding tabs
autocmd BufEnter */debian/rules set noet ts=8 sw=8

"whitspaces and tabs in red.
autocmd VimEnter * :call matchadd('Error', '\s\+$', -1) | call matchadd('Error', '\%u00A0')

"set mouse=a

if empty(glob('~/.vim/autoload/plug.vim'))
		  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
			    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
			  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
		endif

call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'w0rp/ale'
Plug 'dense-analysis/ale'
call plug#end()

