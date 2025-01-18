library(tidyverse)
library(ratdat)

?complete_old #voir un peu le jeu de donnees qui est dans ratdat (jeu de donnees deja disponible sur internet)
summary(complete_old)
head(complete_old)
#a tibble : data frame = pleins de vecteurs mis ensemble
str(complete_old) #nom de variable avec le type etc

#Exploration de donnees avec ggplot
library(ggplot2)

#structure de base de ggplot : ggplot(data=<data>,mapping=aes(<variables>))+geom_function() + geom_function()pour rajouter pleins d'autres chose sur les graphiques
# <data> = où ; <variable>" = quoi
ggplot(complete_old) #ça fait rien lol

#rajouter une variable
ggplot(data=complete_old,mapping = aes(x=weight, y = hindfoot_length)) #lol pas de donnees, faut spécifier la représentation qu'on veut
ggplot(data=complete_old,mapping = aes(x=weight, y = hindfoot_length))+geom_point()

#rajouer transparence aux points, on peut spécifier des arguments, alpha = transparence
ggplot(data=complete_old,mapping = aes(x=weight, y = hindfoot_length))+geom_point(alpha=0.2)

#enlever les valeurs manquantes (c mieux de creer un autre objet avec un autre nom mais ici balek)
complete_old <- filter(complete_old,!is.na(weight))
ggplot(data=complete_old,mapping = aes(x=weight, y = hindfoot_length))+geom_point(alpha=0.2)

#encore des valeurs manquantes
complete_old <- filter(complete_old,!is.na(weight)&!is.na(hindfoot_length))
ggplot(data=complete_old,mapping = aes(x=weight, y = hindfoot_length))+geom_point(alpha=0.2)
#plus de valeurs manquantes

#changer la couleur des points
ggplot(data=complete_old,mapping = aes(x=weight, y = hindfoot_length))+geom_point(alpha=0.2, color="blue")

#on peut changer l'endroit de mettre de la cuileur en creant une troisieme variable qui sera la couleur des points
ggplot(data=complete_old,mapping = aes(x=weight, y = hindfoot_length,color = plot_type))+geom_point(alpha=0.2)

#avec le meme jeu de donnees ont peut que la forme des points varie en fonction du sexe et que la couleur varient en fonction des annees des souris
ggplot(data=complete_old,mapping = aes(x=weight, y = hindfoot_length,shape = sex,color = year))+geom_point(alpha=1)

#comment choisir de meilleures couleurs
ggplot(data=complete_old,mapping = aes(x=weight, y = hindfoot_length,color = plot_type))+
    geom_point(alpha=1) +
    scale_color_viridis_d()

#changer l'echelle pour que les x soit en log
ggplot(data=complete_old,mapping = aes(x=weight, y = hindfoot_length,color = plot_type))+
  geom_point(alpha=1) +
  scale_color_viridis_d()+
  scale_x_log10()

#faire un boxplot
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
         geom_boxplot() #c moche

#scale pour changer l'échelle des variables en x, changer les labels des x pour qu'ils soient sur plusieurs lignes, pas une seule
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_boxplot() +
  scale_x_discrete(labels = label_wrap_gen(width=10))

#ajouter les points dans les boxplots
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_boxplot() +
  geom_point()+
  scale_x_discrete(labels = label_wrap_gen(width=10)) #pas beau

#ajout d'un bruit pour avoir tous les points répartis
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_boxplot() +
  geom_jitter(alpha=0.2)+
  scale_x_discrete(labels = label_wrap_gen(width=10))

#changer les couleurs pour avoir des distinctions
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length, color = plot_type))+
  geom_boxplot() +
  geom_jitter(alpha=0.2)+
  scale_x_discrete(labels = label_wrap_gen(width=10))

#les points et la couleur des boxplots ont changés, donc si on veut juste que les points aient la couleur, faut mettre couleur dans jitter
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_boxplot() +
  geom_jitter(aes(color = plot_type),alpha=0.2)+
  scale_x_discrete(labels = label_wrap_gen(width=10))

#on a des valeurs abbérentes donc on peut les enleves en ajoutant un argument dans geom boxplot
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(aes(color = plot_type),alpha=0.2)+
  scale_x_discrete(labels = label_wrap_gen(width=10))

#mettre les boxplot par dessus les points juste en inversant jitter et boxplot
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_jitter(aes(color = plot_type),alpha=0.2)+
  geom_boxplot(outlier.shape = NA) +
  scale_x_discrete(labels = label_wrap_gen(width=10))

#rajouter une transparence sur les boxplot avec fill
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_jitter(aes(color = plot_type),alpha=0.2)+
  geom_boxplot(outlier.shape = NA, fill= NA) +
  scale_x_discrete(labels = label_wrap_gen(width=10))

#faire un diagramme en violon avec cette data (graphique en violon n'ont pas de valeur aberante)
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_jitter(aes(color = plot_type),alpha=0.2)+
  geom_violin(fill = NA)+
  scale_x_discrete(labels = label_wrap_gen(width=10))

#theme, allure générale du graphique
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_jitter(aes(color = plot_type),alpha=0.2)+
  geom_boxplot(outlier.shape = NA, fill= NA) +
  scale_x_discrete(labels = label_wrap_gen(width=10))+
  theme_bw()

#autre façon de changer les themes (par ex pas de legende dans le graphique)
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_jitter(aes(color = plot_type),alpha=0.2)+
  geom_boxplot(outlier.shape = NA, fill= NA) +
  scale_x_discrete(labels = label_wrap_gen(width=10))+
  theme_bw()+
  theme(legend.position = "none")

#changer le titre des axes
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_jitter(aes(color = plot_type),alpha=0.2)+
  geom_boxplot(outlier.shape = NA, fill= NA) +
  scale_x_discrete(labels = label_wrap_gen(width=10))+
  theme_bw()+
  theme(legend.position = "none")+
  labs(x = "Plot Type", y = "Hindfoot lenght (mm)")

#separer le graphique en fonction des sexes, créer différents panneaux
ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_jitter(aes(color = plot_type),alpha=0.2)+
  facet_wrap(vars(sex,ncol=1))+ #ncol = 1 c'est le nombre de colone qu'on veut et là comme on veut mettre les 2 gr&phiques cote cote on met 1 colonne
  geom_boxplot(outlier.shape = NA, fill= NA) +
  scale_x_discrete(labels = label_wrap_gen(width=10))+
  theme_bw()+
  theme(legend.position = "none")+
  labs(x = "Plot Type", y = "Hindfoot lenght (mm)")

#exporter le graphique
plot_final <- ggplot(complete_old,mapping=aes(x=plot_type, y=hindfoot_length))+
  geom_jitter(aes(color = plot_type),alpha=0.2)+
  facet_wrap(vars(sex,ncol=1))+ #ncol = 1 c'est le nombre de colonne qu'on veut et là comme on veut mettre les 2 gr&phiques cote cote on met 1 colonne
  geom_boxplot(outlier.shape = NA, fill= NA) +
  scale_x_discrete(labels = label_wrap_gen(width=10))+
  theme_bw()+
  theme(legend.position = "none")+
  labs(x = "Plot Type", y = "Hindfoot lenght (mm)")
plot_final
#on peut rajouter des layers après le plot_final en rajoutant un +

#sauvegarder le plot
ggsave(filename = "figures/plot_final.png",
       plot = plot_final,
       height = 6, #hauteur du fichier,
       width = 8) #longueur du fichier