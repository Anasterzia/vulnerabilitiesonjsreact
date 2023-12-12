#!/bin/bash


cd $1


name=""
prev_line=""
while IFS= read -r line; do
    
        name=$(echo "$line" | cut -d '|' -f1)
        echo "$name|$2" >> counter.txt
done < fixa.txt

while IFS= read -r line; do
    
        name=$(echo "$line" | cut -d '|' -f1)
        echo "$name|$2" >> counter.txt
done < unfixa.txt

while IFS= read -r line; do
    
        name=$(echo "$line" | cut -d '|' -f1)
        echo "$name|$2" >> counter.txt
done < patcha.txt



cd /Users/anastassia/github.com/github.com

