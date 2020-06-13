/* 
  This file is part of infix-calc:
  Infix calculator written in C++ using flex and bison. 
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
#include "global.h"
#include "translator.hpp"  
#include "tokens.h"

int main(int argc, char **argv)
{

  ++argv; --argc;
  if (argc == 0)
    {
      yyscan_t scanner;

      _yy(lex_init)( &scanner );
      _yy(set_in)( stdin, scanner );
      _yy(parse)(scanner);
      _yy(lex_destroy)( scanner );
    } 
  else 
    while (argc-- > 0)
      {
	yyscan_t scanner;

	_yy(lex_init)( &scanner );
	FILE* yyin1 = fopen(argv[0], "r");
	if (!yyin1)
	  {
	    printf("Can't open file %s", argv[0]);
	    return 1;
	  }
	_yy(set_in)( yyin1 ,scanner );
	_yy(parse)(scanner);
	_yy(lex_destroy)( scanner );
	++argv;
      }
  return 0;
}

void _yy(error)(YYLTYPE* l, yyscan_t scanner,const char *s)
{
  std::cout<<"ERROR: " << s << "\n";
  printf("LINES %d-%d, COLUMNS %d-%d\n", l->first_line, l->last_line, l->first_column, l->last_column);	
}
