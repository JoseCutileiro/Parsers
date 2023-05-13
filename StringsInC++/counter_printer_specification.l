%option 8bit noyywrap yylineno stack
%{
#include <iostream>
inline void yyerror(const char *msg) {
  std::cerr << "Error at " << yylineno << ": " << msg << std::endl;
}
%}
%x X_CHAR X_STRING X_COMMENT
%%

\'              yy_push_state(X_CHAR);
<X_CHAR>\\\'  ;
<X_CHAR>\'     yy_pop_state();
<X_CHAR>.  ;
<X_CHAR>\n    yyerror("newline in character constant");

\"              yy_push_state(X_STRING); std::cout << std::endl << yylineno << ": ";
<X_STRING>\\\"  ECHO;
<X_STRING>\\\\  ECHO;
<X_STRING>\"    yy_pop_state();
<X_STRING>.     ECHO;
<X_STRING>\n    yyerror("newline in string");

"/*"            yy_push_state(X_COMMENT);
<X_COMMENT>"*/" yy_pop_state();
<X_COMMENT>.|\n ;

"//".*$         ;

.|\n            ; /* ignore the rest */

%%
int main() {
  yylex();
  std::cout << "\n";
}