" Git checkout
nnoremap <leader>gb    :action Git.Branches<CR>
vnoremap <leader>gb    :action Git.Branches<CR>

" Show Version control tool window
nnoremap <leader>gG    :action ActivateVersionControlToolWindow<CR>
vnoremap <leader>gG    :action ActivateVersionControlToolWindow<CR>

" Select a VCS operation
nnoremap <leader>gg    :action Vcs.QuickListPopupAction<CR>
vnoremap <leader>gg    :action Vcs.QuickListPopupAction<CR>

" blame
nnoremap <leader>gB    :action Annotate<CR>
