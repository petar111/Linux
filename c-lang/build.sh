#!/bin/bash

HEADERS=$(find *.h)

for header in $(find *.h)
do
FILENAME=$(cut -d '.' -f1 <<<$header)
gcc -o $FILENAME.o -c $FILENAME.c
ar rcs $FILENAME.a $FILENAME.o
done

LIBS=$(find *.a)

gcc -o main.o main.c $LIBS
