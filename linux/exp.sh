#!/bin/sh

size=50
exp="blog"
foldername="${exp}_$(date +%Y%m%d_%H%M%S)"
echo $foldername
mkdir -p  "$foldername"

export LD_LIBRARY_PATH=/home/yba/zixia/gsl/lib
./reconstruct -train ../data/"${exp}"_adj_undirected.txt -output "$foldername"/"${exp}"_adj_dense.txt -depth 2 -k-max 1000
./line -train "$foldername"/"${exp}"_adj_dense.txt -output "$foldername"/vec_1st_wo_norm.txt -binary 0 -size ${size} -order 1 -negative 5 -samples 1000 -threads 40
./line -train "$foldername"/"${exp}"_adj_dense.txt -output "$foldername"/vec_2nd_wo_norm.txt -binary 0 -size ${size} -order 2 -negative 5 -samples 1000 -threads 40
#./normalize -input "$foldername"/vec_1st_wo_norm.txt -output "$foldername"/vec_1st.txt -binary 0
#./normalize -input "$foldername"/vec_2nd_wo_norm.txt -output "$foldername"/vec_2nd.txt -binary 0
#./concatenate -input1 "$foldername"/vec_1st_wo_norm.txt -input2 "$foldername"/vec_2nd_wo_norm.txt -output "$foldername"/line_"${exp}".txt -binary 0
python concate.py "$foldername"/vec_1st_wo_norm.txt "$foldername"/vec_2nd_wo_norm.txt "$foldername"/line_"${exp}"_100.npy "$foldername"/line_"${exp}"_100.txt
#python convert.py -input "$foldername"/line_"${exp}".txt -output "$foldername"/line_"${exp}".npy
#python concate.py "$foldername"/vec_1st_wo_norm.txt "$foldername"/"${exp}"_1st_100.npy "$foldername"/flickr_1st_100.txt
#python concate.py "$foldername"/vec_2nd_wo_norm.txt "$foldername"/"${exp}"_2nd_100.npy "$foldername"/flickr_2nd_100.txt

