CC=g++
CFLAGS=-Wall
LDFLAGS=-lfl
SRCS=main.cpp tokens.cpp translator.cpp
OBJS=$(SRCS:.cpp=.o)
LEX=flex
SYN=bison
PROGRAM=infix-calc

all: $(PROGRAM) 

$(PROGRAM): $(OBJS)
	$(CC) $^ -o $@ $(LDFLAGS)

main.o: main.cpp translator.cpp tokens.cpp
	$(CC) $(CFLAGS) -c -o $@ $<

.cpp.o:
	$(CC) $(CFLAGS) -c -o $@ $<

tokens.cpp: tokens.l translator.cpp
	$(LEX) -o $@ $<

translator.cpp: translator.y
	$(SYN) -d -o $@ $<

test: $(PROGRAM) 
	./$(PROGRAM) tests.txt

clean:
	-rm *.o $(PROGRAM) translator.cpp tokens.cpp translator.hpp tokens.h
