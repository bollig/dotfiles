#echo "Entering ~/.bashrc"
#export PS1="\[\033[33m\](\t) \[\033[0m\]\h:\[\033[32m\]\w:\[\033[0m\] "

# Show the git branch when we're in a repo. And always show host and dir info. 
#YELLOW="\[\033[0;33m\]"
#GREEN="\[\033[0;32m\]"
#WHITE="\[\033[0;0m\]"
#PS1="${YELLOW}\$(__git_ps1) ${WHITE}\h:${GREEN}\w:${WHITE} "


export EDITOR=vim
#export PETSC_DIR=/usr/local/petsc-3.0.0-p4
#export PETSC_DIR=/usr/local/petsc-2.3.3-p15
#export PETSC_ARCH=linux-gnu-c-debug
#source ~/NVIDIA_CUDA_TOOLKIT_2.1/bin/cudaEnv.sh

export PATH=$PATH:~/local/bin

#preview_latex () { 
#	latexmk -pvc -view=pdf "$@" 2>&1 > preview_latex.log;
#}

alias lmk="grep -l '\\documentclass' *tex | xargs latexmk -pdf -pvc -silent"
alias lmk_file="latexmk -pdf -pvc -silent $1"


function screenssh() {
  eval last_arg=\$$#
    screen -t "$last_arg" ssh -x -t "$@" screen -e^Jj;
}

function _get_screen_session() {
    screen -ls | sed -n "s/^[ \t]\([0-9a-zA-Z.].*\)[ \t].*/\1/p"  |grep ^"$2" | sort -u ;
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

    #COMPREPLY=( $( compgen -W "${SCREEN_SESIONS}") )
    #'screen -ls | sed -n "s/^[ \t]\([0-9a-zA-Z.].*\)[ \t].*/\1/p"  |grep ^"$2" | sort -u ;' ) )
}

complete -o default  -F _complete_screen screen
#complete -o default -C 'screen -ls | sed -n "s/^[ \t]\([0-9a-zA-Z.].*\)[ \t].*/\1/p"' screen
#complete -o default -W "${SCREEN_COMPLETE[*]}" screen -R

SSH_COMPLETE=( $(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | egrep -v [0123456789]) )
complete -o default -W "${SSH_COMPLETE[*]}" ssh


alias resume="screen -R"
alias share_screen="screen -x -R"

#Gordon said this should work
#fgrep () {
#	find $1 -name "*.cpp" -o -name "*.h" -exec grep -in $2 {} \; -print
#}

source ~/research/nvidia/NVIDIA_CUDA_TOOLKIT_4.0/bin/cudaEnv.sh
source ~/.gpu_macros

# Get bash completion and enable git repo info in PS1
source /etc/bash_completion.d/git 
. ~/.bash_prompt

export PATH=$PATH:~/local/mendeley/bin
case $HOSTNAME in
    bones|spock|uhura|worf|kirk|laforge|troi)
        export PETSC_DIR=~/research/petsc-3.1-p7
        export PETSC_ARCH=arch-linux-vislab-dbg
        # disable CTRL-S for terminal and allow pass through to VIM
        stty stop ^-    #use 'ctrl -' to replace 'ctrl s'
        ;;
	borg) 
        export PETSC_DIR=~/research/petsc-3.1-p7
        export PETSC_ARCH=arch-linux-vislab-dbg
		source ~/research/ati_opencl/setupStreamSDK.sh
        # disable CTRL-S for terminal and allow pass through to VIM
        stty stop ^-    #use 'ctrl -' to replace 'ctrl s'
    	;;
    bynar)
        source ~efb06/research/ati_opencl/AMD-APP-SDK-v2.4-lnx64/setupStreamSDK.sh
        stty stop ^-
        ;;
	hallway*|dskscs*|class*)
       		source /usr/common/classes/gerlebacher/setupClassEnv.sh
		;;
    pamd*)
        if [ -z "${WINDOW}" ]
        then 
            export SCREEN_RESUMED=1
            # Resumed previous session (or start a new one and assign CTRL-V as the control for pamd layer of screen
            #resume -e^Vv
            resume -e^Jj

            #if [ "$?" != "0" ]  
            #then 
            #    screen -R -e^Vv
            #fi
        fi

    # FROM my laptop: 
    #    if [ -z "${SCREEN_RESUMED}" ]
    #    then 
    #        export SCREEN_RESUMED=1
    #        # Resumed previous session (or start a new one and assign CTRL-V as the control for pamd layer of screen
    #        screen -R -e^Vv
    #    fi
    ;;
	*)	
        #if [ $TERM == "screen" ]
        #then
        #    screen -e^Vv
        #fi
	;;
esac

case `uname` in 
    "Linux") 
        eval `dircolors ~/.dircolors`
        alias ls='ls -hF --color'
        alias vi=vim
        alias open='gnome-open'
        alias grep='grep --color'
        ;;
    "Darwin")
    ;;
    *)
    ;;
esac
