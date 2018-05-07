#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <netdb.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <unistd.h>
// used nmap -p9000-9999 xavier.h4x0r.space -Pn to get port=9507
char *HOST = NULL;
char *PORT = NULL;

int main(int argc, char *argv[])
{

//  get server address info
struct addrinfo *results;
struct addrinfo  hints = {
.ai_family   = AF_UNSPEC,
.ai_socktype = SOCK_STREAM,
};

// parsing command line arguments
if (argc != 3) {
fprintf(stderr,"Usage: %s HOST PORT\n", argv[0]);
return EXIT_FAILURE;
}

HOST = argv[1];
PORT = argv[2];
//char buffer[1024] = {0};
//PORT = 9507;


 int status;
  if ((status = getaddrinfo(HOST, PORT, &hints, &results)) != 0) {
   fprintf(stderr, "getaddrinfo failed: %s\n", gai_strerror(status));
       return EXIT_FAILURE;
  }
        
        // allocate socket and try to connect
        int client_fd = -1;
        for (struct addrinfo *p = results; p != NULL && client_fd < 0; p = p->ai_next) {
        if ((client_fd = socket(p->ai_family, p->ai_socktype, p->ai_protocol)) < 0) {
        fprintf(stderr, "Unable to make socket: %s\n", strerror(errno));
        continue;
        }
        if (connect(client_fd, p->ai_addr, p->ai_addrlen) < 0) {
        fprintf(stderr, "Unable to connect to %s:%s: %s\n", HOST, PORT, strerror(errno));
        close(client_fd);
        client_fd = -1;
        continue;
        }
        //break;
        char *hello = "mryan29";
         //printf("Hello message sent\n");
        freeaddrinfo(results);
        //printf("%s\n",buffer );
        
        if (client_fd < 0) {
        return EXIT_FAILURE;
        }
  
        FILE *client_file = fdopen(client_fd, "w+");
        if (client_file == NULL) {
        fprintf(stderr, "Unable to fdopen: %s\n", strerror(errno));
        close(client_fd);
        return EXIT_FAILURE;
        }
        //char buffer[BUFSIZ];
		//send(client_fd , hello , strlen(hello) , 0 );
        	if(send(client_fd, hello, strlen(hello), 0) < 0) {
        		puts("Send failed");
       			 return 1;
        	} else {
        		printf("%s", hello);
        		fprintf(client_file, "%s", hello);
        	}
        close(client_fd);
        return EXIT_SUCCESS;
        }
        
}        
