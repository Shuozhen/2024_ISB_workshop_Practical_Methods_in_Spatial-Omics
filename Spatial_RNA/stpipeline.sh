#!/bin/bash
#SBATCH --partition=day
#SBATCH --mail-type=ALL
#SBATCH --job-name=STpipeline
#SBATCH --ntasks=1 --cpus-per-task=16
#SBATCH --mem-per-cpu=8g 
#SBATCH --time=24:00:00


SampleID=50t
INDIR=YOUR_FILE_PATH
OUTDIR=YOUR_FILE_PATH

# reformated rawdata
## read1 contains barcode A, barcode B, UMI
FW=$INDIR/50t.R1.fastq.gz
## read2 contains transcriptomic data
RV=$INDIR/50t.R2.fastq.gz

## Build STAR reference, be careful to species, here is the demo for mouse
MAP=Your_FILE_PATH/mm39/STARindex
ANN=Your_FILE_PATH/mm39/gencode.vM28.annotation.gtf
CONT=Your_FILE_PATH/mm39/STARindex_nc
ID=$INDIR/00.database/barcodes-AB.xls

OUTPUT=$OUTDIR/$SampleID
mkdir -p OUTPUT
TMP=$OUTPUT/tmp
mkdir -p $OUTPUT/tmp
EXP=$SampleID

st_pipeline_run.py \
  --output-folder $OUTPUT \
  --temp-folder $TMP \
  --umi-start-position 16 \
  --umi-end-position 26 \
  --ids $ID \
  --ref-map $MAP \
  --ref-annotation $ANN \
  --expName $EXP \
  --htseq-no-ambiguous \
  --verbose \
  --threads 16 \
  --log-file $OUTPUT/${EXP}_log.txt \
  --star-two-pass-mode \
  --no-clean-up \
  --contaminant-index $CONT \
  --disable-clipping \
  --min-length-qual-trimming 30 \
  $FW $RV

convertEnsemblToNames.py \
--annotation $ANN \
--output $OUTPUT/$SampleID\_stdata.updated.tsv $OUTPUT/$SampleID\_stdata.tsv
