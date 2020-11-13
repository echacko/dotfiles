#! /bin/bash
#
# Script to extract file


if [ -f $1 ] ; then 
    case $1 in
        *.tar.bz2)   tar xjvf $1    ;;
        *.tar.gz)    tar xzvf $1    ;;
        *.tar.xz)    tar xvJf $1    ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xvf $1     ;;
        *.tbz2)      tar xjvf $1    ;;
        *.tgz)       tar xzvf $1    ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
else
    echo "'$1' is not a valid file"
fi
