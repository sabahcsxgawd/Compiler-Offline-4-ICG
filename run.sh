clear
yacc -d -y 1905118.y
echo 'Generated the parser C file as well the header file'
flex 1905118.l
echo 'Generated the scanner C file'
# g++ -std=c++17 -w -g lex.yy.c y.tab.c -fsanitize=address -o out
g++ -std=c++17 -w -g lex.yy.c y.tab.c -o out
echo 'Linked lex.yy.c and y.tab.c files, now running'
# ./out test1_i.c parsetree1.txt error1.txt log1.txt
# echo "-----------INPUT 1 DONE-----------"
./out test.c parsetree.txt error.txt log.txt code.asm optcode.asm
./out piyal_test.c parsetree.txt error.txt log.txt piyal_code.asm piyal_optcode.asm
./out Sample\ Input/test1_i.c parsetree.txt error.txt log.txt code1.asm optcode1.asm
./out Sample\ Input/test2_i.c parsetree.txt error.txt log.txt code2.asm optcode2.asm
./out Sample\ Input/test3_i.c parsetree.txt error.txt log.txt code3.asm optcode3.asm
./out Sample\ Input/test4_i.c parsetree.txt error.txt log.txt code4.asm optcode4.asm
./out Sample\ Input/test5_i.c parsetree.txt error.txt log.txt code5.asm optcode5.asm
./out Sample\ Input/bonustest1_i.c parsetree.txt error.txt log.txt codeb1.asm optcodeb1.asm
./out Sample\ Input/bonustest2_i.c parsetree.txt error.txt log.txt codeb2.asm optcodeb2.asm
echo "-----------INPUT DONE-----------"
