#!/bin/bash

ZSH_DOTFILES="$HOME/.dotfiles/zsh"
echo "setting up directories in zsh dotfiles: $ZSH_DOTFILES"
mkdir -p "$ZSH_DOTFILES/oh-my-zsh-custom/themes";

##oh my zsh
echo "Setting up oh my zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended;
cp "$ZSH_DOTFILES/local_zshrc.zsh" "$HOME/.zshrc";

#spaceship prompt
echo "setting up spaceship theme for oh my zsh"
git clone https://github.com/denysdovhan/spaceship-prompt.git ~/.dotfiles/zsh/spaceship-prompt;
ln -s "$ZSH_DOTFILES/spaceship-prompt/spaceship.zsh-theme" "$ZSH_DOTFILES/oh-my-zsh-custom/themes/spaceship.zsh-theme";

# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# cd $DIR
# git submodule init
# git submodule update

# git submodule foreach git reset --hard
