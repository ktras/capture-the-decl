#!/bin/bash

# example usage:
# ./capture-the-decl.sh {name-of-file-with-list-of-use-stmts}.txt

argname=$(echo "$1" | cut -f1 -d '.')
finaldecls="${argname}-final-decls.txt"
tempdecls="${argname}-temporary-decls.txt"

if test -f $finaldecls; then
    rm $finaldecls
fi

if test -f $tempdecls; then
    rm $tempdecls
fi

sed -e 's/\use //g' -e 's/\, only : /.f90 "/g' -e 's/\, only: /.f90 "/g' -e 's/$/"/' $1 >> $tempdecls

while read p; do
    module_file="$(echo $p | cut -d' ' -f 1)"
    if [[ ! -f $module_file ]]; then
        if test -f ../common/$module_file; then
            module_file="../common/$module_file"
        else
            echo "Module file not found in the common dir: $module_file"
            echo "Please manually search for $module_file and its declarations in another directory"
            continue
        fi
    fi
    vars_str="$(echo $p | cut -d'0' -f 2)"
    vars_str="$(echo $vars_str | cut -d'"' -f 2)"
    my_array=($(echo $vars_str | tr "," "\n"))
    for i in "${my_array[@]}"
    do
        echo $(grep -w -i $i $module_file) >> $finaldecls
    done
done < $tempdecls

rm $tempdecls
