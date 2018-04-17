/* search_filter.c: Filters */

#include "search.h"
#include <errno.h>
#include <fcntl.h>
#include <glob.h>
#include <libgen.h>
#include <string.h>
#include <dirent.h>
#include <fnmatch.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdlib.h>
#include <unistd.h>

/* Internal Filter Functions */

bool        filter_access(const char *path, const struct stat *stat, const Options *options) {
    return options->access && access(path, options->access) != 0;
}

bool		filter_type(const char *path, const struct stat *stat, const Options *options) {
	//return options->type && (stat->st_mode & S_IFMT) != options->type;
	if ((stat->st_mode & S_IFMT) != options->type) { return true; }
	return false;

}

bool		filter_empty(const char *path, const struct stat *stat, const Options *options) {
	if(options->empty){
        //check for directory
        if(S_ISDIR(stat->st_mode)!=0) {
            if(!is_directory_empty(path)) { return true; }
        }
        //check for regular file
         //if(temp.st_size!=settings->empty)
        else if (S_ISREG(stat->st_mode)!=0)  {
            if (stat->st_size != 0) { return true; }
       } else  { return true; }
    }
    return false;
}

bool	filter_name(const char *path, const struct stat *stat, const Options *options) {
	char* name=strrchr(path,'/');
    if(fnmatch(options->name,name,0)!=0) { return true; }
    return false;
}

bool	filter_path(const char *path, const struct stat *stat, const Options *options) {
	if (fnmatch(options->path,path,0)!=0) { return true; }
	return false;
}

bool	filter_perm(const char *path, const struct stat *stat, const Options *options) {
	if (options->perm != 0 && ((S_IRWXU | S_IRWXG | S_IRWXO) & stat->st_mode) != options->perm) { return true; }
 	return false;
}

bool	filter_newer(const char *path, const struct stat *stat, const Options *options) {
	if(options->newer && stat->st_mtime<=options->newer) { return true; }
	return false;
}

bool	filter_uid(const char *path, const struct stat *stat, const Options *options) {
	if (options->uid > -1 && stat->st_uid != options->uid) { return true; }
	return false;
}

bool	filter_gid(const char *path, const struct stat *stat, const Options *options) {
	if(options->gid > -1 && stat->st_gid != options->gid) { return true; }
	return false;
}



FilterFunc FILTER_FUNCTIONS[] = {   /* Array of function pointers. */
    filter_access,
    filter_type,
    filter_empty,
    filter_name,
    filter_path,
    filter_perm,
    filter_newer,
    filter_uid,
    filter_gid,
    NULL,
};

/* External Filter Functions */

/**
 * Filter path based options.
 * @param   path        Path to file to filter.
 * @param   options     Pointer to Options structure.
 * @return  Whether or not the path should be filtered out (false means include
 * it in output, true means exclude it from output).
 */
bool	    filter(const char *path, const Options *options) {
    struct stat stat;
    
    // perform lstat on given path
    if (lstat(path, &stat) != 0) { return true; }
    	
    
    return ( filter_access(path, &stat, options) &&
    		filter_type(path, &stat, options) && 
    		filter_empty(path, &stat, options) &&
   			filter_name(path, &stat, options) &&
    		filter_path(path, &stat, options) &&
    		filter_perm(path, &stat, options) &&
    		filter_newer(path, &stat, options) &&
    		filter_uid(path, &stat, options) &&
    		filter_gid(path, &stat, options)
    		);
    
}
/* vim: set sts=4 sw=4 ts=8 expandtab ft=c: */
