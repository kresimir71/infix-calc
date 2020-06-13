infix-calc
==========

Infix calculator written in C++ using flex and bison.


Changes in the 2020 version
===================================

Pure (reentrant parser) and pure (reentrant) scanner. Both parser and scanner with a configurable name prefix. Furthermore, line and column locations are added for extensive error messages. The parser can be either %glr-parser or a standard one.

To make and test:
```
make
make test
```

Used versions
---------------
```
bison --version
bison (GNU Bison) 3.0.4

flex --version
flex 2.6.4
```