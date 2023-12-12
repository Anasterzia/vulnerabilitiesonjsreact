#!/bin/bash


cd $1
rm unfixa2.txt
rm unfixa1.txt
rm patcha1.txt
rm patcha2.txt
rm fixa2.txt
rm fixa1.txt
rm fputotal.txt
rm hmltotal.txt
rm tt1.txt
rm total.txt

name=""
prev_line=""
while IFS= read -r line; do
    if [[ $line =~ ^Upgrade ]]; then
        name=$(echo "$line" | cut -d' ' -f2-)
        prev_line="$line"
    else
        #echo "$prev_line"
        echo "$name|$line" >> fixa1.txt
                echo "$name|$line"
    fi
done < fixable.txt

# Print the last line if it exists
if [[ -n $prev_line ]]; then
    echo "$prev_line"
fi

sed -i '' '/^Upgrade/d' fixa1.txt
#sort fixa.txt | uniq -c >>fixerr.txt



name=""
prev_line=""
while IFS= read -r line; do
    if [[ $line =~ ^Patch ]]; then
        name=$(echo "$line" | cut -d' ' -f2-)
        prev_line="$line"
    else
        #echo "$prev_line"
        echo "$name|$line" >> patcha1.txt
    fi
done < patchable.txt

# Print the last line if it exists
if [[ -n $prev_line ]]; then
    echo "$prev_line"
fi
sed -i '' '/^Patch/d' patcha1.txt
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
        echo "$name|$line" >> unfixa1.txt
    fi
done

# Print the last line if it exists
if [[ -n $prev_line ]]; then
    echo "$prev_line"
fi

#sed -i '' 's/✗ //g' unfixa.txt
#sort unfixa.txt | uniq -c >> unfixer.txt

sed -i '' 's/^ //g' fixa1.txt
sed -i '' 's/^ //g' unfixa1.txt
sed -i '' 's/^ //g' patcha1.txt
sed  's/ Fix\]/\]/g' fixa1.txt >> fixa2.txt
sed -i '' 's/\[High /\[/g' fixa1.txt
sed -i '' 's/\[Medium /\[/g' fixa1.txt
sed -i '' 's/\[Low /\[/g' fixa1.txt

sed  's/Severity\]/\]/g' unfixa1.txt >> unfixa2.txt
sed -i '' 's/\[High/ \[/g' unfixa1.txt
sed -i '' 's/\[Medium /\[/g' unfixa1.txt
sed -i '' 's/\[Low /\[/g' unfixa1.txt

sed  's/ Patch\]/\]/g' patcha1.txt >> patcha2.txt
sed -i '' 's/\[High/\[/g' patcha1.txt
sed -i '' 's/\[Medium/\[/g' patcha1.txt
sed -i '' 's/\[Low/\[/g' patcha1.txt

sed -i '' 's/ |/|/g' fixa1.txt
sed -i '' 's/ |/|/g' unfixa1.txt
sed -i '' 's/ |/|/g' patcha1.txt
sed -i '' 's/ |/|/g' fixa2.txt
sed -i '' 's/ |/|/g' unfixa2.txt
sed -i '' 's/ |/|/g' patcha2.txt

cat  fixa1.txt  patcha1.txt >> tt1.txt
cat unfixa1.txt tt1.txt >> total.txt
sort total.txt | uniq -c >> fputotal.txt
rm tt1.txt
rm total.txt

cat  fixa2.txt  patcha2.txt >> tt1.txt
cat unfixa2.txt tt1.txt >> total.txt
sort total.txt | uniq -c >> hmltotal.txt
rm tt1.txt
rm total.txt
cd /Users/anastassia/github.com/github.com

