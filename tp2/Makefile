all : inter

inter : es.o inter.o
	simgcc -g -o inter inter.o es.o

inter.o : inter.s
	simgcc -c inter.s

es.o : es.s
	simgcc -c es.s

