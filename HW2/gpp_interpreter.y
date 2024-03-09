%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

extern FILE * yyin;    

        void yyerror (char *s);
int yylex();

struct idvalue
{
        char id[50];
        float valuef;
};

struct list
{
        struct idvalue *pairs;
        int number;
};


struct list *variables;
struct list *funcs;

void startList()
{
        variables = (struct list*)malloc(sizeof(struct list));
        funcs = (struct list*)malloc(sizeof(struct list));
}

int checkIdExist(char id[50])
{
        int i;
        for(i=0;i<variables->number;i++)
        {
                if(strcmp(id, variables->pairs[i].id)==0)
                        return i;
        }

        return -1;
}

int checkFuncExist(char id[50])
{
        int i;
        for(i=0;i<funcs->number;i++)
        {
                if(strcmp(id, funcs->pairs[i].id)==0)
                        return i;
        }

        return -1;
}

float valueOfId(char id[50])
{
        int i;
        for(i=0;i<variables->number;i++)
        {
                if(strcmp(id, variables->pairs[i].id)==0)
                        variables->pairs[i].valuef;
        }
}

float valueOfFunc(char id[50])
{
        int i;
        for(i=0;i<funcs->number;i++)
        {
                if(strcmp(id, funcs->pairs[i].id)==0)
                        return funcs->pairs[i].valuef;
        }
        return 0;
}

void addList(float value, char id[50])
{
        struct idvalue *pairs;

        pairs = (struct idvalue*)calloc(variables->number + 1, sizeof(struct idvalue));

        int i;
        for(i=0;i<variables->number;i++)
        {
                strcpy(pairs[i].id, variables->pairs[i].id);
                pairs[i].valuef = variables->pairs[i].valuef;
        }

        strcpy(pairs[i].id, id);
        pairs[i].valuef = value;

        variables->pairs = pairs;
        variables->number += 1;
}

void addListFuncs(char id[50],float num)
{
        struct idvalue *pairs;

        pairs = (struct idvalue*)calloc(funcs->number + 1, sizeof(struct idvalue));

        int i;
        for(i=0;i<funcs->number;i++)
        {
                strcpy(pairs[i].id, funcs->pairs[i].id);
                pairs[i].valuef = funcs->pairs[i].valuef;
        }

        strcpy(pairs[i].id, id);
        pairs[i].valuef = num;

        funcs->pairs = pairs;
        funcs->number += 1;
}

void updateList(float value, char id[50], int index)
{
        strcpy(variables->pairs[index].id, id);
        variables->pairs[index].valuef = value;
}

void displayResult(double result) {
    printf("Result: %.3f\n",result);
}

void printResultofExp(float result){

        if(result == -404.0){}
        else{
                printf("Result: %.3f\n",result);
        }
}

%}

%union{
    char id[50];
    float valuef;
}

%start START
%token KW_SET
%token KW_AND
%token KW_OR
%token KW_NOT
%token KW_DEF
%token KW_FOR
%token KW_EQUAL
%token KW_LIST
%token KW_APPEND
%token KW_CONCAT
%token KW_LESS
%token KW_IF
%token KW_EXIT
%token KW_LOAD
%token KW_DISPLAY
%token KW_TRUE
%token KW_FALSE
%token KW_NIL

%token OP_PLUS
%token OP_MINUS
%token OP_DIV
%token OP_MULT
%token OP_CP
%token OP_OP
%token OP_COMMA



%token COMMENT
%token <valuef> VALUEF
%token <id> IDENTIFIER

%type <valuef> EXP
%type <valuef> FUNCTION
%type <valuef> EXPF



%%
START: INPUT |
INPUT:
        FUNCTION {printf("#Function\n"); } |
        EXP {printResultofExp($1);} |
        OP_OP KW_EXIT OP_CP { exit(0); }

EXP:
        OP_OP OP_PLUS EXP EXP OP_CP {$$ = $3 + $4;} |
        OP_OP OP_MINUS EXP EXP OP_CP {$$ = $3 - $4;}|
        OP_OP OP_MULT EXP EXP OP_CP {$$ = $3 * $4;}|
        OP_OP OP_DIV EXP EXP OP_CP {$$ = $3 / $4;}|
        OP_OP KW_DISPLAY EXP OP_CP {$$ = $3; displayResult($$); }|
        OP_OP KW_AND EXP EXP OP_CP {$$ = $3 && $4;} |
        OP_OP KW_OR EXP EXP OP_CP {$$ = $3 || $4;} |
        OP_OP KW_EQUAL EXP EXP OP_CP {$$ = ($3 == $4);} |
        OP_OP KW_SET IDENTIFIER EXP OP_CP {$$=$4; addList($4,$3);} |
        OP_OP KW_IF EXP EXP EXP OP_CP {$$ = ($3 == 1) ? $4 : $5;} |
                OP_OP IDENTIFIER OP_CP 
        {
        if(checkFuncExist($2)==-1)
        {
                printf("There is no function named %s\n", $2);
                exit(1);
        }
        
        $$ = valueOfFunc($2);
        } |

        OP_OP IDENTIFIER EXP OP_CP {if(checkFuncExist($2)==-1)
        {
                printf("There is no function named %s\n", $2);
                exit(1);
        }
        $$ = valueOfFunc($2) + $3;} |

        OP_OP IDENTIFIER EXP EXP OP_CP {if(checkFuncExist($2)==-1)
        {
                printf("There is no function named %s", $2);
                exit(1);
        }
        $$ = $4+$3;} |
        IDENTIFIER
        {
        int index = checkIdExist($1);

        if(index!=-1)
        {
                struct idvalue target = variables->pairs[index];
                $$ = target.valuef;
        }
        else
        {
                printf("No identifier named %s\n", $1);
                $$ = -404.0;
        }
        
        } | 
        VALUEF {$$ = $1;} 

EXPF:   EXP {$$ = $1;} |
        OP_OP OP_PLUS IDENTIFIER EXP OP_CP {$$ = valueOfId($3) + $4;} |
        OP_OP OP_PLUS EXP IDENTIFIER OP_CP {$$ = valueOfId($4) + $3;} |
        OP_OP OP_PLUS IDENTIFIER IDENTIFIER OP_CP {$$ = valueOfId($3) + valueOfId($4);}
 

FUNCTION:
        OP_OP KW_DEF IDENTIFIER EXPF OP_CP{addListFuncs($3,$4); $$ = $4;}|
        OP_OP KW_DEF IDENTIFIER IDENTIFIER EXPF OP_CP{addListFuncs($3,$5); $$ = $5;}|
        OP_OP KW_DEF IDENTIFIER IDENTIFIER IDENTIFIER EXPF OP_CP{addListFuncs($3,$6); $$ = $6;} 
    
%%
        

int main(int argc, char **argv)
{       
        FILE * in_stream = NULL;
        startList();
        if (argc == 1) {
                in_stream = stdin;
        }
        else {
                in_stream = fopen(argv[1], "r");
                if (!in_stream) {
                        printf("File \"%s\" cannot find or open\n", argv[1]);
                return 1;
                }
        }
        yyin = in_stream;
        while(1){
        
                        yyparse();
    }
}