Project 02 - README
===================

Members
-------

- Josefa Osorio (josorio2@nd.edu)
- Eric Biscocho (ebiscoch@nd.edu)

Summary
-------
For this project, we used low-level system calls to create a basic HTTP client
in thor.py and a basic HTTP server in spidey.c. thor.py fetches the contents of
a URL using the HTTP protocol. It can run a specific number of processes and a
specific number of requests for each of those processes. It outputs the average
time for each process to run. spidey.c opens a socket on a specified port and
handles HTTP requests for all of the files in a path directory. Throughout the
program we use different functions to parse the request into a struct with its
appropriate field characteristics. We implemented different handle functions to
display all of the information on the server. For example, a requested URI can
be executed as a CGI script and be displayed to the client. Error messages were
also taken care of using various HTTP status codes. Finally if the forking flag
was used, then more than one client could access the server at the same time.

Latency
-------
| METHOD  | DIRECT LIST | STAT FILES | CGI SCRIPTS |
|---------|-------------|------------|-------------|
| Single  |        0.01 |       0.01 |        0.05 |
| Single  |        0.01 |       0.01 |        0.05 |
| Forking |        0.01 |       0.01 |        0.10 |
| Forking |        0.02 |       0.03 |        0.21 |
We measure the average latency using a test script. We found that the fastest
time between stimulation and response was for a single connection. We called
the thor.py script to measure the latency between the times of each request.

Throughput
----------
| METHOD  |  SMALL | MEDIUM | LARGE |
|---------|--------|--------|-------|
|  Single |   0.01 |   0.02 |  6.16 |
| Forking |   0.01 |   0.02 |  4.86 |   
We measured the average throughput using the same test script. We found that the
larger a static file is, the more beneficial forking mode becomes. For small
and medium files, there was no significance different between single connection
and forking mode.

Analysis
--------
After running our experiment script, forking took longer as expected but only
by a second or two. This is due to the fact that forking requires more
processes to be used and depending on the number of requests, it will take
longer than simply running a single process. Advantages of the forking model
are concurrency and time efficiency, as seen with large static files in the
throughput test. Disadvantage of the model are that it takes longer with
respect to latency with CGI scripts than with a single connection.

Conclusion
----------
We learned how to connect a client and a server using multiple scripts and
functions to parse a request into a struct. By doing this, we were able to call
various functions and check for different types of errors which eventually led
us to successfully create a server with a single connection and forking mode.
We also learned the significance of testing the throughput and latency in case
a request given contains a large file. In one of the programs, we also learned
to account for this because the size can vary depending on the request. Overall,
this was a very challenging project but very rewarding when finally being able
to access the material passed to the client. 

Contributions
-------------
Eric completed the Makefile, utils.c, socket.c, and single.c. Josefa completed
forking.c, thor.py, and experiments.sh. For request.c, handler.c, and spidey.c
we used pair programming.
