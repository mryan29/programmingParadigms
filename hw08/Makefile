CC=		gcc
CFLAGS=		-g -gdwarf-2 -Wall -Werror -std=gnu99 -fPIC
LD=		gcc
LDFLAGS=	-L.
AR=		ar
ARFLAGS=	rcs
TARGETS=	duplicate search

all:		$(TARGETS)

test:		
	@$(MAKE) -sk test-all

test-all:	test-duplicate test-search

test-duplicate:	duplicate
	@curl -sLO https://gitlab.com/nd-cse-20289-sp18/cse-20289-sp18-assignments/raw/master/homework08/test_duplicate.sh
	@chmod +x test_duplicate.sh
	@./test_duplicate.sh

test-search:	search
	@curl -sLO https://gitlab.com/nd-cse-20289-sp18/cse-20289-sp18-assignments/raw/master/homework08/test_search.sh
	@chmod +x test_search.sh
	@./test_search.sh

clean:
	@echo Cleaning...
	@rm -f $(TARGETS) *.o

.SUFFIXES:

# TODO: Rules for duplicate and intermediate object files
duplicate:	duplicate_main.o duplicate_options.o
	@echo Compiling $@...
	$(LD) $(LDFLAGS) -o $@ $^

duplicate_main.o:	duplicate_main.c duplicate.h
	@echo Compiling $@...
	$(CC) $(CFLAGS) -c duplicate_main.c -o $@
	
duplicate_options.o:	duplicate_options.c duplicate.h
	@echo Compiling $@...
	$(CC) $(CFLAGS) -c duplicate_options.c -o $@



# TODO: Rules for search and intermediate object files
search:		search_filter.o search_main.o search_options.o search_utilities.o search_walk.o
	@echo Compiling $@...
	$(LD) $(LDFLAGS) -o $@ $^

search_filter.o:	search.h search_filter.c
	@echo Compiling $@...
	$(CC) $(CFLAGS) -c search_filter.c -o $@

search_main.o:	search.h search_main.c
	@echo Compiling $@...
	$(CC) $(CFLAGS) -c search_main.c -o $@

search_options.o:	search.h search_options.c
	@echo Compiling $@...
	$(CC) $(CFLAGS) -c search_options.c -o $@

search_utilities.o:	search.h search_utilities.c
	@echo Compiling $@...
	$(CC) $(CFLAGS) -c search_utilities.c -o $@
	
search_walk.o:	search.h search_walk.c
	@echo Compiling $@...
	$(CC) $(CFLAGS) -c search_walk.c -o $@
	

