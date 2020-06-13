%{
    /* 
      This file is part of rpn-calc:
      Reverse Polish notation (RPN) calculator written in C++ using flex and bison. 
      Copyright (C) 2013 nikagra <nikagra@gmail.com>
      Copyright (C) 2020 K.Karamazen <karamazen@abec.info>        

      This program is free software: you can redistribute it and/or modify
      it under the terms of the GNU General Public License as published by
      the Free Software Foundation, either version 3 of the License, or
      (at your option) any later version.
    
      This program is distributed in the hope that it will be useful,
      but WITHOUT ANY WARRANTY; without even the implied warranty of
      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
      GNU General Public License for more details.
    
      You should have received a copy of the GNU General Public License
      along with this program. If not, see <http://www.gnu.org/licenses/>.
    */

    #include <iostream>
    #include <math.h>
    #include "global.h"
    #include "translator.hpp"  
    #include "tokens.h"

    extern void yyerror(YYLTYPE*, yyscan_t scanner, char const *);  
%}

%glr-parser
%define api.pure true  /* 'true' because 'full' conflicts with glr-parser */

%define api.prefix {y20infixcalc_}

%locations  /* line and culumn numbers are calculated also internally in the parser, see 3.5.3 Default Action for Locations */

%lex-param { yyscan_t scanner }
%parse-param { yyscan_t scanner }

%token NUMBER LBRACE RBRACE EOL
%left PLUS MINUS 
%left MUL DIV 
%left NEG
%right POW

/* 
 *Grammar rules and actions follow.
 */
%%
input:
      /* empty */
    | input line
    ;
 
line:
      EOL
      | expr EOL      { std::cout << " = " << $$ << "\n"; }
    | error EOL
    ;
     
expr:
      NUMBER                { $$ = $1; }
    | expr PLUS expr        { $$ = $1 + $3; }
    | expr MINUS expr       { $$ = $1 - $3; }
    | expr MUL expr         { $$ = $1 * $3; }
    | expr DIV expr         { $$ = $1 / $3; }
    | MINUS  expr %prec NEG { $$ = -$2; }
    | expr POW expr         { $$ = pow($1, $3); }
    | LBRACE expr RBRACE    { $$ = $2; }
    ;
%%

