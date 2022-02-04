# capture-the-decl

### Description

capture-the-decl is a simple bash script that automates part of the process necessary when converting
module variables used in a procedure to dummy arguments for that procedure.
The script takes a text file with a list of use-stmts with only clauses as its only argument.
It searches the current directory for .f90 files with the same name as the modules to grab
the declarations for the module variables in the only clauses. If it can not find the
module file in the current directory, it will search for it in a directory named `common',
which is one level up from the current directory. If the module file can not be found
there either, it prints a warning and continues searching for the next file.

The script copies all the found declarations to a new text file for use in adding dummy argument declarations.

**Note:** Ensure that the text file with the use statements has each use statement on a singular line, no matter how long.
The script does not currently deal with line continuations.

### Example Usage

```
./capture-the-decl.sh {name-of-file-with-list-of-uses-stmts}.txt
```