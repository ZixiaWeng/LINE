import numpy as np

def convert():
    b = np.fromfile('line_blog.txt', dtype=np.int32)
#	b.reshape(,200)
    np.save('line_blog.npy',b)

convert()
