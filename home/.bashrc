# .bashrc for Matt Mathis

# leave some crumbs
export RC_HIST="$RC_HIST:~/.bashrc_20151118"

# Save $PATH for later
if [ ! "$LOGINPATH" ]; then
    export LOGINPATH=$PATH
    _firstpath=1
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Play nice with screen and long prompts
_wp=""
if [ "$WINDOW" ]; then
    _wp="($WINDOW)"
fi
export PS1='${debian_chroot:+($debian_chroot)}\u@\h'"$_wp"':\w\n\$ '
unset _wp

# ... and ignore same sucessive entries and lines that start with space
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make cd a bit nicer.
# Redefine pwd to display absolute paths, default to ~/tmp and search
# some shortcuts.
# BEWARE: this may prove to be problematic on (flaky) remote file systems.
set -P
function cd {
    if [ "$1" ]; then
	builtin cd "$*"
    else
	builtin cd $HOME/tmp
    fi
}
export CDPATH=.:~:~/.shortcuts
# export CDPATH=.:~:~/.shortcuts:~/Projects

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# other aliases
alias more=less

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export PATH=$LOGINPATH:$HOME/bin:

# de, emacs.wait are wrappers for emacs/emacsserver
export EDITOR=emacs.wait

export P4CONFIG=.p4config
export P4EDITOR=emacs.wait
export G4NOTHAVEFILTER='.csv .ssv .png .FAIL .DREMEL'

# The next line updates PATH for the Google Cloud SDK.
source '/usr/local/google/home/mattmathis/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/usr/local/google/home/mattmathis/google-cloud-sdk/completion.bash.inc'
