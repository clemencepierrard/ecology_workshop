surveys <- read_csv("data/raw/surveys_complete_77_89.csv")
view(surveys)
str(surveys)
head(surveys)

#diffrentes actions de base sur tidyverse :
#select = sélectionner des colonnes dans le jeu de données
#filter = selectionner des lignes dans le jeu de donnee
#mutate = créer de nouvelles colonnnes
#groupe_by et summarize = manipule des jeux de données

###SELECT

select(surveys, plot_id, species_id)
select(surveys, c(3,4))
#c'est pas ouf de selectionner que des colonnes car ca peut changer

#si on veut toute les colonnes sauf le plot_id :
select(surveys, -plot_id)

#si on veut selectionner toutes les colonnes qui sont numériques : 
select(surveys, where(is.numeric))

#si on veut toutes les colonnes qui ont des valeur manquantes
select(surveys, where(anyNA))

### FILTER

#avoir que des données de l'année 1988
filter(surveys, year==1988) 

#toutes les espèces d'un type particulier
filter(surveys, species_id %in% c("RM","DO")) #il va regarder dans le colonne species id toutes les lignes qui sont des species id soit RM soit DO

#fusion des deux conditions
filter(surveys, year==1988 & species_id %in% c("RM","DO")) 

#filter les données entre 80 et 85 avec que les variables mois, species_id et plots_id
#1 = créer un objet
surveys_80_85 <- filter(surveys, year >= 1980 & year <= 1985)
select(surveys_80_85, year, month, species_id, plot_id)

#2 = emboiter les fonctions
select(filter(surveys, year >= 1980 & year <= 1985), year, month, species_id, plot_id)

#3 = meilleure façon : utilisant les pipelines (raccoursis clavier = CTL + Shit + M)
#pipeline ça spécifie directement l'origine en prenant tout ce qui est avant le pipeline
surveys %>% 
  filter(year==1980:1985) %>% 
  select(year, month, species_id, plot_id)

#challenge
surveys %>% 
  filter(year == 1988) %>% 
  select(record_id, species_id, month)

### MUTATE

#creer une colonne 
surveys %>% 
  mutate(weight_kg = weight/1000) %>% 
  relocate(weight_kg,.after = record_id)

#rajouter une colonne dans le meme mutate
surveys %>% 
  mutate(weight_kg = weight/1000,
         weight_lbs = weight_kg * 2.2) %>% 
  relocate(weight_kg,.after = record_id) %>% 
  relocate(weight_lbs,.after = record_id)

#pas de NA pour la variable weight
surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000,
         weight_lbs = weight_kg * 2.2) %>% 
  relocate(weight_kg,.after = record_id) %>% 
  relocate(weight_lbs,.after = record_id)

#autre exemple avec les dates (c'est biend d'avoir 3 colonnes de dates avec jour mois et annees car excel est un peu bete et peut ne pas tout mettre en charactere)
surveys %>% 
  mutate(date = paste(year, month,day, sep="-")) %>% 
  relocate(date, .after = year)

#transformation de la variable date avec un objet date avec un autre package
library(lubridate)
surveys %>% 
  mutate(date = ymd(paste(year, month,day, sep="-"))) %>% 
  relocate(date, .after = year)

### GROUPE_BY and SUMMARIZE

#point moyen de toutes les souris mâles
surveys %>% 
  group_by(sex) %>% 
  summarize(mean.weight=mean(weight))

#data frame avec 3 lignes avec des valeurs manquantes, donc faut enlever les valeurs manquantes
surveys %>% 
  group_by(sex) %>% 
  summarize(mean.weight=mean(weight, na.rm = TRUE))

#calculer le nombre d'undividu pour les différents groupes
surveys %>% 
  group_by(sex) %>% 
  summarize(mean.weight=mean(weight, na.rm = TRUE),count=n())

#Challenge 4 : nombre d'observation des males, femmelles en fonction de la date sur un graphique
#1.Créer une colonne date
#2.Grouper par sexe, date
#3.Calculer (summarize) le nombre pour chaque sexe x date
#4.Graphique
surveys %>% 
  filter(!is.na(sex)) %>% #pour filter les NA
  mutate(date = ymd(paste(year, month,day, sep="-"))) %>% #1
  group_by(sex,date) %>%  #2
  summarise(count=n()) %>%  #3
  ggplot(aes(x=date, y=count, color=sex)) + #4
  geom_line()
