#!/bin/bash

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
[ $CONVERT == true ] && inkscape -D obrazki/*.svg --export-type pdf
[ $BUILD == true ] && latexmk -output-directory=budowa -pdflua thesis.tex

