set vb

set incsearch

autocmd FileType perl set number

set hlsearch

set expandtab

set title

set nu

set wildmenu

set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png " ignore these list file extensions
    set wildmode=list:longest " turn on wild mode huge list
syntax on
set et
set sw=4
set smarttab
set bg=light

" Magic stuff
autocmd BufReadPost svn-commit*.tmp :call Svn_diff()
function! Svn_diff()
    silent exe "normal G"
    silent r!svn diff
    silent exe "1"
endfunction
"special cases regarding tabs
autocmd BufEnter */debian/rules set noet ts=8 sw=8
