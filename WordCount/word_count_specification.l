%option noyywrap stack

%{
    #include "stdio.h"
    #include "stdlib.h"

    int w = 0;      // number of words
    int c = 0;      // number of chars
    int l = 1;      // number of lines
%}

WORD        [^ \n\t]+

%%

{WORD}+     {w++;c+=yyleng;}
[\n]        {l++;}

%% 

int main() {
    yylex();
    printf("\nWORDS: %d\nCHARS: %d\nLINES: %d\n", w,c,l);
    return 0;
}