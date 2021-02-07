#!/bin/bash

echo BUILD INIT...

echo Checking if build directory exists and creating if not exist...

if ! [[ -d ./build ]]
then
	mkdir ./build
fi

if ! [[ -d ./build/out ]]
then
	mkdir ./build/out
fi

if ! [[ -d ./build/lib ]]
then
	mkdir ./build/lib
fi

echo Checking and creating completed.


echo Compiling headers and making libraries...

for header in $(find . -name "*.h")
do
FILENAME=$(cut -d '.' -f2 <<<$header)
gcc -o .$FILENAME.o -c .$FILENAME.c
ar rcs .$FILENAME.a .$FILENAME.o
done

echo Completed compiling headers and making libraries.

echo Moving compiled files and libraries to build folder...

find . -path ./build -prune -o -name "*.o" -exec mv {} ./build/out \;
find . -path ./build -prune -o -name "*.a" -exec mv {} ./build/lib \;

echo Completed moving.

LIBS=$(find ./build/lib -name "*.a")

echo Compiling main file...
gcc -o main.o main.c $LIBS -lm
echo Completed compiling main file.

echo BUILD FINISHED.
