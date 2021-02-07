#!/bin/bash

echo Cleaning project begin...

echo Removing libraries...

if [ -d ./build/lib ]
then
	rm -r ./build/lib
fi

echo Done removing libraries.


echo Removing compiled files...

if [ -d ./build/out ]
then
	rm -r ./build/out
fi

if [ -f ./main.o ]
then
	rm ./main.o
fi

echo Done removing compiled files.

echo Cleaning completed.

