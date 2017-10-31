#!/bin/sh


g++ -I/home/yba/zixia/gsl/include -lm -pthread -Ofast -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result line.cpp -o line -L/home/yba/zixia/gsl/lib -lgsl -lm -lgslcblas
g++ -I/home/yba/zixia/gsl/include -lm -pthread -Ofast -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result reconstruct.cpp -o reconstruct
g++ -I/home/yba/zixia/gsl/include -lm -pthread -Ofast -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result normalize.cpp -o normalize
g++ -I/home/yba/zixia/gsl/include -lm -pthread -Ofast -march=native -Wall -funroll-loops -ffast-math -Wno-unused-result concatenate.cpp -o concatenate

