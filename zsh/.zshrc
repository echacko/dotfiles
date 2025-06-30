# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Profiling 
# zmodload zsh/zprof

# Path to your oh-my-zsh installation.
export ZSH="/Users/ebin/.oh-my-zsh/"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"
SPACESHIP_ASYNC_SHOW_COUNT=true

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux fzf fast-syntax-highlighting zsh-autosuggestions)


# Tmux integration for iTerm2
# Set '-CC' option for iTerm2 tmux integration
ZSH_TMUX_ITERM2=1

# Load homebrew, so that the PATH has brew kegs.
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo '[oh-my-zsh] homebrew not found, please install it from https://brew.sh'
fi

source $ZSH/oh-my-zsh.sh

if (( $+commands[zoxide] )); then
  eval "$(zoxide init --cmd j zsh)"
else
  echo '[oh-my-zsh] zoxide not found, please install it from https://github.com/ajeetdsouza/zoxide'
fi

# User configuration

# FZF
if [ -x /opt/homebrew/bin/fzf ]; then
  source <(fzf --zsh)
else
  echo '[oh-my-zsh] fzf not found, please install it from https://github.com/junegunn/fzz'
fi

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Use lsd if installed insted of lsd
export LS_OPTIONS='--color=auto'
if [ -x /usr/bin/lsd ] || [ -x /opt/homebrew/bin/lsd ]; then
  alias l='lsd $LS_OPTIONS'
  alias ll='lsd $LS_OPTIONS -lrt -hF'
  alias ls='lsd $LS_OPTIONS -hF'
  alias lsl='lsd $LS_OPTIONS -l -hF'
else
  alias l='ls $LS_OPTIONS'
  alias ll='ls $LS_OPTIONS -l -N -hF'
  alias ls='ls $LS_OPTIONS -N -hF'
  alias lsl='lsd $LS_OPTIONS -l -hF'
fi
alias grep='grep --color=auto'
export LESS="-R"

# lesspip
if [ -x /usr/bin/lesspipe ]; then
    eval "$(lesspipe)"
fi

# History ignore
HISTORY_IGNORE="(ls|ll|pwd|exit|cd ..|clear)"

# For calculation in terminal, use python
function = 
{
  python <<EOF
from math import *
print(eval("$*"))
EOF
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias vi="nvim"
alias chromeOverTor='chromium --proxy-server="socks://127.0.0.1:9050"'
alias ssh="ssh -Y"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias h='history'
alias ..='cd ..'
alias cd..='cd ..'
alias df='df -h'
alias xo='~/dotfiles/Scripts/Scripts/xo.sh '
alias a="export XLA_FLAGS=--xla_gpu_cuda_data_dir=/opt/cuda && source ~/anaconda3/bin/activate"
alias activate_conda="source ~/anaconda3/bin/activate"
alias activate_proxy="source ~/Scripts/activate_proxy.sh"
alias deactivate_proxy="source ~/Scripts/deactivate_proxy.sh"
alias extract='~/dotfiles/Scripts/Scripts/extract.sh'
alias convert-to-pdf="libreoffice --headless --convert-to pdf "
alias calc="="
alias cat=bat
alias ran1_download="python ~/dotfiles/Scripts/Scripts/ran1_download.py "
alias convert-and-save="bash ~/dotfiles/Scripts/Scripts/convert_and_save.sh "
alias ssh-iitb-tunnel="ssh -C -L 8080:localhost:8080 echacko@www.ee.iitb.ac.in"

# Profiling 
# zprof
