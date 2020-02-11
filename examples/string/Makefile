.POSIX:

-include ../../Makefile.inc

.PHONY: all

default: all

all:
	$(FC) -I../../ $(FFLAGS) $(LDFLAGS) -o string string.f90 ../../$(LIB) $(LDLIBS)

clean:
	rm string
