# set your working directory ----------------------------------------------
setwd("...")

# read files to R ---------------------------------------------------------
cd_vot  <- read.csv("durations.txt",
                    sep = "\t",
                    header = FALSE,
                    stringsAsFactors = FALSE)

# create label variable ---------------------------------------------------
cd_vot$sounds <- unlist(strsplit(cd_vot$V1, "_"))[1:nrow(cd_vot)*2]

# create CD/VOT variable --------------------------------------------------
cd_vot$feature <- unlist(strsplit(cd_vot$V1, "_"))[1:nrow(cd_vot)*2-1]

# create utterance number variable ----------------------------------------
cd_vot$utterance <- rep(c("1", "2", "3", "cf"), each = 2)

# rename variable "V2" to "duration" --------------------------------------
names(cd_vot)[2] <- "duration"

# create plot with absolute values ----------------------------------------
library(ggplot2)
ggplot(data = cd_vot,
       aes(sounds, duration))+
  geom_bar(stat = "identity", position = "dodge")+
  facet_wrap(~utterance)

ggplot(data = cd_vot,
       aes(sounds, duration, fill = feature))+
  geom_bar(stat = "identity", position = "dodge")+
  facet_wrap(~utterance)

# create plot with percentage ---------------------------------------------
ggplot(data = cd_vot,
       aes(sounds, duration, fill = feature))+
  geom_bar(stat = "identity", position = "fill")+
  facet_wrap(~utterance)
