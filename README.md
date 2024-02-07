# 2024_ISB_workshop_Practical_Methods_in_Spatial-Omics
02/12/2024
Adapted from Dr. Mingyu Yang's GitHub  
https://github.com/MingyuYang-Yale/DBiT-seq  
https://github.com/MingyuYang-Yale/BENG469/tree/main/FA23

## Spatial folder generation
### Software
AtlasXomics Browser https://docs.atlasxomics.com/projects/AtlasXbrowser/en/latest/Overview.html   
### Manual selection
Credit to Dr. Yanxiang Deng  
Jupyter notebook code from: https://github.com/dyxmvp/Spatial_ATAC-seq
   1. Open Adobe Illustrator, generate a artboard ~3000*3000 pixel;
   2. Import your image, and your overlaped ROI;
   3. In a new layer, draw a square with no filling, border only, fit into one pixel for experiment;
      <img width="1358" alt="Screen Shot 2023-06-28 at 9 48 41 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/0624bda8-6db3-472e-9825-891631cb8563">
   4. Select the square, open the property panel, choose the _fx_ option
      <img width="1358" alt="Screen Shot 2023-06-28 at 9 48 41 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/e0c3b68f-818e-4e23-a132-55a506a8efd3">
   5. Select "Distort/Transform" - "Transform..."
      <img width="1358" alt="Screen Shot 2023-06-28 at 9 48 57 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/b3ab8775-8253-48c6-a0e2-bcde38813031">
   6. Copy the square horizontally, set the copy as your channel # -1, change the moving distance (pixel) to make it fit into next pixel
      <img width="1358" alt="Screen Shot 2023-06-28 at 9 49 19 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/34903fc6-6f85-4c6b-8010-dc094ff4bd03">
   8. Choose Object in the menu, "Expand the appearance"
      <img width="1358" alt="Screen Shot 2023-06-28 at 9 50 40 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/01ef13eb-d40c-4dba-bf1e-684cb9e62e57">
      <img width="1358" alt="Screen Shot 2023-06-28 at 9 50 54 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/49be9ad7-d57c-458b-83f8-7ba605e80ef3">
   9. For the whole row, open the property panel, choose the _fx_ option, do the "Distort/Transform" - "Transform..." again for the vertical repeats
       <img width="1358" alt="Screen Shot 2023-06-28 at 9 51 28 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/d7946637-6687-4c90-a3f3-c1bb8de39a1a">
   11. "Expand the appearance" again,
       <img width="1358" alt="Screen Shot 2023-06-28 at 9 52 30 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/d1449f60-fc56-4961-b2de-3ba3184bf49f">
   12. In the menu,"Object" - "Ungroup" twice.
       <img width="1358" alt="Screen Shot 2023-06-28 at 9 52 30 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/76c9a706-4112-427a-a0c6-62d13f44f80b">
       <img width="1358" alt="Screen Shot 2023-06-28 at 9 52 37 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/fd929663-6a4a-4d75-8ea3-5966a2e6d821">
   14. Select the spots not on tissue, change the border color
       <img width="1358" alt="Screen Shot 2023-06-28 at 9 55 52 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/d1262a39-b76a-4c81-a64e-6516421245ce">
   16. Delete the background figure layer temporately, and save the .SVG file (two-color spots only)
       <img width="1358" alt="Screen Shot 2023-06-28 at 10 03 33 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/da073617-6eb0-4aaa-af8c-e7075bd5a07a">
       <img width="1358" alt="Screen Shot 2023-06-28 at 10 04 19 PM" src="https://github.com/Shuozhen/DBiT-Notes/assets/25277637/4da9a33e-6290-4d71-a381-9747696da985">
   17. Recover the background layer by ctrl+Z, delete the spot layer and save the underlying tissue ("Export" - "Save for screen"), the name of it is "tissue_under_spots.png"  
       ![tissue_under_spots](https://github.com/Shuozhen/DBiT-Notes/assets/25277637/af544d83-7269-4c42-8d64-776b1cf7c0aa)
   19. Use the jupyter notebook code _metadata_for_seurat.ipynb_ to generate the contents inside the "spatial" folder


## Spatial RNA-Seq
Credit to Dr. Mingyu Yang, https://github.com/MingyuYang-Yale/BENG469/tree/main/FA23/Lab7-Spatial%20transcriptomics/2023-11-02
### Install [Stpipeline](https://github.com/SpatialTranscriptomicsResearch/st_pipeline):
```
module load miniconda
```
```
conda create -y -n st-pipeline python=3.7 Numpy Cython
```
```
conda activate st-pipeline
```
```
conda install -y -c bioconda star samtools
```
```
pip install 'pysam==0.15.4' taggd stpipeline
```
Test whether ST pipeline is installed successfully
```
st_pipeline_run.py -h
```
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/stpipeline-3.png" alt="foo bar" title="train &amp; tracks" /></p>

## Sptail ATAC-Seq
Using Cellranger to preprocess the raw data.  
Written by Dr. Di Zhang, Xing Lou  
![](./snakemake_dag.png)

### Dependiencies

* [Snakemake](https://snakemake.readthedocs.io/en/stable/index.html). snakemake is python3
* [Biopython](https://biopython.org/docs/1.75/api/index.html).
* [Cell Ranger ATAC](https://support.10xgenomics.com/single-cell-atac/software/pipelines/latest/installation). v1.2
* [BBMap](https://jgi.doe.gov/data-and-tools/bbtools/bb-tools-user-guide/installation-guide/).

### Run the pipeline
1. Replace the cellranger-atac-cs/1.2.0/lib/python/barcodes/737K-cratac-v1.txt with the new barcodes file in this fold.
2. Configure Snakefile
3. Configure cluster.json
4. Configure Snakemake.sh
5. Reformat raw Fastq file to Cell Ranger ATAC format (10x Genomics)
**Raw read 1 -> New Read 1 + New Read 2**
- New Read 1: contains the genome sequences
- New Read 2: contains the spatial Barcode A and Barcode B
**Raw read 2 -> New Read 3**
6. Reformatting raw data was implemented by _BC_process.py_ in the Data_preprocessing folder.  
Sequence alignment and generation of fragments file  
The reformated data was processed using Cell Ranger ATAC v1.2 with following references:  
Mouse reference (mm10):  
```
    curl -O https://cf.10xgenomics.com/supp/cell-atac/refdata-cellranger-atac-mm10-1.2.0.tar.gz
```
Human reference (GRCh38):
```
    curl -O https://cf.10xgenomics.com/supp/cell-atac/refdata-cellranger-atac-GRCh38-1.2.0.tar.gz
```
**A preprocessing pipeline we developed using Snakemake workflow management system is in the Data_preprocessing folder. To run the pipeline, use the command:**
```
    sbatch Snakemake.sh
```
## Sptail RNA-ATAC-Seq
Credit to Yao Lu
Squidpy to analyze the two datasets

## CODEX
segmentation
step1 & step2
step3 maxfuse
