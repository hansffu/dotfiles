" Split below/right
nnoremap <leader>ws :action SplitHorizontally<cr>
nnoremap <leader>wv :action SplitVertically<cr>

" Close window
nnoremap <leader>wd :action Unsplit<cr>

" Focus window left
nnoremap <leader>wh         <C-w>h
nnoremap <leader>w<Left>    <C-w>h

" Focus window down
nnoremap <leader>wj         <C-w>j
nnoremap <leader>w<Down>    <C-w>j

" Focus window up
nnoremap <leader>wk       <C-w>k
nnoremap <leader>w<Up>    <C-w>k

" Focus window right
nnoremap <leader>wl          <C-w>l
nnoremap <leader>w<Right>    <C-w>l

" Focus next window
nnoremap <leader>ww    :action NextSplitter<CR>
