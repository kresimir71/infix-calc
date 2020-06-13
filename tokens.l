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

#include <stdlib.h>
#include <iostream>
#include "global.h"
#include "translator.hpp"

// yylineno and yycolumn are set internally by flex to 1 and 0 in the beginning 
#define YY_USER_ACTION {yylloc->first_line = yylineno; yylloc->first_column = yycolumn; yylloc->last_column=yycolumn+yyleng;yycolumn=yycolumn+yyleng; yylloc->last_line = yylineno;}

%}

%option prefix="y20infixcalc_"

%option noyywrap 
/*(in which case the scanner behaves as though 'yywrap()' returned 1), or you must link with '-lfl' to obtain the default version of the routine, which always returns 1.*/

/*  %option yylineno // Should do increasing yylineno auto, not needed and also causes problems with yycolumn? */

%option reentrant
%option header-file="tokens.h"
%option bison-bridge
%option bison-locations

%x IN_COMMENT

%%
<INITIAL>{
    [ \t]
    "#"                     ECHO; BEGIN(IN_COMMENT);
    [0-9]+(\.[0-9]+)?       ECHO; *yylval = atof(yytext); return NUMBER;
    "+"                     ECHO; return PLUS;
    "-"                     ECHO; return MINUS;
    "*"                     std::cout << "*"; return MUL;
    "/"                     ECHO; return DIV;
    "^"                     ECHO; return POW;
    "("                     ECHO; return LBRACE;
    ")"                     ECHO; return RBRACE;
    \n                      ECHO; yylineno++;yycolumn=0;return EOL;
    .         
}
<IN_COMMENT>{
    \n                      ECHO; yylineno++;yycolumn=0;BEGIN(INITIAL);
}           
%%
