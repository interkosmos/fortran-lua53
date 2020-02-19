.POSIX:

-include ../../Makefile.inc

.PHONY: all

default: all

all:
	$(FC) -I../../ $(FFLAGS) $(LDFLAGS) -o example example.f90 ../../$(LIB) $(LDLIBS)

clean:
	rm example
