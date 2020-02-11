.POSIX:
.SUFFIXES:

-include Makefile.inc

.PHONY: all clean file library string

default: all

examples: file library string

all: $(LIB) $(SLIB)

$(LIB):
	$(FC) $(FFLAGS) -c src/lua.f90

$(SLIB):
	$(FC) $(FFLAGS) $(LDFLAGS) -shared -fPIC -o $(SLIB) src/lua.f90 $(LDLIBS)

file:
	$(MAKE) -C examples/file/

library:
	$(MAKE) -C examples/library/

string:
	$(MAKE) -C examples/string/

clean:
	rm *.o *.mod
	$(MAKE) -C examples/file/ clean
	$(MAKE) -C examples/library/ clean
	$(MAKE) -C examples/string/ clean
