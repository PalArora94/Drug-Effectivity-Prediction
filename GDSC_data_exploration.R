getwd()
setwd("~/Desktop/Erdosinstitute/Drug project/GDSC/")



library(dplyr)
library(Seurat)
library(patchwork)

### make data readable for Seurat 
data=read.delim("./Cell_line_RMA_proc_basalExp Yes.txt")
data=data[,-2]
rownames(data)=data[,1]

rownames(data)

data[,1]
duplicated_values <- data[,1][duplicated(data[,1])]
duplicated_values

data2 <- data[data$GENE_SYMBOLS != "", ]
rownames(data2)=data2$GENE_SYMBOLS
data3=data2[,-1]

DRUG=CreateSeuratObject(counts = data3,project = "GDSC", min.cells = 1, min.features = 200)

VlnPlot(DRUG, features = c("nFeature_RNA", "nCount_RNA"), ncol = 2 )
DRUG=subset(DRUG,nFeature_RNA>200)

## ## normalize & scaling 
DRUG= NormalizeData(DRUG, normalization.method = "LogNormalize", scale.factor = 10000)
DRUG <- FindVariableFeatures(DRUG, selection.method = "vst", nfeatures = 3000)
all.genes <- rownames(DRUG)
DRUG <- ScaleData(DRUG, features = all.genes)


# 
DRUG <- FindVariableFeatures(DRUG, selection.method = "vst", nfeatures = 2000)

# Identify the 10 most highly variable genes
top10 <- head(VariableFeatures(DRUG), 10)

# plot variable features with and without labels
plot1 <- VariableFeaturePlot(DRUG)
plot2 <- LabelPoints(plot = plot1, points = top10, repel = TRUE)
plot1 + plot2



#Perform linear dimensional reduction
DRUG <- RunPCA(DRUG, features = VariableFeatures(object = DRUG))
## check the PCA result
ElbowPlot(DRUG)
DimPlot(DRUG, reduction = "pca")

VizDimLoadings(DRUG, dims = 1:2, reduction = "pca")

## clustering 
DRUG <- FindNeighbors(DRUG, dims = 1:20)
DRUG <- FindClusters(DRUG, resolution = 1)

## UMAP visulization
DRUG <- RunUMAP(DRUG, dims = 1:20)
DimPlot(DRUG, reduction = "umap",pt.size = 0.5,label = T)
DimPlot(DRUG,reduction = "umap")

