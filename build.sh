#!/bin/bash

run() {
	if $DO_QUIET; then
		"$@" &>/dev/null
	else
		"$@"
	fi
}

CURR_REV="$(git describe --always --dirty --abbrev=6 || echo unknown)"
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

		-sd | --simple-diff)
			STY_DIFF="simple"
			VER_DIFF=$VALUE
			DO_DIFF=true
			;;

		-fd | --filter-diff)
			STY_DIFF="filter"
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
[ "$VER_DIFF" == "" ] && VER_DIFF="HEAD" || VER_DIFF=${VER_DIFF:0:6}

[ "$VER_DIFF" == "HEAD" ] && VER_CMD="\\def\\DIFrevdesc{$CURR_REV}" \
                          || VER_CMD="\\def\\DIFrevdesc{$VER_DIFF/$CURR_REV}"

[ $DO_REMOVE == true ] && run rm budowa/* obrazki/*.pdf
[ $DO_CONVERT == true ] && run libreoffice --convert-to pdf obrazki/*.odg --outdir obrazki
[ $DO_CONVERT == true ] && run inkscape -D obrazki/*.svg --export-type pdf

[ $DO_BUILD == true ] && CLSI=0 run latexmk --shell-escape -output-directory=budowa -pdflua thesis.tex
[ $DO_DIFF == true ] && CLSI=1 run git-latexdiff --main thesis.tex --output budowa/diff.pdf \
						--latexopt "--shell-escape -f -pdflua -usepretex=$VER_CMD" \
						--prepare "$0 --convert --skip --quiet || exit 0" \
						--preamble="$CURR_PATH/style/$STY_DIFF.sty" \
						--graphics-markup="none" --math-markup="coarse" \
						--packages="hyperref,biblatex" --encoding="utf8" \
						--latexdiff-flatten --latexmk -- "$VER_DIFF"

exit 0
