%{
# include "romcalc.tab.h"
int yyerror(char *s);
int yylex();
%}

%%
"IIII"          { yyerror("syntax error"); }
"XXXX"          { yyerror("syntax error"); }
"CCCC"          { yyerror("syntax error"); }
"IVI"           { yyerror("syntax error"); }
"IXI"           { yyerror("syntax error"); }
"XLX"           { yyerror("syntax error"); }
"XCX"           { yyerror("syntax error"); }
"CDC"           { yyerror("syntax error"); }
"CMC"           { yyerror("syntax error"); }

"IV"            { yylval = 4;   return NUM; }
"IX"            { yylval = 9;   return NUM; }
"XL"            { yylval = 40;  return NUM; }
"XC"            { yylval = 90;  return NUM; }
"CD"            { yylval = 400; return NUM; }
"CM"            { yylval = 900; return NUM; }

"I"             { yylval = 1;   return NUM; }
"V"             { yylval = 5;   return NUM; }
"X"             { yylval = 10;  return NUM; }
"L"             { yylval = 50;  return NUM; }
"C"             { yylval = 100; return NUM; }
"D"             { yylval = 500; return NUM; }
"M"             { yylval = 1000;return NUM; }

"+"				{ return ADD; }
"-"				{ return SUBTRACT; }
"*"				{ return MULTIPLY; }
"/"				{ return DIVIDE; }
"{"             { return LEFT_PARENTHESIS; }
"}"				{ return RIGHT_PARENTHESIS; }

\n              { return EOL; }
.	            {  }
%%