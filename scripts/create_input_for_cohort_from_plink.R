args <- commandArgs(trailingOnly = TRUE)

cohort <- args[1]
chr <- args[2]

assoc.file.name <- paste0("/gpfs/barnes_share/caapa_plink_assoc_analysis/data/output/", 
                          cohort, "/chr", chr, ".assoc.dosage")
info.file.name <- paste0("/gpfs/barnes_share/caapa_gwas_adpc/preqc_imputed/", 
                         cohort, "/chr", chr, ".info.gz")
out.file.name <- paste0("tmp_", cohort, "_", chr, ".txt")


assoc.results <- read.table(assoc.file.name, head=T, stringsAsFactors = F)[,c(1,6,8)]
info <- read.table(gzfile(info.file.name), head=T, stringsAsFactors = F)[,c(1,2,3)]

assoc.results <- assoc.results[!(is.na(assoc.results$P)),]
assoc.results <- merge(assoc.results, info)
assoc.results$EFFECT <- "+"
assoc.results$EFFECT[assoc.results$OR < 1] <- "-"
assoc.results <- assoc.results[,c("SNP", "REF.0.", "ALT.1.", "EFFECT", "P")]
names(assoc.results) <- c("MARKER", "REF", "ALT", "EFFECT", "PVALUE")

write.table(assoc.results, out.file.name,
            sep="\t", quote=F, row.names=F, col.names=T)