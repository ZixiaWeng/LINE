#!/bin/sh

export LD_LIBRARY_PATH=/home/yba/zixia/gsl/lib
g++ -I/home/yba/zixia/gsl/include -lm -pthread -Ofast -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result line.cpp -o line -L/home/yba/zixia/gsl/lib -lgsl -lm -lgslcblas
g++ -I/home/yba/zixia/gsl/include -lm -pthread -Ofast -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result reconstruct.cpp -o reconstruct
g++ -I/home/yba/zixia/gsl/include -lm -pthread -Ofast -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result normalize.cpp -o normalize
g++ -I/home/yba/zixia/gsl/include -lm -pthread -Ofast -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result concatenate.cpp -o concatenate

./reconstruct -train blog_adj_directed.txt -output net_blog_adj_directed_dense.txt -depth 2 -k-max 1000
./line -train net_blog_adj_directed_dense.txt -output vec_1st_wo_norm.txt -binary 1 -size 128 -order 1 -negative 5 -samples 10000 -threads 40
./line -train net_blog_adj_directed_dense.txt -output vec_2nd_wo_norm.txt -binary 1 -size 128 -order 2 -negative 5 -samples 10000 -threads 40
./normalize -input vec_1st_wo_norm.txt -output vec_1st.txt -binary 1
./normalize -input vec_2nd_wo_norm.txt -output vec_2nd.txt -binary 1
./concatenate -input1 vec_1st.txt -input2 vec_2nd.txt -output vec_all.txt -binary 1

