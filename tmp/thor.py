#!/usr/bin/env python2.7

import multiprocessing
import os
import requests
import sys
import time

# Globals

PROCESSES = 1
REQUESTS  = 1
VERBOSE   = False
URL       = None
requestTime = 0
averageTime = 0

# Functions

def usage(status=0):
    print '''Usage: {} [-p PROCESSES -r REQUESTS -v] URL
    -h              Display help message
    -v              Display verbose output

    -p  PROCESSES   Number of processes to utilize (1)
    -r  REQUESTS    Number of requests per process (1)
    '''.format(os.path.basename(sys.argv[0]))
    sys.exit(status)

def do_request(pid):
    global URL
    average = 0
    for i in range(REQUESTS):
        start = time.time()
        result = requests.get(URL)
        end = time.time()
        average = average + end-start
        print 'Process: {}, Request: {}, Elapsed Time: {}'.format(pid, i, round(end-start, 2))
    average = average / REQUESTS
    print 'Process: {}, AVERAGE   , Elapsed Time: {}'.format(pid, round(average,2))

    return (average)

# Main execution
if __name__ == '__main__':
    # Parse command line arguments
    args = sys.argv[1:]
    while len(args) and args[0].startswith('-') and len(args[0]) > 1:
        arg = args.pop(0)
        if(arg == '-h'):
            usage(0)
        elif(arg == '-p'):
            PROCESSES = int(args.pop(0))
        elif(arg == '-r'):
            REQUESTS = int(args.pop(0))
        elif(arg == '-v'):
            VERBOSE = True
        else:
            usage(1)

    if(len(args)):
        URL = args.pop(0)
    else:
        usage(1)

    # Create pool of workers and perform requests
    if(VERBOSE):
        result = requests.get(URL)
        print result.text

    pool = multiprocessing.Pool(PROCESSES)
    requestTime = map(float,pool.imap(do_request,range(PROCESSES)))

    for x in requestTime:
        averageTime = averageTime + x

    averageTime = averageTime / PROCESSES
    print 'TOTAL AVERAGE ELAPSED TIME: {}'.format(round(averageTime,2))

# vim: set sts=4 sw=4 ts=8 expandtab ft=python:
