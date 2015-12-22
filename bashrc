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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

############################################################
# check OS
_uname=$(uname);

if [ $_uname = 'Linux' ];then 
    _os='linux'
elif [ $_uname = 'Darwin' ]; then
    _os='osx'
else
    echo "No support for your OS.";
    exit;
fi
############################################################

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\[\e[35;1m\]\w\[\e[33;0m\]\$ \[\e[37;0m\]'
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
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

#mv & cp
#alias cp='cp -g'
#alias mv='mv -g'

#	proxy
alias sshchina='ssh -CfNg -D 9999 yjiang@v21.sshchina.com'

#	dropbox
alias dropbox='python /home/yjiang/.dropbox-dist/dropbox.py'

# some more git aliases
alias gf='git-ftp'
alias gtst='git status'
alias gtlg='git log --stat'
alias gtlg1='git log --pretty=format:"%h %an %s" --color=auto'
alias gtlg2='git log --pretty=oneline'
alias gtbr='git branch'
alias gtco='git commit'
alias gtdi='git diff'
alias gv='git svn'

#htop
alias htop='sudo htop'

#iftop
alias iftop='sudo iftop -i eth0'

#rsync
alias rsync='rsync -avz'

#tmux
alias tmux='tmux -2'
alias tmuxp='tmuxp load ~/.tmuxp.yaml -2'

alias cal='cal | grep --before-context 6 --after-context 6 --color -e " $(date +%e)" -e "^$(date +%e)"'

alias vi='vim'

#ctags
alias ctags='ctags -R *'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# bash-completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ $_os = 'osx' ];then 
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
  fi
fi


if [ $_os = 'osx' ];then
    ###################
    # osx alias
    alias flushdns='dscacheutil -flushcache'
    alias lsusb='system_profiler SPUSBDataType'
    ###################

    ###################
    #osx colors
    if brew list | grep coreutils > /dev/null ; then
        PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
        eval `gdircolors -b $HOME/.vim/dircolors`
    fi
    ###################


    ###################
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    ##
    # Your previous /Users/yjiang/.bash_profile file was backed up as /Users/yjiang/.bash_profile.macports-saved_2014-12-01_at_16:13:58
    ##

    # MacPorts Installer addition on 2014-12-01_at_16:13:58: adding an appropriate PATH variable for use with MacPorts.
    export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    # Finished adapting your PATH environment variable for use with MacPorts.
    ###################
fi

#set bash to vim mode
set -o vi

#set unicode
export LANG="zh_CN.UTF-8"
export LANG_ALL="zh_CN.UTF-8"
#set archlinux aur editor
export VISUAL="vim"
#include private settings
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
