#!/bin/bash
#met=$(echo "$1"|cut -d "/" -f1)
#met1=$(echo "$2"|cut -d "/" -f2)

wget -r -np -l 1 -A zip https://github.com/$1/tags
#cd /Users/anastassia/github.com/$1/$2/archive
#unzip -q "*.zip" -d /Users/anastassia/Desktop/diplomatiki_files/$1
#cd /Users/anastassia/Desktop/diplomatiki_files/$1
