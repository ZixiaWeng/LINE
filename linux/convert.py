import numpy as np
import sys
#with open(sys.argv[1], 'r') as f:

def convert():
    b = np.fromfile(sys.argv[2], dtype=np.int32)
#	b.reshape(,200)
    np.save(sys.argv[4],b)

convert()
