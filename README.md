# capture-the-decl

### Description

capture-the-decl is a simple bash script that automates part of the process necessary when converting
module variables used in a procedure to dummy arguments for that procedure.
The script takes a text file with a list of use-stmts with only clauses as its only argument.
It searches the current directory for .f90 files with the same name as the modules to grab
the declarations for the module variables in the only clauses.
It copies the declarations to a new text file for use in adding dummy argument declarations.

**Note:** Ensure that the text file with the use statements has each use statement on a singular line, no matter how long.
The script does not currently deal with line continuations.

### Features to add

* Search for modules in directories other than current directory
* Deal with line continuations in the use statements

### Example Usage

```
./capture-the-decl.sh {name-of-file-with-list-of-uses-stmts}.txt
```