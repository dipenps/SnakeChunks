########################################################################
## Parameters required for the RNA-seq differential analysis

########################################################################
## Parameters required for the RNA-seq differential analysis.
## 
## In this chunk we define the project-specific parameters that are required to enable an analysis. Other (optional) parameters can be defined below to customize the thresholds, figure styles, ... 
## base directory for the report (links are defined relative to this directory)
library(knitr)

dir.main <- "/Users/jvanheld/analyses/RNA-seq_SE_GSE71562"
dir.report <- file.path(dir.main, "reports_DEG")
dir.base <- ".." ; ## Path to the main directory relative to the current report, which must be added to the all links
verbosity <- 2


## Load a library with the utilities
dir.genereg <- file.path(dir.main, "gene-regulation") ## Directory containing routines from France Génomique



################################################################
## Input parameters

## Sample description file (one row per sample)
sample.description.file <- "gene-regulation/examples/RNA-seq_SE_GSE71562/samples.tab"
sample.id.col <- "ID"  ## Column containing sample IDs
sample.label.col <- NULL ## Column containing sample labels
sample.condition.col <- "Condition" ## Column containing sample conditions

## Design file (pairs of samples to be compared)
design.file <- "gene-regulation/examples/RNA-seq_SE_GSE71562/design.tab"

## Table containing the counts of reads per gene (rows) for each sample (columns) 
all.counts.table <- 'results/subread-align_featureCounts.tab'

## The GTF file contains genomic annotations for the selected species
organism.name <- "Escherichia coli K12"
gtf.file <- "genome/Escherichia_coli_str_k_12_substr_mg1655.GCA_000005845.1.21.gtf"
gtf.source <- ""
gene.info.file <- NULL


################################################################
## Output parameters
dir.DEG <-'results/diffexpr' ## Output directory (relative to base dir)
dir.figures <- file.path(dir.DEG, "figures")
suffix.deg <- 'GSE71562' ## Suffix for the output files
suffix.DESeq2 <- paste(sep="_", suffix.deg, "DESeq2")
suffix.edgeR <- paste(sep="_", suffix.deg, "edgeR")

## Prefix for output files concerning the whole count table (all samples together)
## prefix["general.file"] <- sub(pattern = ".tab", replacement="", all.counts.table)
prefix <- vector()
prefix["general.file"] <- file.path(dir.DEG, suffix.deg)
prefix["general.file"] <- file.path(dir.DEG, suffix.deg) ## Path prefix for the general files

################################################################
## Thresholds for differential analysis. 

thresholds <- c("padj"=0.05, ## Upper threshold on False Discovery Rate (FDR)
                #                "evalue"=1, ## Upper threshold on the expected number of false positives
                "FC"=2 ## Lower threshold on the fold-change
)


project.info <- c(
  "Customer"="Claire Rioualen & Jacques van Helden",
  "Platform"="TGML/TAGC, Marseille, France",
  "Bioinfo/stat analysis"="Claire Rioualen & Jacques van Helden",
  "Project start"="2017",
  "Last update"=Sys.Date())

export.excel.files <- FALSE
# 
# ## Initialize output directories
# dir.create(dir.report, showWarnings = FALSE, recursive = TRUE)
# opts_knit$set(base.dir=dir.report) ## Set the working directory for knitr (generating HTML and pdf reports)
# setwd(dir.report) ## Set the working directory for the console
# source(file.path(dir.genereg, "scripts/R-scripts/deg_lib.R"))
# dir.create(file.path(dir.base, dir.figures), showWarnings = FALSE, recursive = TRUE)
# 


# ## In this chunk we define the project-specific parameters that are required to enable an analysis. Other (optional) parameters can be defined below to customize the thresholds, figure styles, ... 
# dir.genereg <- "/home/lkhamvongsa/mountrsatlocal/fg-chip-seq/" ## Directory containing routines from France Génomique
# 
# ## Load a library with the utilities
# source(file.path(dir.genereg, "scripts/R-scripts/deg_lib.R"))
# 
# ## base directory for the report (links are defined relative to this directory)
# dir.main <- "/home/lkhamvongsa/mountrsatlocal/Mathilde/"
# dir.report <- "/home/lkhamvongsa/mountrsatlocal/Mathilde/reports/"
# dir.base <- "/home/lkhamvongsa/mountrsatlocal/Mathilde"  ## Path to the main directory relative to the current report, which must be added to the all links
# opts_knit$set(base.dir=dir.report) ## Set the working directory for knitr (generating HTML and pdf reports)
# setwd(dir.report) ## Set the working directory for the console
# 
# ################################################################
# ## Input parameters
# 
# ## Sample description file (one row per sample)
# sample.description.file <- "data/PLZF_sample_descriptions_one_raw.tab"
# 
# ## Design file (pairs of samples to be compared)
# design.file <- "data/PLZF_analysis_description_pairs.tab"
# 
# ## Table containing the counts of reads per gene (rows) for each sample (columns) 
# all.counts.table <- 'results/DEG/GMP_Mut090215_Mut130215_WT130215_WT121214.tab'
# 
# ## The GTF file contains genomic annotations for the selected species
# organism.name <- "Mus musculus"
# gtf.file <- "genome/mm10.gtf"
# gtf.source <- "ftp://ftp.ensembl.org/pub/release-82/gtf/mus_musculus/"
# 
# #parameter.file <- "/home/lkhamvongsa/mountrsatlocal/Mathilde/scripts/Rmd/rna-seq_DEG_parameters.R"
# 
# ################################################################
# ## Output parameters
# dir.DEG <-'results/DEG' ## Output directory (relative to base dir)
# dir.figures <- file.path(dir.DEG, "figures")
# dir.create(file.path(dir.base, dir.figures), showWarnings = FALSE, recursive = TRUE)
# suffix.deg <- 'mathilde_project' ## Suffix for the output files
# suffix.DESeq2 <- paste(sep="_", suffix.deg, "DESeq2")
# suffix.edgeR <- paste(sep="_", suffix.deg, "edgeR")
# 
# ## Prefix for output files concerning the whole count table (all samples together)
# ## prefix["general.file"] <- sub(pattern = ".tab", replacement="", all.counts.table)
# prefix <- vector()
# prefix["general.file"] <- file.path(dir.DEG, suffix.deg)
# prefix["general.file"] <- file.path(dir.DEG, suffix.deg) ## Path prefix for the general files
# 
# ################################################################
# ## Thresholds for differential analysis. 
# #"evalue"=2, ## Upper threshold on the expected number of false positives
# thresholds <- c("padj"=0.05, ## Upper threshold on False Discovery Rate (FDR)
#                 "FC"=1.5 ## Lower threshold on the fold-change
# )
# 
# 
# project.info <- c(
#   "Customer"="Mathilde CRCM",
#   "Platform"="TGML/TAGC, Marseille, France",
#   "Bioinfo/stat analysis"="Mathilde Poplineau& Lucie Khamvongsa",
#   "Project start"="2015",
#   "Last update"=Sys.Date())
