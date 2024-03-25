# Compiler Design Lab

## Steps to execute
```
flex lexer.l
```
```
bison -dy parser.y
```
```
gcc y.tab.c lex.yy.c -o my_parser.exe
```
```
my_parser.exe < input.c
```
