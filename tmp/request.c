/* request.c: HTTP Request Functions */

#include "spidey.h"

#include <errno.h>
#include <string.h>

#include <unistd.h>
#include <stdio.h>

int parse_request_method(struct request *r);
int parse_request_headers(struct request *r);

/**
 * Accept request from server socket.
 *
 * This function does the following:
 *
 *  1. Allocates a request struct initialized to 0.
 *  2. Initializes the headers list in the request struct.
 *  3. Accepts a client connection from the server socket.
 *  4. Looks up the client information and stores it in the request struct.
 *  5. Opens the client socket stream for the request struct.
 *  6. Returns the request struct.
 *
 * The returned request struct must be deallocated using free_request.
 **/
struct request *
accept_request(int sfd)
{
    struct request *r;
    struct sockaddr raddr;
    socklen_t rlen = sizeof(struct sockaddr);

    /* Allocate request struct (zeroed) */
    r = calloc(1,sizeof(struct request));
    if(r == NULL){
      printf("ERROR: Can't allocate memory for map\n");
      goto fail;
    }

    /* Accept a client */
    r->headers = (struct header *) calloc(1,sizeof(struct header));

    int cliend_fd = accept(sfd, &raddr, &rlen);
    if(cliend_fd < 0){
      perror("Unable to accept\n");
      goto fail;
    }
    r->fd = cliend_fd;

    /* Lookup client information */
    //int flags = NI_NUMERICHOST | NI_NUMERICSERV;
    int status;
    if((status = getnameinfo(&raddr, sizeof(raddr), r->host, NI_MAXHOST, r->port, NI_MAXSERV, 0)) != 0){
      fprintf(stderr, "Unable to lookup request: %s\n", gai_strerror(status));
      goto fail;
    }

    /* Open socket stream */
    FILE *stream = fdopen(cliend_fd, "w+");
    if(stream == NULL){
      perror("Unable to fdopen");
      goto fail;
    }
    r->file = stream;

    log("Accepted request from %s:%s", r->host, r->port);
    return r;

fail:
    free_request(r);
    return NULL;
}

/**
 * Deallocate request struct.
 *
 * This function does the following:
 *
 *  1. Closes the request socket stream or file descriptor.
 *  2. Frees all allocated strings in request struct.
 *  3. Frees all of the headers (including any allocated fields).
 *  4. Frees request struct.
 **/
void
free_request(struct request *r)
{
    struct header *header;

    if (r == NULL) {
    	return;
    }

    /* Close socket or fd */
    if(r->file){
      if(fclose(r->file) != 0)
        exit(EXIT_FAILURE);
    }
    else{
      if(close(r->fd) != 0)
        exit(EXIT_FAILURE);
    }

    /* Free allocated strings */
    free(r->method);
    free(r->uri);
    free(r->path);
    if(r->query && strlen(r->query) > 0)
      free(r->query);

    /* Free headers */
    header = r->headers;
    struct header *curr = r->headers;
    while(curr != NULL){
      header = curr;
      curr = header->next;
      free(header->name);
      free(header->value);
      free(header);
    }

    /* Free request */
    free(r);
}

/**
 * Parse HTTP Request.
 *
 * This function first parses the request method, any query, and then the
 * headers, returning 0 on success, and -1 on error.
 **/
int
parse_request(struct request *r)
{
    /* Parse HTTP Request Method */
    if(parse_request_method(r) != 0){
      fprintf(stderr, "Error: request method failed %s\n", strerror(errno));
      return -1;
    }

    /* Parse HTTP Request Headers*/
    //int x = parse_request_headers(r);
    //puts(x);
    if(parse_request_headers(r) != 0){
      fprintf(stderr, "Error: request header failed %s\n", strerror(errno));
      return -1;
    }

    return 0;
}

/**
 * Parse HTTP Request Method and URI
 *
 * HTTP Requests come in the form
 *
 *  <METHOD> <URI>[QUERY] HTTP/<VERSION>
 *
 * Examples:
 *
 *  GET / HTTP/1.1
 *  GET /cgi.script?q=foo HTTP/1.0
 *
 * This function extracts the method, uri, and query (if it exists).
 **/
int
parse_request_method(struct request *r)
{
    /* Read line from socket */
    char buffer[BUFSIZ];
    if(fgets(buffer,BUFSIZ,r->file) == NULL){
      printf("ERROR: fgets failed in parse request method\n");
      return EXIT_FAILURE;
    }

    char *method = strtok(buffer, WHITESPACE);
    if(method == NULL){
      printf("Error: no method\n");//message with no method
      goto fail;
    }
    r->method = strdup(method);

    char *uriTemp = strtok(NULL, WHITESPACE);
    if(uriTemp == NULL){
      printf("No uri\n");
      goto fail;
    }

    char *uri = strtok(uriTemp, "?");
    char *query;
    if(uri)
      query = strtok(NULL, WHITESPACE);
    else{
      char * temp = skip_nonwhitespace(buffer);
      if(temp)
        uriTemp = skip_whitespace(temp);
      else
        goto fail;

      uri = strtok(uriTemp, WHITESPACE);
      query = NULL;
    }

    r->uri = strdup(uri);
    if(query)
      r->query = strdup(query);
    else
      r->query = "";


    debug("HTTP METHOD: %s", r->method);
    debug("HTTP URI:    %s", r->uri);
    debug("HTTP QUERY:  %s", r->query);

    return 0;

fail:
    return -1;
}

/**
 * Parse HTTP Request Headers
 *
 * HTTP Headers come in the form:
 *
 *  <NAME>: <VALUE>
 *
 * Example:
 *
 *  Host: localhost:8888
 *  User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:29.0) Gecko/20100101 Firefox/29.0
 *  Accept: text/html,application/xhtml+xml
 *  Accept-Language: en-US,en;q=0.5
 *  Accept-Encoding: gzip, deflate
 *  Connection: keep-alive
 *
 * This function parses the stream from the request socket using the following
 * pseudo-code:
 *
 *  while (buffer = read_from_socket() and buffer is not empty):
 *      name, value = buffer.split(':')
 *      header      = new Header(name, value)
 *      headers.append(header)
 **/
 //checked by bill
int
parse_request_headers(struct request *r)
{
    struct header *curr = NULL;
    char buffer[BUFSIZ];
    char *name;
    char *value;

    /* Parse headers from socket */
    while(fgets(buffer, BUFSIZ, r->file) && strlen(skip_whitespace(buffer))){ //check if its /r/n
      chomp(buffer);
      name = strtok(buffer, ":");
      value = strtok(NULL,"\n");
      if(value == NULL){
        printf("Error: no name\n");//message for no name
        goto fail;
      }

      //*value++ = '\0';
      value = skip_whitespace(value);

      curr = calloc(1,sizeof(struct header));
      if(curr == NULL){
        fprintf(stderr, "Unable to allocate memory: %s\n", strerror(errno));
        goto fail;
      }
      curr->name = strdup(name);
      curr->value = strdup(value);
      curr->next = r->headers;
      r->headers = curr;
    }

#ifndef NDEBUG
    for (struct header *header = r->headers; header != NULL; header = header->next) {
    	debug("HTTP HEADER %s = %s", header->name, header->value);
    }
#endif
    return 0;

fail:
    return -1;
}

/* vim: set expandtab sts=4 sw=4 ts=8 ft=c: */
