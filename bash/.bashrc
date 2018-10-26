# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

export EDITOR='vim'
export VISUAL='vim'
export SPELL='aspell'

#Source the autojump file
if [ -f /usr/share/autojump/autojump.bash ]; then
    source /usr/share/autojump/autojump.bash
fi

## Prompt
#
COLV="\[\033[0;32m\]" # Verde
COLC="\[\033[0;36m\]" # Cyan
COLA="\[\033[0;33m\]" # Amarillo
COLB="\[\033[0;34m\]" # Blue
COLP="\[\033[0;35m\]" # Purple
COLR="\[\033[0;31m\]" # Rojo
COLN="\[\033[0m\]"	  # Reset

COL="$COLC"						# Regular user
[[ "$UID" = "0" ]] && COL=$COLR	# Root

# Add car return and change the title of the window to the current P1
function __promptadd
{
    XTITLE='\[\e]0;\s (\w)\a\]'
    PS1="$XTITLE$PS1\n$COL \\$ $COLN"
}

function prompt_line
{
    source ~/.shell_prompt.sh
    PROMPT_COMMAND="$PROMPT_COMMAND __promptadd;"
}

function prompt_term
{
    # GIT vars
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="auto"

    if [ -f ~/.bash_git ]; then
        source ~/.bash_git
    fi

    # Prompt
    PROMPT_COMMAND=""
    PS1="$COLV--[$COLC\h$COLV]-[$COLA\w$COLV]\$(__git_ps1)\n$COL \\$ $COLN"
}

# Add the new prompt
case "$TERM" in
    rxvt* | *-256color | xterm-termite)
        prompt_line
        ;;
    *)
        prompt_term
        ;;
esac

# Colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
export LS_OPTIONS='--color=auto'
alias l='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l -N -hF'
alias ls='ls $LS_OPTIONS -N -hF'

alias grep='grep --color=auto'
export LESS="-R"

# lesspip
if [ -x /usr/bin/lesspipe ]; then
    eval "$(lesspipe)"
fi


## Aliases
#

alias vi="vim --servername=VIM"
alias v="vim --servername=VIM"
alias chromeOverTor='chromium --proxy-server="socks://127.0.0.1:9050"'
alias ssh="ssh -Y"
alias vi="vim"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias sudo='sudo '
alias h='history'
alias ..='cd ..'
alias cd..='cd ..'
alias df='df -h'
alias xo='~/Scripts/xo.sh '
alias aa="source ~/anaconda3/bin/activate"
alias activate_proxy="source ~/Scripts/activate_proxy.sh"
alias deactivate_proxy="source ~/Scripts/deactivate_proxy.sh"
alias extract='~/Scripts/extract.sh'
alias convert-to-pdf="libreoffice --headless --convert-to pdf "
