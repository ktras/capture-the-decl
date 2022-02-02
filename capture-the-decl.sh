#!/bin/bash

# example usage:
# ./capture-the-decl.sh {name-of-file-with-list-of-use-stmts}.txt

finaldecls="finaldecls-result.txt"
tempdecls="temporarydecls.txt"

if test -f $finaldecls; then
    rm $finaldecls
fi

if test -f $tempdecls; then
    rm $tempdecls
fi

sed -e 's/\use //g' -e 's/\, only : /.f90 "/g' -e 's/\, only: /.f90 "/g' -e 's/$/"/' $1 >> $tempdecls

while read p; do
    filename="$(echo $p | cut -d' ' -f 1)"
    vars_str="$(echo $p | cut -d'0' -f 2)"
    vars_str="$(echo $vars_str | cut -d'"' -f 2)"
    my_array=($(echo $vars_str | tr "," "\n"))
    for i in "${my_array[@]}"
    do
        echo $(grep -w -i $i $filename) >> $finaldecls
    done
done < $tempdecls

rm $tempdecls
