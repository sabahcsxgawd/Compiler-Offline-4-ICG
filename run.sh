clear
yacc -d -y 1905118.y
echo 'Generated the parser C file as well the header file'
flex 1905118.l
echo 'Generated the scanner C file'
g++ -std=c++17 -w -g lex.yy.c y.tab.c -fsanitize=address -o out
# g++ -std=c++17 -w -g lex.yy.c y.tab.c -o out
echo 'Linked lex.yy.c and y.tab.c files, now running'
# ./out test1_i.c parsetree1.txt error1.txt log1.txt
# echo "-----------INPUT 1 DONE-----------"
./out test.c parsetree.txt error.txt log.txt code.asm
echo "-----------INPUT DONE-----------"