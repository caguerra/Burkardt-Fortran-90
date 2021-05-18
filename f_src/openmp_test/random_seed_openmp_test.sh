#! /bin/bash
#
gfortran -o random_seed_openmp_test -Wall -fopenmp random_seed_openmp_test.f90
#
rm -f random_seed_openmp_test.txt
#
for threads in 1 2 4 8
do
  echo "Run with "$threads" threads."
  export OMP_NUM_THREADS=$threads
  ./random_seed_openmp_test >> random_seed_openmp_test.txt
  if [ $? -ne 0 ]; then
    echo "Run error."
    exit
  fi
done
#
rm random_seed_openmp_test
#
echo "Normal end of execution."