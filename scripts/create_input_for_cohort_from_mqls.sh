#!/bin/bash

module load R/3.2.5
cat create_input_for_cohort_from_mqls.R | R --vanilla
