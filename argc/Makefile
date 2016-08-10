LD = ld
AS = as
LD_L = -dynamic-linker /lib/ld-linux-x86-64.so.2 /usr/lib/crt1.o /usr/lib/crti.o /usr/lib/crtn.o -lc

argc: argc.o
	$(LD) -o argc argc.o

argc_libc: argc.o
	$(LD) $(LD_L) argc.o -o argc

argc.o:  argc.s
	$(AS) -o argc.o argc.s

clean:
	rm -rf ./*.o ./argc
