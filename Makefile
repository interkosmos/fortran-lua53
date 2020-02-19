.POSIX:
.SUFFIXES:

-include Makefile.inc

.PHONY: all clean file library string

default: all

examples: file library string

all: $(LIB)

$(LIB):
	$(FC) $(FFLAGS) -c src/lua.f90

fibonacci:
	$(MAKE) -C examples/fibonacci/

library:
	$(MAKE) -C examples/library/

string:
	$(MAKE) -C examples/string/

clean:
	rm *.mod *.o
	$(MAKE) -C examples/fibonacci/ clean
	$(MAKE) -C examples/library/ clean
	$(MAKE) -C examples/string/ clean
