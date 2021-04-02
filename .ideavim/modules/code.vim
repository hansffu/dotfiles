"jump to x
nmap <leader>cd    :action GotoDeclaration<CR>
nmap <leader>ci    :action GotoImplementation<CR>
nmap <leader>cD    :action ShowUsages<CR>

nmap <leader>cr    :action RenameElement<CR>
nmap <leader>cR    :action RenameElement<CR>
nmap <leader>cf    :action ReformatCode<CR>
nmap <leader>cp    :action ReformatWithPrettierAction<CR>
nmap <leader>cr    :action RenameElement<CR>
nmap <leader>co    :action OptimizeImports<cr>

nmap <leader>clrev :action IntroduceVariable<CR>


nmap <leader>ca <Action>(ShowIntentionActions)
