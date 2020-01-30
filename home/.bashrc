# .bashrc for Matt Mathis
# This lives in .../misc-tools/home/

# leave some crumbs
export RC_HIST="$RC_HIST:~/.bashrc_20191015"

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

# don't put duplicate lines in the history. See bash(1) for more options
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make cd a bit nicer.
# Redefine pwd to display absolute paths, default to ~/work and search
# some shortcuts.
# BEWARE: this may prove to be problematic on (flaky) remote file systems.
set -P
function cd {
    if [ "$1" ]; then
        builtin cd "$*"
    else
        builtin cd $HOME/work
    fi
}
export CDPATH=.:~:~/.shortcuts:~/Projects

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

export PATH=$HOME/go/bin:$LOGINPATH:$HOME/bin:

# de, emacs.wait are wrappers for emacs/emacsserver
export EDITOR=emacs.wait
export P4CONFIG=.p4config
export P4EDITOR=emacs.wait
export G4NOTHAVEFILTER='.csv .ssv .png .FAIL .DREMEL'

if [ -d '/usr/local/google/home/mattmathis/google-cloud-sdk/' ]; then
  # The next line updates PATH for the Google Cloud SDK.
  source '/usr/local/google/home/mattmathis/google-cloud-sdk/path.bash.inc'

  # The next line enables shell command completion for gcloud.
  source '/usr/local/google/home/mattmathis/google-cloud-sdk/completion.bash.inc'

fi

