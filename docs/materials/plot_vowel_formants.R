library(ggplot2)
setwd("...") # Put here path with the result.tsv file
df <- read.csv("result.txt", sep = "\t", fileEncoding = "UTF-8")
ggplot(data = df, aes(F2, F1, color = intervalname, label = intervalname))+
  geom_text(show.legend = F)+
  scale_y_reverse(position = "right")+
  scale_x_reverse(position = "top")
