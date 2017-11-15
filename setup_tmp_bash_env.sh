# usage: source this file in bash

alias gs="git status"
#alias gp="git-push"
#alias gcl="git-clone"
alias ga="git add"
#alias gd="git diff"
alias gd="git --no-pager diff"
alias gdp="git diff"
alias gb="git branch"
alias gbr="gb -r | head -3"
alias gpwd="git rev-parse --git-dir"
alias gwd="git rev-parse --git-dir"
alias gbl="git blame"
alias gc="git commit"
alias gco="git checkout"
alias gl="git log --oneline --graph --decorate"
alias glo="git log --oneline --graph"
#alias ls="ls -al"
alias glu="git log -u"
alias gluf='git log --pretty="%H,%ci,%Cred%ae,%Cgreen%s"'
alias gluid='_(){ glu $1 | grep "Change-Id" | head -1 }; _'
alias grst='curdir=`pwd` ; cd `git rev-parse --git-dir` ; cd .. ; git checkout . ; git clean -df ; cd $curdir'
alias gfp='git format-patch -1'

#alias hpush="history | grep push"
alias change='change_wcn_product `gettop`'
#alias change=' _(){ which gettop; if [ "$?" -eq 0 ] ; then change_wcn_product `gettop` ; else change_wcn_product ; fi };_'

alias touchall='find . -name "*" -type f -print0 | xargs -n 1 --null touch'

#alias vi='vimfunc(){set -x ;  echo $1 ; if [[ "$1" =~ ^.*:([[:digit:]]).* ]]; then var=`echo "$1" | sed "s/:\([[:digit:]]\)/ +\1/g" `; echo "${var}" ; vim ${var} ; else echo "$*" ; vim "$*" ;  fi ; set +x } ; vimfunc'

#alias -='cd -'
alias ...=../..
alias ....=../../..
alias .....=../../../..
alias ......=../../../../..
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'8='cd -8'
alias 9='cd -9'
alias _=sudo

alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias gs='git status'
alias gwd='git rev-parse --git-dir'
alias history='fc -l 1'
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='ls --color=tty'
alias lsa='ls -lah'


# for history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# for increament history
shopt -s histappend


