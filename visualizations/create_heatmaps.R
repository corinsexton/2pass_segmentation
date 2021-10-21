
setwd("~/Documents/UNLV/Year4/naive_v_primed_2pass//")

library(tidyverse)
library(pheatmap)
library(RColorBrewer)

run <- ''
run <- '_hist'

x <- read_tsv(paste0(paste0("vis",run),"/signal_distribution.tab"))

y <- pivot_wider(data = x, id_cols = trackname, names_from = label, values_from = mean)

ord <- unique(x$trackname)
#ord <- c("H3K4me1", "H3K4me3", "H3K27ac", "H3K27me3")


r_names <- y$trackname
z <- y %>% select(-c("trackname"))

mat <- as.matrix(z)
rownames(mat) <- r_names

mat <- mat[match(ord,r_names),]


# PERCENT OF LABEL FOUND IN NAIVE OR H1 REGIONS
lab_breakdown <- read_tsv(paste0(paste0("vis",run),"/label_breakdown.tsv"))

z <- lab_breakdown
z <- as.data.frame(z %>% select(percent_naive, percent_H1))
rownames(z) <- lab_breakdown$label


# HERVH LOCI PRESENT
run6 <- read_tsv(paste0(paste0("hervh_intersects/vis",run),"_hervh_summary.tsv"))
run6 <- run6 %>% separate(label, c("type","label"), sep = '_')
run6_wide <- pivot_wider(run6, id_cols = label, names_from = type, values_from = num_total)

labels <- run6_wide$label

run6_wide <- run6_wide[,-c(1)]
rownames(run6_wide) <- labels
ann_col_all <- merge(z, run6_wide, by=0)

labels <- ann_col_all$Row.names
ann_col_all<- ann_col_all[,-1]
rownames(ann_col_all) <- labels

ann_col_all$naive[ann_col_all$naive > 1000] <- 600
ann_col_all$H1[ann_col_all$H1 > 1000] <- 600
colnames(ann_col_all) <- c("perc_label_naive", "perc_label_H1", "hervh_naive", "hervh_H1")
# ann_col_all <- ann_col_all %>% select("perc_label_naive", "perc_label_H1")


## ONLY FOR RUN 8
# rownames(ann_col_all) <- c("enh0",
#                        "quies1",
#                        "poised_promoter2",
#                        "quies3",
#                        "promoter4",
#                        "enh5",
#                        "promoter6",
#                        "repr7",
#                        "quies8",
#                        "quies9")

# FOR HIST
# rownames(mat) <- c("H3K4me3",
#                    "promoter4",
#                    "repr7",
#                    "promoter6",
#                    "H3K27ac",
#                    "H3K4me1",
#                    "quies3",
#                    "H3K27me3",
#                    "enh0",
#                    "quies9",
#                    "poised_promoter2",
#                    "enh5",
#                    "quies1",
#                    "quies8"
#                    )

rownames(mat) <- c("repr7",
                   "promoter6",
                   "quies3",
                   "poised_promoter2",
                   "promoter4",
                   "enh0",
                   "quies9",
                   "enh5",
                   "quies1",
                   "quies8"
)


png(paste0(paste0("vis_",run),"_heatmap.png"),width = 1800, height = 1200, res = 200)
pheatmap(mat, scale = "none", border_color = NA, cluster_rows = T, annotation_col = ann_col_all,
         cluster_cols = F, fontsize = 14,
         main = paste0("Naive v Primed run ",run),
         # main = "Segmentation of H1 and naive hESCs",
         breaks = seq(0, 1, length.out = 100)
        )
dev.off()
 

