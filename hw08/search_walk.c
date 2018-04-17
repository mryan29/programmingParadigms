/* search_walk.c: Walk */

#include "search.h"
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <dirent.h>



/* Walk Functions */

/**
 * Recursively walk the root directory with specified options.
 * @param   root        Root directory path.
 * @param   options     User specified filter options.
 * @return  Whether or not walking this directory was successful.
 */
int         walk(const char *root, const Options *options) {
	DIR* dir = opendir(root);
	struct dirent *d;
	
	if (dir == NULL) { return EXIT_FAILURE; }
	
	while ((d = readdir(dir)) != NULL) {
		if (streq(d->d_name, ".") || streq(d->d_name, "..")) { continue; }
		
		char path[1000];
		sprintf(path, "%s/%s", root, d->d_name);
		
		if (!filter(path, options)) {
            //execute(path, settings);
            puts(path);
        }
        if (d->d_type == DT_DIR) { walk(path, options); }

	}
	closedir(dir);
	return EXIT_SUCCESS;
}

/* vim: set sts=4 sw=4 ts=8 expandtab ft=c: */
