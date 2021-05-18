#! /bin/bash
#
gfortran -c -Wall rbf_interp_nd.f90
if [ $? -ne 0 ]; then
  echo "Compile error."
  exit
fi
#
mv rbf_interp_nd.o ~/lib/rbf_interp_nd.o
#
echo "Normal end of execution."