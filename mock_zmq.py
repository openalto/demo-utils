#!/usr/bin/env python
import zmq
import sys

print(sys.argv)
if len(sys.argv) <= 1:
    cmd = "siteA_s1 ping -c 4 siteA_d1 ; ping -c 4 siteA_d2 ;"
else:
    cmd = sys.argv[1]

context = zmq.Context()
socket = context.socket(zmq.REQ)
socket.connect('tcp://127.0.0.1:12333')
socket.send_string(cmd)
msg = socket.recv()
print(msg)

