import numpy as np

def corq():
    x = np.load('cora_adj.npy')
    #...
    np.savetxt('cora_adj.txt', x, newline=" ")

def blog():
    with open('blog_adj_directed.txt') as fin, open('blog_adj_undirected.txt', 'w') as fout:
        for line in fin:
            ls = line.rstrip().split()
            assert(len(ls)==2)
            id0 = int(ls[0])
            id1 = int(ls[1])
            fout.write(line)
            fout.write('%s\t%s\n' % (id1, id0))
