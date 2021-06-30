syntax on
" autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set autoindent
set expandtab
set sts=2 ts=2 shiftwidth=2

"""" NERDTree
map <C-n> :NERDTreeToggle<CR>
" Auto-close if only nerdtree is left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
