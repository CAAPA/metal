#args <- commandArgs(trailingOnly = TRUE)

#assoc.file.name <- args[1]
#info.file.name <- args[2]
#out.file.name <- args[3]
assoc.file.name <- "/gpfs/barnes_share/dcl01_data_aniket/data/CAAPA_jhuGRAAD_BDOS_032416/JHU_BDOS/imputed/allchr_output_mqlsdose.txt"
info.file.name <- "/gpfs/barnes_share/dcl01_data_aniket/data/CAAPA_jhuGRAAD_BDOS_032416/JHU_BDOS/imputed/allchr.mach.info"
out.file.name <- "../data/input/jhu_bdos_mqls.txt"

assoc.results <- read.table(assoc.file.name, head=T, stringsAsFactors = F)[,c(2,4,7,8,11)]
names(assoc.results)[1] <- "SNP"
info <- read.table(info.file.name, head=T, stringsAsFactors = F)[,c(1,2,3,5)]


assoc.results <- merge(assoc.results, info)

assoc.results <- assoc.results[!(is.na(assoc.results$P)),]
assoc.results <- assoc.results[assoc.results$MAF >= 0.01,]
assoc.results <- assoc.results[assoc.results$Rsq > 0.5,]

assoc.results$EFFECT <- "+"
assoc.results$EFFECT[assoc.results$Freq0 > assoc.results$Freq1] <- "-"

assoc.results <- assoc.results[,c("SNP", "REF.0.", "ALT.1.", "MAF", "EFFECT", "PValue")]
names(assoc.results) <- c("MARKER", "REF", "ALT", "MAF", "EFFECT", "PVALUE")

write.table(assoc.results, out.file.name,
            sep="\t", quote=F, row.names=F, col.names=F)
