# set your working directory ----------------------------------------------
setwd("...")

# read all files in the derictory to R ------------------------------------
myfiles  <- lapply(list.files(), read.delim)

# merge files into one dataframe ------------------------------------------
result_df <- Reduce(rbind, myfiles)

# create labels -----------------------------------------------------------
sounds <- c("l", "sh", "s", "x", "X")
result_df$label <- rep(sounds, sapply(myfiles, nrow))

# draw the plot -----------------------------------------------------------
library(ggplot2)
ggplot(data = result_df,
       aes(x = freq.Hz., 
           y = pow.dB.Hz., 
           color = label))+
  geom_line(size = 2)+
  theme_bw()+
  labs(title = "Smoothed LPC for different fricatives",
       x = "frequency (Hz)",
       y = "power (Db/Hz)")
