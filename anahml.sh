#!/bin/bash


cd $1


name=""
prev_line=""
while IFS= read -r line; do
    if [[ $line =~ ^Upgrade ]]; then
        name=$(echo "$line" | cut -d' ' -f2-)
        prev_line="$line"
    else
        #echo "$prev_line"
        echo "$name|$line" >> fixa3.txt
                echo "$name|$line"
    fi
done < fixable.txt

# Print the last line if it exists
if [[ -n $prev_line ]]; then
    echo "$prev_line"
fi

sed -i '' '/^Upgrade/d' fixa3.txt
#sort fixa.txt | uniq -c >>fixerr.txt



name=""
prev_line=""
while IFS= read -r line; do
    if [[ $line =~ ^Patch ]]; then
        name=$(echo "$line" | cut -d' ' -f2-)
        prev_line="$line"
    else
        #echo "$prev_line"
        echo "$name|$line" >> patcha3.txt
    fi
done < patchable.txt

# Print the last line if it exists
if [[ -n $prev_line ]]; then
    echo "$prev_line"
fi
sed -i '' '/^Patch/d' patcha3.txt
#sed -i '' 's/^✗ //g' patcha.txt
#sort patcha.txt | uniq -c >> patcher.txt




name=""
prev_line=""
tac unfixable.txt | while IFS= read -r line; do
    if [[ $line =~ ^introduced ]]; then
        name1=$(echo "$line" | cut -d' ' -f3)
        name=$(echo "$name1" | cut -d'>' -f1)
        prev_line="$line"
    else
        #echo "$prev_line"
        echo "$name|$line" >> unfixa3.txt
    fi
done

# Print the last line if it exists
if [[ -n $prev_line ]]; then
    echo "$prev_line"
fi

#sed -i '' 's/✗ //g' unfixa.txt
#sort unfixa.txt | uniq -c >> unfixer.txt

cat fixa3.txt unfixa3.txt >>ufixfix.txt
cat ufixfix.txt patcha3.txt >> alltog.txt

sed -i '' 's/^ //g' alltog.txt
sed -i '' 's/ Fix\]/\]Fix\]/g' alltog.txt
sed -i '' 's/ Patch\]/\]Patch\]/g' alltog.txt
sed -i '' 's/\[Critical /\[High/g' alltog.txt
sed -i '' 's/Severity\]/\]Unfix\]/g' alltog.txt

sed -i '' 's/ |/|/g' alltog.txt

cd /Users/anastassia/github.com/github.com

