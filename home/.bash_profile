# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

if [ ! "$RC_HIST" ]; then
    # Never been here before
    # ps axlw > first.log
    printenv >> first.log
    set >> first.log
    if [ ! -d "$HOME" ]; then
	echo "No home: $HOME, substituting: "`pwd`
	export HOME=`pwd`
    fi
fi
# leave some crumbs
export RC_HIST="$RC_HIST:.bash_profile_20230423"

# the default umask is set in /etc/login.defs
#umask 022

# include .bashrc if it exists
if [ -f $HOME/.bashrc ]; then
    . $HOME/.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

cd
