FC      = gfortran
PREFIX  = /usr/local
FFLAGS  = -Wall -fmax-errors=1
LDFLAGS = -I$(PREFIX)/include/lua53/ -L$(PREFIX)/lib/lua/5.3/
LDLIBS  = -llua-5.3
LIB     = lua.o
SLIB    = lua.so
