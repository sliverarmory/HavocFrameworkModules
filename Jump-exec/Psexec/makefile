BOF 	  := psexec
CC_x64    := x86_64-w64-mingw32-gcc
CC_x86    := i686-w64-mingw32-gcc
STRIP_x64 := x86_64-w64-mingw32-strip
STRIP_x86 := i686-w64-mingw32-strip

all:
	$(CC_x64) -o bin/$(BOF).x64.o -c $(BOF).c
	$(STRIP_x64) --strip-unneeded bin/$(BOF).x64.o
	$(CC_x86) -o bin/$(BOF).x86.o -c $(BOF).c
	$(STRIP_x86) --strip-unneeded bin/$(BOF).x86.o

clean:
	rm bin/$(BOF).o