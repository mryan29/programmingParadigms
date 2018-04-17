/* duplicate_main.c: Main Execution */

#include "duplicate.h"
#include <errno.h>
#include <limits.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>

extern FILE *stdin;
extern FILE *stdout;

/* Main Execution */

int         main(int argc, char *argv[]) {
    /* Parse options */
    
    
    // create and initialize options struct
	Options options = {
		.input_file = NULL,		//"/etc/passwd",	// path to input file
		.output_file = NULL,			//"./myfile.txt",	// path to output file
		.count = INT_MAX,				// num blocks to copy
		.bytes = DEFAULT_BYTES,			// size of each block
		.seek	= 0,					// num blocks to skip in output file
		.skip	= 0,					// num blocks to skip in input file
	};
	
	// check for proper usage
	//int i = 2;
	char * progname = argv[0];
	//char * input_file = NULL;
	
	if (argc < 2) {
		usage(progname, 1);
		return 0;
	}
	int i = 1;
    /* Parse Command Line Options */
    while (i < argc) {
    	char * arg = argv[i];
    	//int argsize = strlen(arg);
    	char *token = strtok(arg, "=");
    	if (streq(arg, "-help")) { usage(progname, 0); return 0; }
    	if (streq(token, "if")) { 
    		options.input_file = strtok(NULL, "=");
    	} else if (streq(token, "of")) {
    		options.output_file = strtok(NULL, "=");
    	} else if (streq(token, "count")) {
    		options.count = strtol(strtok(NULL, "="), NULL, 0);
    	} else if (streq(token, "bs")) {
    		options.bytes = strtol(strtok(NULL, "="), NULL, 0);
    	} else if (streq(token, "seek")) {
    		options.seek = strtol(strtok(NULL, "="), NULL, 0);
    	} else if (streq(token, "skip")) {
    		options.skip = strtol(strtok(NULL, "="), NULL, 0);
    	} else {
    		usage(progname, 1);
    	}
    	
		i++;
	}

	// Open the input and output files	
	int rfd; //= open(options.input_file, O_RDONLY);
	int wfd; //= open(options.output_file, O_CREAT|O_WRONLY, 0644);
	
	int nread, nwritten; 
	size_t blocksRead = 0;
	
	if (options.input_file == NULL) { rfd = 0; }
	else { rfd = open(options.input_file, O_RDONLY); }
	if (options.output_file == NULL) { wfd = 1; }
	else { wfd = open(options.output_file, O_CREAT|O_WRONLY, 0644); }
	if (rfd < 0 || wfd < 0) { 
		printf("Error opening input or output file.\n");
		return 1;
	}
	
	// allocate buffer w appropriate blocksize
	
	// perform skipping or seeking
	while (blocksRead < options.count) {
		char buf[options.bytes];
		lseek(rfd, options.skip*options.bytes, SEEK_CUR);
		nread = read(rfd, buf, options.bytes);
		lseek(wfd, options.seek*options.bytes, SEEK_CUR);
		nwritten = write(wfd, buf, nread);
		if (nwritten < 0 || nread < 0) {
			printf("Error reading or writing.\n");
			return 1;
		}
		
		if (nread == 0) { break; }
		
		blocksRead++;
	}
	

}

/* vim: set sts=4 sw=4 ts=8 expandtab ft=c: */
