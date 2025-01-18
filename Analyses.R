#charger packages
library(tidyverse)
library(ratdat)

#Graphique
ggplot(data=complete_old, aes(x=weight, y = hindfoot_lenght))+
  geom_point()

