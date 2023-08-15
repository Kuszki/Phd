#!/bin/bash

DO_REMOVE=false
DO_CONVERT=false
DO_BUILD=true
DO_DIFF=false

while [ "$1" != "" ]; do
	
	PARAM=`echo $1 | awk -F= '{print $1}'`
	VALUE=`echo $1 | awk -F= '{print $2}'`
	
	case $PARAM in
	
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
			DO_REMOVE=true
			;;
			
	esac
	shift
	
done

[ $DO_REMOVE == true ] && rm budowa/*
[ $DO_CONVERT == true ] && libreoffice --convert-to pdf obrazki/*.odg --outdir obrazki 
[ $DO_CONVERT == true ] && inkscape -D obrazki/*.svg --export-type pdf
[ $DO_BUILD == true ] && latexmk --shell-escape -output-directory=budowa -pdflua thesis.tex
[ $DO_DIFF == true ] && git-latexdiff --main thesis.tex --prepare "./build.sh -c -s" --filter "CLSI=1" --output "budowa/diff.pdf" --no-flatten --latexmk --latexopt "--shell-escape -output-directory=budowa -pdflua" -- HEAD

exit 0
