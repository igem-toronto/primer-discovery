## Methodology

The primers in the file `<region>_primers.csv` were generated by
taking the reference sequence stored in `data/<region>_ref.txt` and then using
[PrimerExplorerv5](http://primerexplorer.jp/lampv5e/index.html) with the default settings.
The five given candidates were then merged into a single csv file with the script `compile_primer_designs.sh`. 