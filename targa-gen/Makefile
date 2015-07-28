FILES = $(wildcard *.asm)
OBJ = $(FILES:.asm=.o)

all: targa-gen

targa-gen: $(OBJ)
	ld $^ -o $@

%.o: %.asm
	nasm -felf64 $< -o $@

clean:
	rm -f *.o *~ targa-gen

.PHONY: clean
