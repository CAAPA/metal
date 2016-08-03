#!/bin/bash

cat metal_aa_cmds.txt > tmp_metal.txt
cat metal_bdos_emmax.txt >> tmp_metal.txt
metal < tmp_metal.txt

cat metal_aa_cmds.txt > tmp_metal.txt
cat metal_bdos_mqls.txt >> tmp_metal.txt
cat metal_pr.txt >> tmp_metal.txt
metal < tmp_metal.txt

rm tmp_metal.txt
