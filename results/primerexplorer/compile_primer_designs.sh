#!/usr/bin/env bash

REGION="mcm7"  # set this
PRIMER_FILE="${REGION}_primers.csv"

echo ",,,LAMP Primers,,,,," >$PRIMER_FILE

for f in *.xls; do
  ssconvert $f "${f}.csv"
  cat "${f}.csv" >>$PRIMER_FILE
  echo ",,,,,,,," >>$PRIMER_FILE
done

rm *.xls
rm *.xls.csv
