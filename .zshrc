export DOTFILES_DIR="$HOME/.dotfiles/"

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
ZSH_THEME="spaceship"
DEFAULT_USER="hansffu"

SPACESHIP_BATTERY_SHOW=always
SPACESHIP_ELM_SHOW=true

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
export ZSH_CUSTOM=~/.dotfiles/zsh/oh-my-zsh-custom

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
  tmux
  yarn
  web-search
  adb
  brew
  osx
  vscode
  mvn
  vi-mode
  zsh-autosuggestions
)

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
  export EDITOR='emacsclient -n -c -a "emacs"'
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

PATH=$LOCAL_PATH:$HOME/.dotfiles/utils/bin:$HOME/.dotfiles/macos/scripts:$HOME/.yarn/bin:$PATH

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
alias e="emacsclient -n -c -a \"emacs\""
export EDITOR='emacsclient -n -c -a "emacs"'

[ -s "$HOME/.jabba/jabba.sh" ] && source "$HOME/.jabba/jabba.sh"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

  vterm_prompt_end() {
      vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
  }
  setopt PROMPT_SUBST
  PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

  alias ff="find_file"
fi

# Howdy - disable debug log
export OPENCV_LOG_LEVEL=ERROR
