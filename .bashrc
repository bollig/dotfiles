function ssh() {
  eval last_arg=\$$#
  screen -t "$last_arg" ssh -t "$@"; #screen -e^Vv;
#  ssh -t "$@"; 
}

function screenssh() {
  eval last_arg=\$$#
  screen -t "$last_arg" ssh -t "$@" screen -R -e^Vv;
}

function _get_screen_session() {
#    screen -ls | sed -n "s/^[ \t]\([0-9a-zA-Z.].*\)[ \t].*/\1/p"  |grep ^"$2" | sort -u ;
    screen -ls | sed -n "s/^[[:space:]]\([0-9][0-9a-zA-Z.*].*\)[[:space:]].*/\1/p"
}
function _complete_screen() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    optsC="-R -dr -x"
    opts=$( _get_screen_session )

    if [[ ${cur} == -* ]] ; then
        COMPREPLY=( $(compgen -W "${optsC}" -- ${cur}) )
        return 0
    fi

    if [[ ${prev} == -* ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi
}
# Tab completion on screen sessions
complete -o default  -F _complete_screen screen
alias resume="screen -R"
alias share_screen="screen -x -R"


SH_COMPLETE=( $(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | egrep -v [0123456789]) )
complete -o default -W "${SSH_COMPLETE[*]}" ssh


PS1='\h:\W \u\$ '

SSH_COMPLETE=( $(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | egrep -v [0123456789]) )
complete -o default -W "${SSH_COMPLETE[*]}" ssh


export LSCOLORS=cxexcxdxbxfxfxbxbxcxcx
#export PS1="\n\[\e[0;32m\]\w \[\e[0;38m\]\n-> "
alias ls='ls -FGv'

alias grep='grep --color=always'
alias cgrep='$HOME/scripts/cudaGrep.sh'

export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:/Developer/CUDA/common/lib/darwin
export PATH=/usr/local/share/python:/usr/local/cuda/bin:/usr/local/bin:$PATH
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH

export NCARG_ROOT=/opt/ncl_ncarg-6.0.0.MacOS_10.6_64bit_nodap_gcc421
export PATH=$NCARG_ROOT/bin:$PATH
#/sw/lib/qt4-mac/bin:


# Append to bash history rather than delete it at intervals
#shopt -s histappend

#export PROMPT_COMMAND="history -n; history -a"
source ~/.git-completion.bash
