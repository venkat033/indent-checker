The project is already compiled .
Run ./indent to run the project and enter the input.

INPUT :

start
	statements
	...
	...
	...		
end


To recompile the project :
lex indent.l
yacc -d indent.y
gcc lex.yy.c y.tab.c -ll -o filename
./filename