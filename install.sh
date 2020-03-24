#!/bin/bash

ZSH_DOTFILES="$HOME/.dotfiles/zsh"
echo "setting up directories in zsh dotfiles: $ZSH_DOTFILES"
mkdir -p "$ZSH_DOTFILES/oh-my-zsh-custom/themes";
mkdir -p "$ZSH_DOTFILES/oh-my-zsh-custom/plugins";

##oh my zsh
echo "$HOME/.oh-my-zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Setting up oh my zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended;
else
    echo "oh-my-zsh already exist. Skipping"
fi

if [ ! -f "$HOME/.zshrc" ]; then
    echo "Creating default .zshrc"
    cp "$ZSH_DOTFILES/local_zshrc.zsh" "$HOME/.zshrc";
else
    echo ".zshrc already exist. Skipping"
fi

#spaceship prompt
if [ ! -f "$ZSH_DOTFILES/oh-my-zsh-custom/themes/spaceship.zsh-theme" ]; then
    echo "setting up spaceship theme for oh my zsh"
    git clone https://github.com/denysdovhan/spaceship-prompt.git ~/.dotfiles/zsh/spaceship-prompt;
    ln -s "$ZSH_DOTFILES/spaceship-prompt/spaceship.zsh-theme" "$ZSH_DOTFILES/oh-my-zsh-custom/themes/spaceship.zsh-theme";
else
    echo "Spaceship already exists. Skipping"
fi

#zsh-autosuggestions
if [ ! -d "$ZSH_DOTFILES/oh-my-zsh-custom/plugins/zsh-autosuggestions" ]; then
    echo "setting up zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.dotfiles/zsh/oh-my-zsh-custom/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions already exist. skipping"
fi


# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# cd $DIR
# git submodule init
# git submodule update

# git submodule foreach git reset --hard
