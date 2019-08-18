#!/usr/bin/env python2

import sys
import time

if len(sys.argv) < 2:
	time.sleep(0.3)
	print('[>] missing argument! (./pumper.py [file] [size]')
	sys.exit(1)

file = sys.argv[1]
size = int(sys.argv[2])
f = open(file, 'ab')
pumpSize = size * 1048576
bufferSize = 256

for i in range(pumpSize/bufferSize):
    f.write(str('0' * bufferSize))
f.close();
time.sleep(0.3);
print('[>] pump completed!');
