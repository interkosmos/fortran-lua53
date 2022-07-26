.POSIX:

FC      = gfortran
AR      = ar
FFLAGS  = -Wall `pkg-config --cflags lua-5.3`
ARFLAGS = rcs
LDFLAGS = `pkg-config --libs-only-L lua-5.3`
LDLIBS  = `pkg-config --libs-only-l lua-5.3`
TARGET  = libfortran-lua53.a

FIBONACCI = examples/fibonacci/fibonacci
LIBRARY   = examples/library/fortran.so
STRING    = examples/string/string
TABLE     = examples/table/table

.PHONY: all clean examples

all: $(TARGET)

examples: $(FIBONACCI) $(LIBRARY) $(STRING) $(TABLE)

$(TARGET):
	$(FC) $(FFLAGS) -fPIC -c src/lua.f90
	$(AR) $(ARFLAGS) $(TARGET) lua.o

$(FIBONACCI): $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(FIBONACCI) examples/fibonacci/fibonacci.f90 $(TARGET) $(LDLIBS)

$(LIBRARY): $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -fPIC -shared -o $(LIBRARY) examples/library/fortran.f90 $(TARGET)

$(STRING): $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(STRING) examples/string/string.f90 $(TARGET) $(LDLIBS)

$(TABLE): $(TARGET)
	$(FC) $(FFLAGS) $(LDFLAGS) -o $(TABLE) examples/table/table.f90 $(TARGET) $(LDLIBS)

clean:
	if [ `ls -1 *.mod 2>/dev/null | wc -l` -gt 0 ]; then rm *.mod; fi
	if [ `ls -1 *.o 2>/dev/null | wc -l` -gt 0 ]; then rm *.o; fi
	if [ -e $(TARGET) ]; then rm $(TARGET); fi
	if [ -e $(FIBONACCI) ]; then rm $(FIBONACCI); fi
	if [ -e $(LIBRARY) ]; then rm $(LIBRARY); fi
	if [ -e $(STRING) ]; then rm $(STRING); fi
	if [ -e $(TABLE) ]; then rm $(TABLE); fi
