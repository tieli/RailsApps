#/bin/bash

Index=0

for file in *.jpg
do
    echo "mv ${file} ${Index}.img"
    mv ${file} "${Index}.jpg"
    Index=$(($Index+1))
done

