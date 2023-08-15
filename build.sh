#!/bin/bash

run() {
	if $DO_QUIET; then
		"$@" &>/dev/null
	else
		"$@"
	fi
}

DO_REMOVE=false
DO_CONVERT=false
DO_BUILD=true
DO_DIFF=false
DO_QUIET=false

VER_DIFF=""

while [ "$1" != "" ]; do

	PARAM=`echo $1 | awk -F= '{print $1}'`
	VALUE=`echo $1 | awk -F= '{print $2}'`

	case $PARAM in

		-q | --quiet)
			DO_QUIET=true
			;;

		-r | --remove)
			DO_REMOVE=true
			;;

		-c | --convert)
			DO_CONVERT=true
			;;

		-s | --skip)
			DO_BUILD=false
			;;

		-d | --diff)
			DO_DIFF=true
			VER_DIFF=$VALUE
			;;

	esac
	shift

done

[ "$VER_DIFF" == "" ] && VER_DIFF="HEAD"

[ $DO_REMOVE == true ] && run rm budowa/*
[ $DO_CONVERT == true ] && run libreoffice --convert-to pdf obrazki/*.odg --outdir obrazki
[ $DO_CONVERT == true ] && run inkscape -D obrazki/*.svg --export-type pdf
[ $DO_BUILD == true ] && run latexmk --shell-escape -output-directory=budowa -pdflua thesis.tex
[ $DO_DIFF == true ] && run git-latexdiff --main thesis.tex --prepare "./build.sh -c -s -q" --filter "export CLSI=1" --output "budowa/diff.pdf" --latexmk --latexopt "--shell-escape -pdflua -f" -- $VER_DIFF

exit 0
