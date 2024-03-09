Makefile:
	@bison -d gpp_interpreter.y
	@flex gpp_lexer.l
	@gcc lex.yy.c gpp_interpreter.tab.c -o out
	@echo "-----------------------------------------------"
	@./out