#!/usr/bin/bash

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=10000
# HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    if [[ -r ~/.dircolors ]]
    then
      eval "$(dircolors -b ~/.dircolors)"
    else
      eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

## 20201202

HISTTIMEFORMAT='%Y-%m-%dT%T%z '
export HISTCONTROL=ignoredups
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=20000
export HISTFILESIZE=20000

export PATH="$HOME/.local/bin:$HOME/bin:$PATH:./vendor/bin:$HOME/node_modules/.bin"
export PATH="$HOME/.anyenv/bin:$PATH"

# shellcheck disable=SC1090
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

alias gf='git foresta'
alias gfh='git foresta | head'
alias relogin='exec $SHELL -l'

# [「Git補完をしらない」「git statusを1日100回は使う」そんなあなたに朗報【git-completionとgit-prompt】 - Qiita](https://qiita.com/varmil/items/9b0aeafa85975474e9b6 "「Git補完をしらない」「git statusを1日100回は使う」そんなあなたに朗報【git-completionとgit-prompt】 - Qiita")
# shellcheck disable=SC1090
[ -f ~/bin/.git-completion.bash ] && source ~/bin/.git-completion.bash
# shellcheck disable=SC1090
[ -f ~/bin/.git-prompt.sh ] && source ~/bin/.git-prompt.sh
# プロンプトに各種情報を表示
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=1
EIF=$(for DEV in $(find /sys/devices -name net 2>/dev/null | grep -v virtual); do ls "$DEV"/; done | head -1)
export EIF
IP=$(ip addr show dev "$EIF" | grep "inet " | cut -d" " -f6)
export IP
export PS1='\[\033[1;32m\]\u@\h:$IP\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '
[[ $(type -P anyenv) ]] && eval "$(anyenv init -)"
[[ $(type -P gh) ]] && eval "$(gh completion -s bash)"
export LESS=-FINMRX

function svg2png {
  fn=$1;
  if [ -f "$fn" ]; then
    # inkscape -z -e "$(${fn}|sed 's/\.[^\.]*$//').png" -h 1024 "$fn"
    inkscape -z -e "$(${fn}|sed 's/\.[^\.]*$//').png" "$fn"
  else
    echo "$fn not found."
  fi
}
# time svg2png wk/Challenge_of_Amaterashu_and_Susanoo.sv
# time svg2png wk/Challenge_of_Amaterashu_and_Susanoo.svg
