/* forking.c: Forking HTTP Server */

#include "spidey.h"

#include <errno.h>
#include <signal.h>
#include <string.h>

#include <unistd.h>

/**
 * Fork incoming HTTP requests to handle the concurrently.
 *
 * The parent should accept a request and then fork off and let the child
 * handle the request.
 **/
void
forking_server(int sfd)
{
    struct request *request;
    pid_t pid;

    /* Accept and handle HTTP request */
    while (true) {
    	/* Accept request */
      debug("Accepting client request");
      request = accept_request(sfd); //returns struct request (should we change it? will it still work?)
      signal(SIGCHLD, SIG_IGN);
      if(request == NULL)
        continue;

      pid = fork();
      if(pid == 0){
        debug("Handling client request");
        close(sfd);
        handle_request(request);
        exit(EXIT_SUCCESS);
      }
      else if(pid > 0){
        free_request(request);
      }
      else {
        exit(EXIT_FAILURE);
      }
    }
    /* Close server socket and exit*/
    close(sfd);
    exit(EXIT_SUCCESS);
}

/* vim: set expandtab sts=4 sw=4 ts=8 ft=c: */
