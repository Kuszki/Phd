#!/bin/bash

run() {
	if $DO_QUIET; then
		"$@" &>/dev/null
	else
		"$@"
	fi
}

CURR_PATH="$(dirname $(realpath $0))"
CURR_NAME="$(basename $0)"

DO_REMOVE=false
DO_CONVERT=false
DO_OCTAVE=false
DO_BUILD=true
DO_DIFF=false
DO_QUIET=false

while [ "$1" != "" ]; do

	PARAM=`echo $1 | awk -F= '{print $1}'`
	VALUE=`echo $1 | awk -F= '{print $2}'`

	case $PARAM in

		-cd | --comment-diff)
			STY_DIFF="comment"
			VER_DIFF=$VALUE
			DO_DIFF=true
			;;

		-dd | --detail-diff)
			STY_DIFF="detail"
			VER_DIFF=$VALUE
			DO_DIFF=true
			;;

		-sd | --short-diff)
			STY_DIFF="short"
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

		-o | --octave)
			DO_OCTAVE=true
			;;

		-s | --skip)
			DO_BUILD=false
			;;

	esac
	shift

done

if $DO_OCTAVE; then

	cd "$CURR_PATH/skrypty"

	for i in draw_*.m; do
		run octave "$i"
	done

	cd "$CURR_PATH"

fi

[ $DO_BUILD == true ] && [ $DO_REMOVE == true ] && DO_CONVERT=true
[ "$VER_DIFF" == "" ] && VER_DIFF="HEAD"

[ $DO_REMOVE == true ] && run rm budowa/* obrazki/*.pdf
[ $DO_CONVERT == true ] && run libreoffice --convert-to pdf obrazki/*.odg --outdir obrazki
[ $DO_CONVERT == true ] && run inkscape -D obrazki/*.svg --export-type pdf

[ $DO_BUILD == true ] && CLSI=0 run latexmk --shell-escape -output-directory=budowa -pdflua thesis.tex
[ $DO_DIFF == true ] && CLSI=1 run git-latexdiff --main thesis.tex --output budowa/diff.pdf \
						--preamble="$CURR_PATH/style/$STY_DIFF.sty" \
						--packages="hyperref,biblatex" \
						--graphics-markup="none" \
						--math-markup="coarse" \
						--prepare "$0 -c -s -q" \
						--latexopt "--shell-escape -pdflua -f" \
						--latexmk -- "$VER_DIFF"

exit 0
