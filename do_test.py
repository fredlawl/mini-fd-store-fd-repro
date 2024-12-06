#!/usr/bin/env python3
import sys
from systemd.daemon import notify
import socket
import time
import os

print(sys.argv[1])

if sys.argv[1] == 'setup':
    max = 1 if len(sys.argv) < 3 else int(sys.argv[2])
    for i in range(0, max):
        fds = []
        for j in range(0, 3):
            fds.append(socket.socket(socket.AF_INET, socket.SOCK_DGRAM))
        sock_name = f"test_{i}"
        notify(f"FDSTOREREMOVE=1\nFDNAME={sock_name}")
        notify(f"FDSTORE=1\nFDNAME={sock_name}", fds=[f.fileno() for f in fds])

    exit(0)

notify(f"READY=1\nSTATUS=unit started\nMAINPID={os.getpid()}")

while True:
    print(sys.argv[1])
    time.sleep(2)

exit(0)
