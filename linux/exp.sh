#!/bin/sh

exp="blog"
foldername="${exp}_$(date +%Y%m%d_%H%M%S)"
echo $foldername
mkdir -p  "$foldername"

export LD_LIBRARY_PATH=/home/yba/zixia/gsl/lib
./reconstruct -train ../data/"${exp}"_adj_undirected.txt -output "$foldername"/net_blog_adj_directed_dense.txt -depth 2 -k-max 1000
./line -train "$foldername"/net_"${exp}"_adj_directed_dense.txt -output "$foldername"/vec_1st_wo_norm.txt -binary 0 -size 100 -order 1 -negative 5 -samples 10000 -threads 40
./line -train "$foldername"/net_"${exp}"_adj_directed_dense.txt -output "$foldername"/vec_2nd_wo_norm.txt -binary 0 -size 100 -order 2 -negative 5 -samples 10000 -threads 40
./normalize -input "$foldername"/vec_1st_wo_norm.txt -output "$foldername"/vec_1st.txt -binary 0
./normalize -input "$foldername"/vec_2nd_wo_norm.txt -output "$foldername"/vec_2nd.txt -binary 0
./concatenate -input1 "$foldername"/vec_1st.txt -input2 "$foldername"/vec_2nd.txt -output "$foldername"/line_"${exp}".txt -binary 0
python convert.py -input "$foldername"/line_"${exp}".txt -output "$foldername"/line_"${exp}".npy

