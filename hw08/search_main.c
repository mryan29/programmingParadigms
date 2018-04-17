/* search_main.c: Main Execution */

#include "search.h"
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
#include <dirent.h>


/* Main Execution */

int main(int argc, char *argv[]) {
    /* Parse options */
    
    // create and initialize options struct
	Options options = {
		.access = 0,
		.uid = -1,
		.gid = -1,
	};
	
	// check for proper usage
	int i = 2;
	char * progname = argv[0];
	char * arg = argv[i];
	
	if (argc < i) {
		options_usage(progname, 1);
		return 0;
	}
    /* Check root */
    while (i < argc) {
    	if (streq(arg, "-help")) { options_usage(progname, 0); return 0; }
		else if (streq(arg, "-executable")) { options.access |= X_OK; }
		else if (streq(arg, "-readable")) { options.access |= R_OK; }
		else if (streq(arg, "-writable")) { options.access |= W_OK; }
		else if (streq(arg, "-type")) { 
			i++;
			if (argv[i][0] == 'f') { options.type = S_IFREG; }
			else if (argv[i][0] == 'd') { options.type = S_IFDIR; } }
		else if (streq(arg, "-empty")) { options.empty = true; }
		else if (streq(arg,"-name")) { i++; options.name = argv[i]; }
		else if (streq(arg,"-path")) { i++; options.path = argv[i]; }
		else if (streq(arg,"-perm")) { i++; options.perm = strtol(argv[i],NULL,8); }
		else if (streq(arg,"-newer")) { i++; options.newer = get_mtime(argv[i]); }
		else if (streq(arg,"-uid")) { i++; options.uid = atoi(argv[i]); }
		else if (streq(arg,"-gid")) { i++; options.gid = atoi(argv[i]); }
		i++;
	}

    /* Walk root */
    if (!filter(argv[1], &options))
        //puts(argv[1]);
    walk(argv[1], &options);
    return EXIT_SUCCESS; 

}

/* vim: set sts=4 sw=4 ts=8 expandtab ft=c: */
