import numpy as np

def corq():
    x = np.load('cora_adj.npy')
    #...
    np.savetxt('cora_adj.txt', x, newline=" ")

def blog():
    with open('blog_adj_directed.csv') as fin, open('blog_adj_undirected.txt', 'w') as fout:
        for line in fin:
            ls = line.rstrip().split(',')
            print '@@@',ls
            assert(len(ls)==2)
            id0 = int(ls[0]) -1
            id1 = int(ls[1]) -1
            line = line.replace(",", "\t")
            line = line + '\t1'
            fout.write('%s\t%s\t%s\n' % (id0, id1, '1'))
            fout.write('%s\t%s\t%s\n' % (id1, id0, '1'))

def cora():
    cora = np.load('cora_adj.npy')
    a = np.ones
    with open('cora_adj_directed.txt','w') as fout:
        row = 0 
        num_rows, num_cols = cora.shape
        print('$$$$',num_rows)
        for row in range(num_rows):
            col = 0
            for i in cora[row]:
                if i != 0:
                    line = str(row) +','+str(col)
                    #print line
                    #fout.write(line)
                    fout.write('%s\t%s\n' % (row,col))
                else:
                    col+=1
                    
def arx():
    with open('arxiv_directed.txt') as fin, open('arxiv_adj_undirected.txt', 'w') as fout:
        for line in fin:
            ls = line.rstrip().split('\t')
            print '@@@',ls
            assert(len(ls)==2)
            id0 = int(ls[0])
            id1 = int(ls[1])
            line = line.replace(",", "\t")
            line = line + '\t1'
            fout.write('%s\t%s\t%s\n' % (id0, id1, '1'))
            fout.write('%s\t%s\t%s\n' % (id1, id0, '1'))
def blog_hidden():
    cora = np.load('blog_hidden.npy')
    a = np.ones
    with open('blog_adj_directed.txt','w') as fout:
        row = 0 
        num_rows, num_cols = cora.shape
        print('$$$$',num_rows)
        for row in range(num_rows):
            col = 0
            for i in cora[row]:
                if i != 0:
                    line = str(row) +','+str(col)
                    #print line
                    #fout.write(line)
                    fout.write('%s\t%s\n' % (row,col))
                else:
                    col+=1

def blog_undi_hidden():
    with open('blog_adj_directed.txt') as fin, open('blog_adj_undirected.txt', 'w') as fout:
        for line in fin:
            ls = line.rstrip().split('\t')
            print '@@@',ls
            assert(len(ls)==2)
            id0 = int(ls[0]) 
            id1 = int(ls[1]) 
            line = line.replace(",", "\t")
            line = line + '\t1'
            fout.write('%s\t%s\t%s\n' % (id0, id1, '1'))
            fout.write('%s\t%s\t%s\n' % (id1, id0, '1'))
# blog()
# arx()
#cora()
# blog_hidden()
blog_undi_hidden()
