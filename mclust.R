library(mclust)
library(dplyr)
library(tidyverse)

#Load file
dataset <- read.csv('mclust.csv', na.strings=c(-99, 999))

#Extract the 6 mentall health scales
mh_scales <- dataset %>%
  select(PHQ9, GAD7,	PCL5,	PHQ15,	SCI, CFQ) %>%
  na.omit() %>%
  mutate_all(list(scale))


#BIC and ICL
BIC <- mclustBIC(mh_scales)
summary(BIC)

ICL <- mclustICL(mh_scales)
summary(ICL)

#Base LPA modell
LPA_model <- Mclust(mh_scales, modelNames = "VEV", G = 4, x = BIC)
#Add weight
LPA_model_weighted <- do.call("me.weighted", c(list(weights = dataset$Weight), LPA_model))
#Assigning a class based on highest probability
LPA_assigned = apply(LPA_model_weighted$z,1,which.max)
#Reorder classes
LPA_reordered <- ifelse(LPA_assigned == 1, 4,
                          ifelse(LPA_assigned == 2, 3,
                                 ifelse(LPA_assigned == 3, 2, 1)))

#Insert the reordered class back into the dataset and export
dataset$LPA_reordered <- LPA_reordered
write.csv(dataset, file = "DX_dataset_8Feb22_withLPA.csv", row.names = FALSE)

