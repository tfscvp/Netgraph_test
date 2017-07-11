
#Network Graph for RDS
#-------------------------------
library(tidyr)
library(dplyr)
library('igraph')
#-------------------------------

#Lots of stuff gooes hereeeee.
rm(list=ls())

network <- read.csv("/Users/theesspreckelsen/Google Drive/4_Teaching/A_Supervisions_Oxford/2016_ClaudiaStoicescu/DataOrig/RDSdata_22May2017.csv")

network %>%  
  select(from = id,ref1,ref2,ref3, seed) %>% 
  gather(ref, to, -from, -seed)  %>%  #Turns the three ref variables into one with its origin id
  select(1,2,4) -> links

#Remove missing network information
links <- links[!is.na(links$from),]
links <- links[!is.na(links$to),]

#Turn numeric data into character "tostring"
linksnum <- links
linksnum <- mapply(linksnum, FUN=as.character)
links <- matrix(data=linksnum, ncol=3, nrow=nrow(links))
links <- as.data.frame(links, stringsAsFactors=FALSE)

#Name and
names <- c("from","seed","to")
names(links) <- names
links <-links[c(1,3,2)]

head(links)

nodes <- links[c(1,3)]
names <- c("id", "seed")
names(nodes) <- names


net <- graph_from_data_frame(d=links,directed = TRUE) 

#Layouttype
l <- layout_with_fr(net)


