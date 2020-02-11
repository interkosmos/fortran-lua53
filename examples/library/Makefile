.POSIX:

-include ../../Makefile.inc

.PHONY: all

default: all

all:
	$(FC) $(FFLAGS) -fPIC -c ../../src/lua.f90
	$(FC) -Wno-unused-dummy-argument $(FFLAGS) $(LDFLAGS) -shared -fPIC -o fortran.so fortran.f90 $(LIB) $(LDLIBS)

clean:
	rm *.o *.mod *.so
