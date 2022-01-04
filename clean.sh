#!/bin/sh

for i in nexsys4 arty35t arty100t genesys2
do
  rm -rf $i.cache
  rm -rf $i.hw nexys4.ip_user_files nexys4.runs nexys4.sim
  rm -rf $i.ip_user_files
  rm -rf $i.runs
  rm -rf $i.sim
done
rm -f slurm-*.out
