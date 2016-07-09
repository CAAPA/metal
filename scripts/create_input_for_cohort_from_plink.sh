#!/bin/bash

#Set parameters
if [ "$#" -eq  "0" ]
then
    echo "Usage: ${0##*/} <cohort_name> <n>"
    echo "Eg:"
    echo "bash create_input_for_cohort_from_plink.sh jhu_abr 85"
    exit
fi
cohort=$1
n=$2
module load R/3.2.5

echo -e "MARKER\tREF\tALT\tMAF\tEFFECT\tPVALUE" > tmp_${cohort}.txt
echo -e "MARKER\tEFFECT\tPVALUE\tREF\tALT\tMAF" > tmp_na_${cohort}.txt
for chr in {1..22..1}
do
    cat create_input_for_cohort_from_plink.R | R --vanilla --args $cohort $chr $n
    cat tmp_na_${cohort}_${chr}.txt >> tmp_na_${cohort}.txt
    rm tmp_na_${cohort}_${chr}.txt
    cat tmp_${cohort}_${chr}.txt >> tmp_${cohort}.txt
    rm tmp_${cohort}_${chr}.txt
done

mkdir ../data/
mkdir  ../data/input/
mv tmp_${cohort}.txt ../data/input/${cohort}.txt
mv tmp_na_${cohort}.txt ../data/input/${cohort}_na_p_values.txt
