#echo "Entering ~/.profile"
export PS1="\[\033[33m\](\t) \[\033[0m\]\h:\[\033[32m\]\w:\[\033[0m\] "

# list directories in columns
case `uname` in
	Darwin)
		alias ls='ls -G -F'
		. /sw/bin/init.sh
		;;
	*)
		alias ls='ls --color -F'
		;;
esac

alias grep='grep --color' 

export PATH=$PATH:~/local/bin
# provided in ~/local/bin:
alias edit='interactiveLatex.sh' 

alias create_patch='diff -crB'
source ~/.bashrc
#source ~/NVIDIA_CUDA_TOOLKIT_3.0/bin/cudaEnv.sh

#latexmk -pvc -view=pdf notebook.tex
