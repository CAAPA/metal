#!/bin/bash

#Set parameters
if [ "$#" -eq  "0" ]
then
    echo "Usage: ${0##*/} <cohort_name>"
    echo "Eg:"
    echo "bash create_input_for_cohort_from_plink.sh jhu_abr"
    exit
fi
cohort=$1


rm tmp_${cohort}.txt
for chr in {21..22..1}
do
    cat create_input_for_cohort_from_plink.R | R --vanilla --args $cohort $chr
    cat tmp_${cohort}_${chr}.txt >> tmp_${cohort}.txt
    rm tmp_${cohort}_${chr}.txt
done

mkdir ../data/
mkdir  ../data/input/
mv tmp_${cohort}.txt ../data/input/${cohort}.txt
