%{

#  include <stdio.h>
#  include <stdlib.h>
#  include <string.h>

int yyerror(char *s);
int yylex();
int yyparse();
int printRomanNumerals(int number);
void beforedigit(char x, char y);
void afterdidgit(char x, int y);

%}

%output "romcalc.tab.c"
%token NUM
%token LEFT_PARENTHESIS RIGHT_PARENTHESIS
%token ADD SUBTRACT MULTIPLY DIVIDE
%token EOL

%%

calclist:  {}
| calclist expr EOL { printRomanNumerals($2); }
;

expr: factor
| expr ADD factor                           { $$ = $1 + $3; }
| expr SUBTRACT factor                      { $$ = $1 - $3; }
;

factor: parenthesis
 | factor MULTIPLY parenthesis              { $$ = $1 * $3; }
 | factor DIVIDE parenthesis                { $$ = $1 / $3; }
 ;

parenthesis: value
| LEFT_PARENTHESIS expr RIGHT_PARENTHESIS   { $$ = $2; }
;

value: NUM
 | value NUM                                { $$ = $$ + $2;  }
 ;
%%

char text[1000];
int i = 0;
int printRomanNumerals(int number)
{
    int j;
    if (number < 0)
    {
        int positive = abs(number);
        printf("-");
        return printRomanNumerals(positive);
    }
    while (number != 0)
    {
        if (number >= 1000)
        {
            afterdidgit('M', number / 1000);
            number = number - ((number / 1000) * 1000);
        }
        else if (number >= 500)
        {
            if (number < (900))
            {
                afterdidgit('D', number / 500);
                number = number - ((number / 500) * 500);
            }
            else
            {
                beforedigit('C','M');
                number = number - (900);
            }
        }
        else if (number >= 100)
        {
            if (number < (400))
            {
                afterdidgit('C', number / 100);
                number = number - ((number / 100) * 100);
            }
            else
            {
                beforedigit('L', 'D');
                number = number - (400);
            }
        }
        else if (number >= 50 )
        {
            if (number < (90))
            {
                afterdidgit('L', number / 50);
                number = number - ((number / 50) * 50);
            }
            else
            {
                beforedigit('X','C');
                number = number - (90);
            }
        }
        else if (number >= 10)
        {
            if (number < (40))
            {
                afterdidgit('X', number / 10);
                number = number - ((number / 10) * 10);
            }
            else
            {
                beforedigit('X','L');
                number = number - (40);
            }
        }
        else if (number >= 5)
        {
            if (number < (9))
            {
                afterdidgit('V', number / 5);
                number = number - ((number / 5) * 5);
            }
            else
            {
                beforedigit('I', 'X');
                number = number - (9);
            }
        }
        else if (number >= 1)
        {
            if (number < 4)
            {
                afterdidgit('I', number / 1);
                number = number - ((number / 1) * 1);
            }
            else
            {
                beforedigit('I', 'V');
                number = number - (4);
            }
        }
    }
    for(j = 0; j < i; j++)
    {
        printf("%c", text[j]);
    }
    printf("\n");
    memset(text, 0, sizeof(text));
    i=0;
    return 0;
}

void beforedigit(char x, char y)
{
    text[i++] = x;
    text[i++] = y;
}

void afterdidgit(char x, int y)
{
    for (int j = 0; j < y; j++)
        text[i++] = x;
}

int yyerror(char *s)
{
  printf("%s\n", s);
  exit(0);
  return 0;
}


int
main()
{
  yyparse();
  return 0;
}