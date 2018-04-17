/* search_utilities.c: Utilities */

#include "search.h"
#include <errno.h>
#include <string.h>
#include <time.h>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>

/* Utility Functions */

/**
 * Checks whether or not the directory is empty.
 * @param   path    Path to directory.
 * @return  Whether or not the path is an empty directory.
 */
bool        is_directory_empty(const char *path) {
    DIR* directory = opendir(path);

    if (directory == NULL) { return false; }
    if (dirfd(directory) < 0) {
        fprintf(stderr, "ERROR : %s does not exist\n",path);
        _exit(1);
    }

    int count = 0;
    while (readdir(directory) != NULL) {
        count++;
    }
    return count <= 2;
}


/**
 * Retrieves modification time of file.
 * @param   path    Path to file.
 * @return  The modification time of the file.
 */
time_t      get_mtime(const char *path) {
    struct stat st = {0};
    int ret = lstat(path, &st);
    
    if (ret < 0) {
        fprintf(stderr, "ERROR: %s does not exist\n", path);
        _exit(1);    
    }
    
    return st.st_mtime;
}

/* vim: set sts=4 sw=4 ts=8 expandtab ft=c: */
