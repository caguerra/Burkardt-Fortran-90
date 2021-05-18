#! /bin/bash
#
gfortran -c -Wall disk_grid.f90
if [ $? -ne 0 ]; then
  echo "Compile error."
  exit
fi
#
mv disk_grid.o ~/lib/disk_grid.o
#
echo "Normal end of execution."