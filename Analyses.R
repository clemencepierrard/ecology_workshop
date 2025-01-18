#charger packages
library(tidyverse)
library(ratdat)

#Graphique
ggplot(data=complete_old, aes(x=weight, y = hindfoot_lenght))+
  geom_point()

#Ajout de la variable de la couleur
ggplot(data=complete_old, aes(x=weight, y = hindfoot_lenght))+
  geom_point(color="red")

#Ajout de transparence
ggplot(data=complete_old, aes(x=weight, y = hindfoot_lenght))+
  geom_point(color="red", alpha=0.2)
