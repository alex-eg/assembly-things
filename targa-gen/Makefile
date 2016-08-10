FILES = $(wildcard *.asm)
OBJ = $(FILES:.asm=.o)
FORMAT := -felf64

all: targa-gen

targa-gen: $(OBJ)
	ld $^ -o $@

%.o: %.asm
	nasm $(FORMAT) $< -o $@

clean:
	rm -f *.o *~ targa-gen

.PHONY: clean
