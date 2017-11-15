#!/bin/sh

size=100
exp="blog"
foldername="${exp}_$(date +%Y%m%d_%H%M%S)"
echo $foldername
mkdir -p  "$foldername"

export LD_LIBRARY_PATH=/home/yba/zixia/gsl/lib
#./reconstruct -train ../data/"${exp}"_adj_undirected.txt -output "$foldername"/net_"${exp}"_adj_directed_dense.txt -depth 2 -k-max 1000
./line -train ../data/"${exp}"_adj_undirected.txt -output "$foldername"/vec_1st_wo_norm.txt -binary 0 -size ${size} -order 1 -negative 5 -samples 100 -threads 40
./line -train ../data/"${exp}"_adj_undirected.txt -output "$foldername"/vec_2nd_wo_norm.txt -binary 0 -size ${size} -order 2 -negative 5 -samples 100 -threads 40
#./normalize -input "$foldername"/vec_1st_wo_norm.txt -output "$foldername"/vec_1st.txt -binary 0
#./normalize -input "$foldername"/vec_2nd_wo_norm.txt -output "$foldername"/vec_2nd.txt -binary 0
#./concatenate -input1 "$foldername"/vec_1st_wo_norm.txt -input2 "$foldername"/vec_2nd_wo_norm.txt -output "$foldername"/line_"${exp}".txt -binary 0
python concate.py "$foldername"/vec_1st_wo_norm.txt "$foldername"/vec_2nd_wo_norm.txt "$foldername"/line_"${exp}".npy "$foldername"/line_"${exp}".txt
#python convert.py -input "$foldername"/line_"${exp}".txt -output "$foldername"/line_"${exp}".npy

