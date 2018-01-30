
# 1. Load Packages --------------------------------------------------------

  require(tidyverse)
  require(extrafont)
  loadfonts(quiet = T)

# 2. Load Data ------------------------------------------------------------

## Create Data Frame
  
  ord_san <- tibble(Activity = factor(c("T", "Q", "To_La"), 
                        levels = c("T", "Q", "To_La")), Amount = c(235,20, 15))
## Create Color Scheme
  
  ord_san_col <- c("T" = "#3366cc", "Q" = "#cccccc", "To_La"= "#cccccc")

## Create Figure  
  
  ggplot(ord_san, aes(x = Activity, y = Amount))+
    geom_bar(stat = "identity", width = .7, 
             fill = c("#3366cc", "#cccccc", "#cccccc"))+
    theme_bw(base_size = 14, base_family = "Roboto")+
    scale_x_discrete(labels = c("Talking at Neighbor", "Quiet Time", 
            "Take Off & Landing"))+
    ylab("No. of Minutes")+
    ggtitle("How my Seatmate Spent Our ORD-SAN Flight")+
    theme(plot.title = element_text(hjust = .5))
    
    
  png("2018-01-30_ORD-SAN.png", width = 12, height = 10, units = "in",
      res = 600, pointsize = 14)
  
  ggplot(ord_san, aes(x = Activity, y = Amount))+
    geom_bar(stat = "identity", width = .7, 
             fill = c("#3366cc", "#cccccc", "#cccccc"))+
    theme_bw(base_size = 14, base_family = "Roboto Black")+
    scale_x_discrete(labels = c("Talking at Neighbor", "Quiet Time", 
                                "Take Off & Landing"))+
    ylab("No. of Minutes")+
    ggtitle("How My Seatmate Spent Our ORD-SAN Flight")+
    theme(plot.title = element_text(hjust = .5))
  
  dev.off()
  