let mapleader = " "
inoremap jk <ESC>
inoremap hh <ESC>
set surround
set multiple-cursors
set commentary
set argtextobj
set ReplaceWithRegister
set highlightedyank
set exchange
set NERDTree
set sneak

set which-key
set notimeout

set nu
set rnu
set clipboard+=ideaput
set idearefactormode=visual
set showmode
set incsearch
set hlsearch
set ignorecase
set smartcase
set clipboard+=unnamed

source ~/.ideavim/modules/code.vim
source ~/.ideavim/modules/file.vim
source ~/.ideavim/modules/project.vim
source ~/.ideavim/modules/search.vim
source ~/.ideavim/modules/navigation.vim
source ~/.ideavim/modules/run.vim
source ~/.ideavim/modules/idea.vim
source ~/.ideavim/modules/git.vim
source ~/.ideavim/modules/buffer.vim
source ~/.ideavim/modules/errors.vim
source ~/.ideavim/modules/window.vim
source ~/.ideavim/modules/open.vim


nmap <leader>hr :source ~/.ideavimrc <cr>
