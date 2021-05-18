#! /bin/bash
#
gfortran -c -Wall shepard_interp_2d_test.f90
if [ $? -ne 0 ]; then
  echo "Compile error."
  exit
fi
#
gfortran shepard_interp_2d_test.o $HOME/lib/shepard_interp_2d.o \
  $HOME/lib/test_interp_2d.o $HOME/lib/r8lib.o
if [ $? -ne 0 ]; then
  echo "Load error."
  exit
fi
rm shepard_interp_2d_test.o
#
mv a.out shepard_interp_2d_test
./shepard_interp_2d_test > shepard_interp_2d_test.txt
if [ $? -ne 0 ]; then
  echo "Run error."
  exit
fi
rm shepard_interp_2d_test
#
echo "Normal end of execution."