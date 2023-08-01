#!/bin/bash

PDFV_LO='{"SelectPdfVersion":{"type":"long","value":"1"}}'
PDFV_IS='1.4'

REMOVE=false
CONVERT=false
BUILD=true

while [ "$1" != "" ]; do
	
	PARAM=`echo $1 | awk -F= '{print $1}'`
	VALUE=`echo $1 | awk -F= '{print $2}'`
	
	case $PARAM in
	
		-r | --remove)
			REMOVE=true
			;;
			
		-c | --convert)
			CONVERT=true
			;;
			
		-s | --skip)
			BUILD=false
			;;
			
	esac
	shift
	
done

[ $REMOVE == true ] && rm budowa/*
[ $CONVERT == true ] && libreoffice --convert-to "pdf:draw_pdf_Export:$PDFV_LO" obrazki/*.odg --outdir obrazki 
[ $CONVERT == true ] && inkscape -D obrazki/*.svg --export-type pdf --export-pdf-version "$PDFV_IS"
[ $BUILD == true ] && latexmk --shell-escape -output-directory=budowa -pdflua thesis.tex

