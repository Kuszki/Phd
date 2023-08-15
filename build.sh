#!/bin/bash

run() {
	if $DO_QUIET; then
		"$@" &>/dev/null
	else
		"$@"
	fi
}

CURR_PATH="$(dirname $(realpath $0))"

STY_DIFF="sdiff.sty"
VER_DIFF="HEAD"

DO_REMOVE=false
DO_CONVERT=false
DO_BUILD=true
DO_DIFF=false
DO_QUIET=false

while [ "$1" != "" ]; do

	PARAM=`echo $1 | awk -F= '{print $1}'`
	VALUE=`echo $1 | awk -F= '{print $2}'`

	case $PARAM in

		-f | --full)
			STY_DIFF="fdiff.sty"
			;;

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
			;;

		-v | --version)
			VER_DIFF=$VALUE
			;;

	esac
	shift

done

[ $DO_REMOVE == true ] && run rm budowa/*
[ $DO_CONVERT == true ] && run libreoffice --convert-to pdf obrazki/*.odg --outdir obrazki
[ $DO_CONVERT == true ] && run inkscape -D obrazki/*.svg --export-type pdf

[ $DO_BUILD == true ] && CLSI=0 run latexmk --shell-escape -output-directory=budowa -pdflua thesis.tex
[ $DO_DIFF == true ] && CLSI=1 run git-latexdiff -p "$CURR_PATH/style/$STY_DIFF" -o budowa/diff.pdf --latexmk --main thesis.tex --prepare "./build.sh -c -s -q" --latexopt "--shell-escape -pdflua -f" -- "$VER_DIFF"

exit 0
