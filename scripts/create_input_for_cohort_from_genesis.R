#args <- commandArgs(trailingOnly = TRUE)

#assoc.info.file.name <- args[1]
#out.file.name <- args[2]
assoc.info.file.name <- "/gpfs/barnes_share/dcl01_data_aniket/data/CAAPA_jhuGRAAD_BDOS_032416/WASHINGTON/GENESIS/NIH_GENESIS_allchr_results_info.txt"
out.file.name <- "../data/output/washington.txt"

assoc.results <- read.table(assoc.info.file.name, head=T, stringsAsFactors = F)[,c(10,11,12,14,16,6,9)]

assoc.results <- assoc.results[!(is.na(assoc.results$Score.pval)),]
assoc.results <- assoc.results[(assoc.results$Rsq > 0.3 & assoc.results$MAF > 0.005) |
   (assoc.results$Rsq > 0.5 & assoc.results$MAF <= 0.005) ,]


assoc.results$EFFECT <- "+"
assoc.results$EFFECT[assoc.results$Score < 0] <- "-"

assoc.results <- assoc.results[,c("SNP", "REF.0.", "ALT.1.", "MAF.1", "EFFECT", "Score.pval"),]
names(assoc.results) <- c("MARKER", "REF", "ALT", "MAF", "EFFECT", "PVALUE")

write.table(assoc.results, out.file.name,
            sep="\t", quote=F, row.names=F, col.names=F)
