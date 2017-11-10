#! /bin/bash

# generalized "print anything" cover
name=`basename $0`
ENSCRIPT=enscript

# This must exactly match all aliases, but not include "printing" itslef
paliases="lpr1up lpr132 lpr2up lpr4ps lprps printpdf print1up print132 print200 print2up printtall print2tall print2rfc print4rfc printtallrfc"

# Consider adding  -DDuplex:true

function requeue {
	file="$1"
	echo printing $file
	if [ ! -f $file ]; then
	    echo Can not find $file
	    exit 2
	fi
	lpr $file
	file2=~/printq/done/print`date +%Y%m%d%H%M%S`.ps 
	echo mv $file $file2
	mv $file $file2
}

case $name in
printing.sh)
	# (un)install all of our aliases
	cd $HOME/bin
	rm -f $paliases
	if [ x$1 = xno ]; then
	    echo "Uninstalled"
	else
	    for f in $paliases; do
		ln -s printing.sh $f
	    done
	fi
	;;
qlpr)
	# redefile lpr for later printing - stdin only
	file2=~/printq/spool/print`date +%Y%m%d%H%M%S`.lpr
	while [ -f $file2 ]; do
	    sleep 1
	    file2=~/printq/spool/print`date +%Y%m%d%H%M%S`.lpr
	done
	echo 'cat "$@" > '$file2
	cat "$@" > $file2
	;;
requeue)
	# print previously spooled files
	files=~/printq/spool/print*.lpr
	for f in $files; do
	    requeue $f
	done
	;;
lprps)
	# print printq/print.ps and rename it
	requeue ~/printq/print.ps
	;;
lpr1up)
	# Normal LP, emulated w/ enscript
	$ENSCRIPT -lB "$@"
	;;
lpr132)
	# Wide LP
	$ENSCRIPT -rlB "$@"
	;;
lpr2up)
	# 2 columns, landscape
	$ENSCRIPT -2rB "$@"
	;;
lpr4ps)
	# 4 per page, default printer has to be correct
	psnup -4 "$@" | lpr
	;;
printpdf)
	cat "$@" | ssh tesla.psc.edu pipeprint pdf
	;;
print1up)
	# Normal print
	$ENSCRIPT --lineprinter "$@"
	;;
print132)
	# wide print
	$ENSCRIPT --pass-through --font=Courier7 --landscape --columns=1 "$@"
	;;
print200)
	# very wide print
	$ENSCRIPT --pass-through --lines-per-page=100 --font=Courier6 --landscape --columns=1 "$@"
	;;
print2up)
	# 2 columns landscape
	$ENSCRIPT -Z --font=Courier7 --lines-per-page=200 --landscape --columns=2 -DTumble:true "$@"
	;;
printtall)
	# print one tall (wide) column
	$ENSCRIPT --pass-through --lines-per-page=100 --font=Courier7 "$@"
	;;
print2tall)
	# two tall narrow columns
	$ENSCRIPT --pass-through --font=Courier6 --lines-per-page=200 --portrait --columns=2 "$@"
	;;
print2rfc)
	# 2 columns, landscape 55 lines per page
	$ENSCRIPT -2rBL60 -DTumble:1 "$@"
	;;
print4rfc)
	# 2 columns, landscape 55 lines per page
	$ENSCRIPT -BU4L60 "$@"
	;;
printtallrfc)
	# print one tall (wide) column
	$ENSCRIPT --pass-through --lines-per-page=60 --font=Courier8 "$@"
	;;
*)
	echo "Unknown print command: $name"
	echo "Use one of: $paliases"
	exit 2
	;;
esac

exit $?

# paste into a shell
