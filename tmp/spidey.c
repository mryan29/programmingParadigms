/* spidey: Simple HTTP Server */

#include "spidey.h"

#include <errno.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>

/* Global Variables */
char *Port	      = "9898";
char *MimeTypesPath   = "/etc/mime.types";
char *DefaultMimeType = "text/plain";
char *RootPath	      = "www";
mode  ConcurrencyMode = SINGLE;
const char * PROGRAM_NAME = NULL;

/**
 * Display usage message.
 */
void
usage(const char *progname, int status)
{
    fprintf(stderr, "Usage: %s [hcmMpr]\n", progname);
    fprintf(stderr, "Options:\n");
    fprintf(stderr, "    -h            Display help message\n");
    fprintf(stderr, "    -c mode       Single or Forking mode\n");
    fprintf(stderr, "    -m path       Path to mimetypes file\n");
    fprintf(stderr, "    -M mimetype   Default mimetype\n");
    fprintf(stderr, "    -p port       Port to listen on\n");
    fprintf(stderr, "    -r path       Root directory\n");
    exit(status);
}

/**
 * Parses command line options and starts appropriate server
 **/
int
main(int argc, char *argv[])
{
    int c;
    int sfd;

    /* Parse command line options */
    c = 1;
    PROGRAM_NAME = argv[0];
    while (c < argc && strlen(argv[c]) > 1 && argv[c][0] == '-') {
          switch (argv[c][1]) {
              case 'h':
                  usage(PROGRAM_NAME, 0);
                  break;
              case 'c':
                  c++;
                  char mode = tolower(argv[c][0]);
                  switch(mode){
                    case 'f':
                      ConcurrencyMode = FORKING;
                      break;
                    case 'u':
                      ConcurrencyMode = UNKNOWN;
                      break;
                  }
                break;
              case 'm':
                  MimeTypesPath = argv[++c];
                  break;
              case 'M':
                  DefaultMimeType = argv[++c];
                  break;
              case 'p':
                  Port = argv[++c];
                  break;
              case 'r':
                  RootPath = argv[++c];
                  break;
              default:
                usage(PROGRAM_NAME, 1);
                break;
          }
          c++;
    }

    /* Listen to server socket */
    sfd = socket_listen(Port);
    if(sfd < 0){
      fprintf(stderr, "Unable to listen at Port %s: %s\n", Port, strerror(errno));
      return EXIT_FAILURE;
    }

    /* Determine real RootPath */
    RootPath = realpath(RootPath, NULL);

    log("Listening on port %s", Port);
    debug("RootPath        = %s", RootPath);
    debug("MimeTypesPath   = %s", MimeTypesPath);
    debug("DefaultMimeType = %s", DefaultMimeType);
    debug("ConcurrencyMode = %s", ConcurrencyMode == SINGLE ? "Single" : "Forking");

    /* Start either forking or single HTTP server */
    if (ConcurrencyMode == SINGLE) {
        single_server(sfd);
    } else if (ConcurrencyMode == FORKING) {
        forking_server(sfd);
    }

    free(RootPath);

    return EXIT_SUCCESS;
}

/* vim: set expandtab sts=4 sw=4 ts=8 ft=c: */
