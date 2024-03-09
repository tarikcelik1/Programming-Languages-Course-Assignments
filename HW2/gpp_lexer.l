%{
   #include "gpp_interpreter.tab.h"
   #include <stdio.h>
   #include <string.h>
    
void yyerror(char const *s) {
    fprintf(stderr,"%s.\n", s);
}

 float convertStringtoFloat (char* text);
%}

%%
and     {return KW_AND;}
or      {return KW_OR;}
not     {return KW_NOT;}
equal   {return KW_EQUAL;}
less    {return KW_LESS; }
nil     {return KW_NIL;}
list    {return KW_LIST; }
append  {return KW_APPEND; }
concat  {return KW_CONCAT; }
set     {return KW_SET;}
def     {return KW_DEF;}
if      {return KW_IF;}
exit    {return KW_EXIT; }
for     {return KW_FOR; }
load    {return KW_LOAD;}
disp    {return KW_DISPLAY;}
true    {return KW_TRUE;}
false   {return KW_FALSE;}



"+"     {return OP_PLUS;}
"-"     {return OP_MINUS;}
"/"     {return OP_DIV;}
"*"     {return OP_MULT;}
"("     {return OP_OP;}
")"     {return OP_CP;}
","     {return OP_COMMA; }
" " {}


;;.* {return 0;}

[0-9][0-9]*[b][0-9]* {yylval.valuef = convertStringtoFloat(yytext);return VALUEF;}
[a-zA-Z_]+[a-zA-Z0-9_]* { strcpy(yylval.id ,yytext);return IDENTIFIER;}
. {return 0;}


\n {return 0;}
%%

float convertStringtoFloat (char* text)
{
    int index = 0;
    int digitCount = 0;
    int multiplier = 1;
    int readType = 0;
    float numerator = 0;
    float denominator = 0;

    while(text[index+1]!='\0')
    {
        ++index;
    }
        
    
    int num = 0;

    while(index!=-1)
    {
        multiplier = 1;
        if(text[index]=='b')
        {
            digitCount = 0;
            index--;
            readType = 1;
            continue;
        }

        int i;
        for(i=0;i<digitCount;++i)
        {
            multiplier *= 10;
        }

        int readNum = text[index]-'0';

        if(readType==0)
            denominator += readNum * multiplier;
        

        else
            numerator += readNum * multiplier;
        
        index--;
        digitCount++;
    }

    return numerator / denominator;

}

int yywrap(){}


yylex();

