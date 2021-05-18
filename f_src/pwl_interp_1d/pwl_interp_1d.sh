#! /bin/bash
#
gfortran -c -Wall pwl_interp_1d.f90
if [ $? -ne 0 ]; then
  echo "Compile error."
  exit
fi
#
mv pwl_interp_1d.o ~/lib/pwl_interp_1d.o
#
echo "Normal end of execution."