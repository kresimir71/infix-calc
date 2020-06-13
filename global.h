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

#define _YY(X) Y20INFIXCALC_ ## X
#define _yy(X) y20infixcalc_ ## X

#define Y20INFIXCALC_STYPE double

#ifndef YYSTYPE
#define YYSTYPE Y20INFIXCALC_STYPE
#endif

#ifndef YYLTYPE
#define YYLTYPE Y20INFIXCALC_LTYPE
#endif

typedef void* yyscan_t;


