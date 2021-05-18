#! /bin/bash
#
gfortran -c -Wall triangle_lyness_rule.f90
if [ $? -ne 0 ]; then
  echo "Compile error."
  exit
fi
#
mv triangle_lyness_rule.o ~/lib/triangle_lyness_rule.o
#
echo "Normal end of execution."