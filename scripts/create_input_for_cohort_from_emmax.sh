#!/bin/bash

#Set parameters
if [ "$#" -eq  "0" ]
then
    echo "Usage: ${0##*/} <cohort_name> <assoc_results_prefix> <assoc_results_suffix>"
    echo "Eg:"
    echo "bash create_input_for_cohort.sh jhu_bdos /gpfs/barnes_share/dcl01_data_aniket/data/CAAPA_jhuGRAAD_BDOS_032416/JHU_BDOS/chr _typed_overlap_allchohort_rerun.ps"
    exit
fi
cohort=$1
assoc_prefix=$2
assoc_suffix=$3


rm tmp_${cohort}.txt
for chr in {21..22..1}
do
    cat create_input_for_cohort_from_emmax.R | R --vanilla --args $cohort $assoc_prefix $assoc_suffix $chr
    cat tmp_${cohort}_${chr}.txt >> tmp_${cohort}.txt
    rm tmp_${cohort}_${chr}.txt
done

mkdir  ../data/input/
mv tmp_${cohort}.txt ../data/input/${cohort}.txt
