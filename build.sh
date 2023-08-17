#!/bin/bash

run() {
	if $DO_QUIET; then
		"$@" &>/dev/null
	else
		"$@"
	fi
}

CURR_PATH="$(dirname $(realpath $0))"

DO_REMOVE=false
DO_CONVERT=false
DO_BUILD=true
DO_DIFF=false
DO_QUIET=false

while [ "$1" != "" ]; do

	PARAM=`echo $1 | awk -F= '{print $1}'`
	VALUE=`echo $1 | awk -F= '{print $2}'`

	case $PARAM in

		-fd | --full-diff)
			STY_DIFF="fdiff.sty"
			VER_DIFF=$VALUE
			DO_DIFF=true
			;;
			
		-sd | --short-diff)
			STY_DIFF="sdiff.sty"
			VER_DIFF=$VALUE
			DO_DIFF=true
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

	esac
	shift

done

[ $DO_BUILD == true ] && [ $DO_REMOVE == true ] && DO_CONVERT=true
[ "$VER_DIFF" == "" ] && VER_DIFF="HEAD"

[ $DO_REMOVE == true ] && run rm budowa/* obrazki/*.pdf
[ $DO_CONVERT == true ] && run libreoffice --convert-to pdf obrazki/*.odg --outdir obrazki
[ $DO_CONVERT == true ] && run inkscape -D obrazki/*.svg --export-type pdf

[ $DO_BUILD == true ] && CLSI=0 run latexmk --shell-escape -output-directory=budowa -pdflua thesis.tex
[ $DO_DIFF == true ] && CLSI=1 run git-latexdiff --main thesis.tex --output budowa/diff.pdf \
						--preamble="$CURR_PATH/style/$STY_DIFF" \
						--packages="hyperref,biblatex" \
						--math-markup="coarse" \
						--graphics-markup="none" \
						--prepare "./build.sh -c -s -q" \
						--latexopt "--shell-escape -pdflua -f" \
						--latexdiff-flatten --latexmk -- "$VER_DIFF"

exit 0
