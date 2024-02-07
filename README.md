# 2024_ISB_workshop_Practical_Methods_in_Spatial-Omics
02/12/2024
Adapted from Dr. Mingyu Yang's GitHub  
https://github.com/MingyuYang-Yale/DBiT-seq  
https://github.com/MingyuYang-Yale/BENG469/tree/main/FA23

## Spatial folder generation
### Software
AtlasXomics Browser https://docs.atlasxomics.com/projects/AtlasXbrowser/en/latest/Overview.html   
### Manual selection using Adobe Illustrator and python
Credit to Dr. Yanxiang Deng: Jupyter notebook code https://github.com/dyxmvp/Spatial_ATAC-seq  
Step-by-step instructions and demo files under 'Spatial_folder_generation' folder
1. Overlay chip A and chip B scan in Adobe Illustrator and find the ROI;
2. Draw any shape on each pixel and make sure not changing any property when dupicate it;
3. Select the spots on tissue and change **only one** property of the object;
4. Save the file at .svg file and make sure only spots info is kept.
5. Save the ROI crop as _tissue_lowres_image.png_
6. Run the jupyter notebook code to generate the spatial folder compatible with seurat and scanpy, etc

## Spatial RNA-Seq
Credit to Dr. Mingyu Yang, https://github.com/MingyuYang-Yale/BENG469/tree/main/FA23/Lab7-Spatial%20transcriptomics/2023-11-02
### Install [Stpipeline](https://github.com/SpatialTranscriptomicsResearch/st_pipeline) and pre-process the data
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
### Downstream
We can use Seurat, Scanpy, Squidpy, spatialDE, SpatialGLUE, NICHES, etc. to run the downstream analysis.

## Spatial ATAC-Seq
Using Cellranger to preprocess the raw data.  
Credit to Dr. Di Zhang, Xing Lou  
<p><img width="1000" src="https://github.com/di-0579/Spatial_epigenome-transcriptome_co-sequencing/blob/main/Data_preprocessing/Spatial-ATAC-seq/snakemake_dag.png" alt="foo bar" title="train &amp; tracks" /></p>

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
### Downstream
We can use ArchR, Signac, Scanpy, Squidpy, SpatialGLUE, etc. to run the downstream analysis.

## Sptail RNA-ATAC-Seq
Credit to Yao Lu
1. From the fragments file of ATAC-seq, generate the peak matrix using SnapATAC2
2. From the expression matrix of RNA-seq, generate the gene expression matrix using spatialGLUE or scanpy.
3. Use spatialGLUE to analyze both modalities together following the script.
