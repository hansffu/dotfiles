export DOTFILES_DIR="$HOME/.dotfiles/"

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
DEFAULT_USER="hansffu"

SPACESHIP_BATTERY_SHOW=always
SPACESHIP_ELM_SHOW=true
ZSH_THEME="spaceship"


if [ -f "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# export ZSH_CUSTOM=~/.dotfiles/zsh/oh-my-zsh-custom

# Node version manager
[ -d "/usr/share/nvm" ] && source /usr/share/nvm/init-nvm.sh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  git-extras
  archlinux
  cp
  colored-man-pages
  colorize
  docker
  gradle
  npm
  yarn
  web-search
  adb
  brew
  macos
  vscode
  mvn
  # vi-mode
  # zsh-autosuggestions
)

export LSP_USE_PLISTS=true

source $ZSH/oh-my-zsh.sh

#alias ls='colorls'
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='emacs -nw'
else
  export EDITOR='emacsclient -n'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias laws="aws --endpoint-url=http://localhost:4566 --region=eu-west-1"

export TERM="xterm-256color"


#PATH="$PATH:/home/hansffu/Android/Sdk/platform-tools/"
#PATH=$HOME/.cabal/bin:$HOME/.local/bin:/home/hansffu/Android/Sdk/platform-tools/:$HOME/.gem/ruby/2.6.0/bin:$PATH
LOCAL_PATH="$HOME/.scripts/jetbrains:$HOME/.emacs.d/bin"

PATH=$LOCAL_PATH:$HOME/.yarn/bin:$PATH

# terminalName=`basename "/"$(ps -f -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/^.* //')`
# if [ $terminalName = "drop-down-terminal@gs-extensions.zzrough.org" ]
# then
#     tmux
# fi

#export ZSH_TMUX_AUTOSTART=true

#Lastpass timeout
export LPASS_AGENT_TIMEOUT=0

#VI-MODE
bindkey -M viins 'jk' vi-cmd-mode


#source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
alias magit="i3-swallow emacsclient -c -e \(magit-status\)"
alias e="emacsclient -n"
export EDITOR='emacsclient -n'

[ -s "$HOME/.jabba/jabba.sh" ] && source "$HOME/.jabba/jabba.sh"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Howdy - disable debug log
export OPENCV_LOG_LEVEL=ERROR


[ -f "/home/hansffu/.ghcup/env" ] && source "/home/hansffu/.ghcup/env" # ghcup-env

###VTERM###
if [[ "$INSIDE_EMACS" = "vterm" ]]; then
  vterm_printf(){
      if [ -n "$TMUX" ]; then
          # Tell tmux to pass the escape sequences through
          # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
          printf "\ePtmux;\e\e]%s\007\e\\" "$1"
      elif [ "${TERM%%-*}" = "screen" ]; then
          # GNU screen (screen, screen-256color, screen-256color-bce)
          printf "\eP\e]%s\007\e\\" "$1"
      else
          printf "\e]%s\e\\" "$1"
      fi
  }

  alias ff="find_file"

  vterm_cmd() {
      local vterm_elisp
      vterm_elisp=""
      while [ $# -gt 0 ]; do
          vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
          shift
      done
      vterm_printf "51;E$vterm_elisp"
  }

  find_file() {
      vterm_cmd find-file "$(realpath "$@")"
  }

  rn() {
    vterm_cmd rename-buffer "vterm: $1"
  }

  autoload -U add-zsh-hook
  add-zsh-hook -Uz chpwd (){ print -Pn "\e]2;%2~\a" }


  vterm_prompt_end() {
      vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
  }
  setopt PROMPT_SUBST
  PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

fi
