setwd("~/Documents/UNLV/Year4/hervh_segmentation_enrichment/")

library(tidyverse)
library(UpSetR)


library(networkD3)

net <- read_tsv("barakat_diff_x.net", col_names = c('id','source','target'))
network <- as_tibble(table(net[,2:3]))
network$source <- as.numeric(network$source)
network$target <- as.numeric(network$target)
network$target <- network$target + 10

#sm_net <- network[network$n > 200 & network$n < 500,]
# sm_net$target <- sm_net$target + 15

## H3K9ac - active promoters
## H3K27me3 - repressive
## H3K4me3, H3K27me3 - poised promoter
## H3K4me3 - promoter
## H3K27ac - enhancer
## relatively higher H3K4me1 signal compared to H3K4me3 - enhancer


nodes = data.frame("name" = 
                     c("enh0",
                       "quies1",
                       "poised_promoter2",
                       "quies3",
                       "promoter4",
                       "enh5",
                       "promoter6",
                       "repr7",
                       "quies8",
                       "quies9",
                       "enh0",
                       "quies1",
                       "poised_promoter2",
                       "quies3",
                       "promoter4",
                       "enh5",
                       "promoter6",
                       "repr7",
                       "quies8",
                       "quies9"
                     ))

library(networkD3)

names(network) = c("source", "target", "value")

# Plot
sn <- sankeyNetwork(Links = network, Nodes = nodes,
                    Source = "source", Target = "target",
                    Value = "value", NodeID = "name",
                    fontSize= 14, nodeWidth = 5)

# sn <- htmlwidgets::prependContent(sn, htmltools::tags$h1("HERVH Candidate Loci"))
sn <- htmlwidgets::prependContent(sn, htmltools::HTML('<h1 style="font-family:Arial, sans-serif;font-weight:bold;margin-bottom:0;text-align:center">HERVH Candidate Loci</h1><div style="position:relative;padding: 10px 20px 0px 20px;margin-bottom:50px;">
<p style="font-family:Arial, sans-serif;font-weight:bold;position:absolute;left:0;">Naive hESC</p>
<p style="font-family:Arial, sans-serif;font-weight:bold;position:absolute;right:0;">Primed hESC</p>
</div>'))

# htmlwidgets::sizingPolicy(padding = 10, browser.fill = TRUE)
# sn$sizingPolicy$viewer$fill <- FALSE
sn$sizingPolicy$browser$fill <- F
sn$sizingPolicy$browser$defaultWidth <- 400

# you save it as an html
saveNetwork(sn, "sn_hervh_candidate_loci.html")

library(webshot)
# you convert it as png
webshot("sn_hervh_candidate_loci.html","sn_hervh_candidate_loci.png", vwidth =400, vheight = 800)


##### NON CANDIDATE LOCI

net <- read_tsv("noncandidate_HERVH_loci.net", col_names = c('id','source','target'))
network <- as_tibble(table(net[,2:3]))
network$source <- as.numeric(network$source)
network$target <- as.numeric(network$target)
network$target <- network$target + 10

#sm_net <- network[network$n > 200 & network$n < 500,]
# sm_net$target <- sm_net$target + 15

## H3K9ac - active promoters
## H3K27me3 - repressive
## H3K4me3, H3K27me3 - poised promoter
## H3K4me3 - promoter
## H3K27ac - enhancer
## relatively higher H3K4me1 signal compared to H3K4me3 - enhancer


nodes = data.frame("name" = 
                     c("enh0",
                       "quies1",
                       "poised_promoter2",
                       "quies3",
                       "promoter4",
                       "enh5",
                       "promoter6",
                       "repr7",
                       "quies8",
                       "quies9",
                       "enh0",
                       "quies1",
                       "poised_promoter2",
                       "quies3",
                       "promoter4",
                       "enh5",
                       "promoter6",
                       "repr7",
                       "quies8",
                       "quies9"
                     ))

library(networkD3)

names(network) = c("source", "target", "value")

# Plot
sn <- sankeyNetwork(Links = network, Nodes = nodes,
                    Source = "source", Target = "target",
                    Value = "value", NodeID = "name",
                    fontSize= 14, nodeWidth = 5)

# sn <- htmlwidgets::prependContent(sn, htmltools::tags$h1("HERVH Candidate Loci"))
sn <- htmlwidgets::prependContent(sn, htmltools::HTML('<h1 style="font-family:Arial, sans-serif;font-weight:bold;margin-bottom:0;text-align:center">HERVH nonCandidate Loci</h1><div style="position:relative;padding: 10px 20px 0px 20px;margin-bottom:50px;">
<p style="font-family:Arial, sans-serif;font-weight:bold;position:absolute;left:0;">Naive hESC</p>
<p style="font-family:Arial, sans-serif;font-weight:bold;position:absolute;right:0;">Primed hESC</p>
</div>'))

# htmlwidgets::sizingPolicy(padding = 10, browser.fill = TRUE)
# sn$sizingPolicy$viewer$fill <- FALSE
sn$sizingPolicy$browser$fill <- F
sn$sizingPolicy$browser$defaultWidth <- 400

# you save it as an html
saveNetwork(sn, "sn_hervh_noncandidate_loci.html")

library(webshot)
# you convert it as png
webshot("sn_hervh_noncandidate_loci.html","sn_hervh_noncandidate_loci.png", vwidth =400, vheight = 800)
