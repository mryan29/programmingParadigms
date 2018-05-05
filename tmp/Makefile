CC=		gcc
CFLAGS=		-g -gdwarf-2 -Wall -std=gnu99
LD=		gcc
LDFLAGS=	-L.
TARGETS=	spidey

all:		$(TARGETS)

forking.o: forking.c spidey.h
	@echo "Compiling $@..."
	@$(CC) $(CFLAGS) -c -o forking.o forking.c

handler.o: handler.c spidey.h
	@echo "Compiling $@..."
	@$(CC) $(CFLAGS) -c -o handler.o handler.c

request.o: request.c spidey.h
	@echo "Compiling $@..."
	@$(CC) $(CFLAGS) -c -o request.o request.c

single.o: single.c spidey.h
	@echo "Compiling $@..."
	@$(CC) $(CFLAGS) -c -o single.o single.c

socket.o: socket.c spidey.h
	@echo "Compiling $@..."
	@$(CC) $(CFLAGS) -c -o socket.o socket.c

spidey.o: spidey.c spidey.h
	@echo "Compiling $@..."
	@$(CC) $(CFLAGS) -c -o spidey.o spidey.c

utils.o: utils.c spidey.h
	@echo "Compiling $@..."
	@$(CC) $(CFLAGS) -c -o utils.o utils.c

spidey: forking.o handler.o request.o single.o socket.o spidey.o utils.o
	@echo "Linking $@..."
	@$(LD) $(LDFLAGS) -o spidey forking.o handler.o request.o single.o socket.o spidey.o utils.o

clean:
	@echo Cleaning...
	@rm -f $(TARGETS) *.o *.log *.input

.PHONY:		all clean
