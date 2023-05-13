%option 8bit noyywrap yylineno stack
%{
#include <iostream>

int var = 0;

inline void yyerror(const char *msg) {
  std::cerr << "Error at " << yylineno << ": " << msg << std::endl;
}
%}

%x X_PAR

%%

"("             yy_push_state(X_PAR);
<X_PAR>"("      yy_push_state(X_PAR);
<X_PAR>")"      yy_pop_state();
<X_PAR>"EOF"     var = 1;
<X_PAR>.      ;
<X_PAR>\n     ;
")"             var = 1;



.|\n            ; /* ignore the rest */

%%
int main() {
  yylex();

  if (var == 1) {
    printf("ERROR\n");
  }
  else {
    printf("VALID\n");
  }
}