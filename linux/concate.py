import numpy as np
import sys

def concat():

#   b = np.fromfile(sys.argv[0], sys.argv[1], dtype=np.int32)
# # b.reshape(,200)
#     np.save(sys.argv[4],b)
    x = convert_embed_to_np(sys.argv[1])
    y = convert_embed_to_np(sys.argv[2])
    print '@@@', x.shape, y.shape
    result = np.concatenate((x, y), axis=1)
    print result.shape
    np.save(sys.argv[3], result)
    np.savetxt(sys.argv[4],result)


def convert_embed_to_np(emb_file, ignore_last=False):
    print 'Convert %s' % (emb_file)
    with open(emb_file) as f:
        lines = f.readlines()
    t = lines[0].split()
    print t
    s = int(t[0])
    n = int(t[1])

    mat = np.zeros((s, n))
    for line in lines[1:]:
        t = line.rstrip().split()
        r = int(t[0])
        # if r == s:
        #     print r
        #     raise RuntimeError('Shouls be 0-based!')
        li = [ float(x) for x in t[1:] ]
        mat[r] = li

    return mat


concat()