#!/usr/bin/env bash

cd ..
PROJECT_DIR=$PWD
echo "Base path:" $PROJECT_DIR

# Make folders

mkdir -p external/GLAPD results/glapd

# Download and make GLAPD

cd external

if [ ! -d GLAPD/.git ]; then
  git clone https://github.com/jiqingxiaoxi/GLAPD.git
  cd GLAPD
else
  cd GLAPD
  git pull
fi
make

# Run GLAPD on each region

for region in bt its its_add mcm7 rpl1 tef; do
  echo "=========================================================================================================="
  echo "Designing primers for ${region^^}"

  cp -rf "${PROJECT_DIR}/data/glapd/${region}" tmp
  mkdir results

  ./bowtie/bowtie-build tmp/dataset.fasta tmp/index >/dev/null

  ./Single -in tmp/ref.fasta -out candidates -dir results -loop

  perl par.pl --in candidates --ref tmp/ref.fasta --dir results --common tmp/target_names.txt --left --bowtie bowtie/bowtie --index tmp/index --loop --threads=4

  ./LAMP -in candidates -ref tmp/ref.fasta -dir results -out results/primers.txt -common -specific -loop

  cp -a results/primers.txt "${PROJECT_DIR}/results/glapd/${region}_primers.txt"

  rm -rf tmp results

  echo "=========================================================================================================="
done
