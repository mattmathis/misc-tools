#! /bin/bash
# stupid hack to choose the correct emacs/ mode

# later we decide how called
mode=`basename $0`

if  [ "$mode" == emacs.sh ]; then
    alss="emacs Emacs nwemacs emacsserver Emacsserver nwemacsserver de bke emacs.wait"
    cd $HOME/bin
    rm -f $alss
    if [ x$1 = xno ]; then
	echo "Uninstalled"
    else
	for f in $alss; do
	    ln -s emacs.sh $f
	done
	echo "Installed"
    fi
    exit 0
fi

# Do it differently for macs
if [ `uname` == "Darwin" ]; then
    emacs="xemacs"
    emacs="/usr/bin/emacs"
    cemacs=emacsclient
    # workarounds
    # mode=nowin
else
    # choose an emacs binary
    emacs=/usr/bin/emacs24
    [ ! -x $emacs ] && emacs=/usr/bin/emacs
    [ ! -x $emacs ] && echo Can not find emacs binary && exit 2
    # choose emaceclient binary
    case $emacs in
      /usr/bin/emacs24) cemacs=emacsclient.emacs24
        ;;
      *) cemacs=emaceclient
        ;;
    esac

    # If adjust the mode per X display
    case "x$DISPLAY" in
	x)  mode=nowin
            cemacs=$emacs
	    ;;
    esac
fi

# launch in the chosen way
case $mode in
emacsserver)
	# use: startserver -font fixed
	server="$emacs $* -f server-start"
	echo "Starting server: (cd; $server >/dev/null 2>&1 & )"
	(cd; $server >/dev/null 2>&1 & )
	;;
nwemacsserver|Emacsserver)
	# use: startserver -font fixed
	
	echo "Starting -nw server: cd; exec $emacs -nw $* -f server-start"
	cd; exec $emacs -nw $* -f server-start
	;;
nowin|nwemacs|Emacs)
	echo "exec $emacs -nw $*"
	exec $emacs -nw $*
	;;
detach|de)
	echo "( $cemacs $* & )"
	( $cemacs --no-wait $* & )
	sleep 1
	;;
bke)
	echo "( bk edit $* ; $cemacs $* & )"
	( bk edit $* ; $cemacs $* & )
	;;
plain|emacs*)
	echo "Default: exec $cemacs $*"
	exec $cemacs $*
	;;
*)
	echo Unknown name: $mode
esac

exit

