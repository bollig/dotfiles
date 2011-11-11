source ~/.bashrc

test -r /sw/bin/init.sh && . /sw/bin/init.sh
alias xemacs="emacs22-carbon"

# Append to bash history rather than delete it at intervals
#shopt -s histappend

#export PROMPT_COMMAND="history -n; history -a"

##
# Your previous /Users/bollig/.bash_profile file was backed up as /Users/bollig/.bash_profile.macports-saved_2010-02-09_at_13:50:53
##

# MacPorts Installer addition on 2010-02-09_at_13:50:53: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

