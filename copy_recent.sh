#!/usr/bin/env bash

dest=$1

for fl in $( find app -type f \( -name "*.rb" -o -name "*.erb" \) -mmin -40 )
do
    echo "copying $fl to $dest"
    cp --parent $fl $dest
done

