library(readxl)
All_info_my_fish <- read_excel("~/Documents/Master/MASTER/All_info_my_fish.xlsx", 
                                 col_types = c("text", "text", "text", 
                                                  "text", "text", "numeric", "text", 
                                                   "text", "text", "text", "numeric", 
                                                    "numeric", "numeric", "text", "text", 
                                                   "text", "numeric", "text", "text", 
                                           "text", "text", "text", "numeric", 
                                                     "text", "text", "text", "text", "text", 
                                                         "text", "text", "text", "text", "text", 
                                                           "text", "text", "text", "text", "text", 
                                                      "numeric", "text", "text", "numeric", 
                                                         "numeric", "numeric", "numeric", 
                                                            "text"))
      

View(All_info_my_fish)


Birgit_fish_final_31_08_ <- read_excel("Documents/Master/MASTER/Birgit_fish_final(31.08).xlsx")


##Length and weight for the three morph groups
#Length (5 missing fish)
library(ggpubr)

ggerrorplot(All_info_my_fish, x = "kroppsfarge", y = "NL_felt", 
            desc_stat = "mean_sd", color = "black",
            add = "jitter", add.params = list(color = "darkgray",
                                              error.plot = "errorbar")
)

ggplot(All_info_my_fish, aes(x=kroppsfarge, y=NL_felt, fill=kroppsfarge)) +
  geom_boxplot(position="dodge")+
  labs(y= "Lengde (mm)", x = "Kroppsfarge")+
  theme_classic(base_size = 20) +
  scale_fill_brewer(palette="Dark2") +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))

#all fish included
ggplot(Birgit_fish_final_31_08_, aes(x=kroppsfarge, y=NL, fill=kroppsfarge)) +
  geom_boxplot(position="dodge")+
  labs(y= "Lengde (mm)", x = "Kroppsfarge")+
  theme_classic(base_size = 20) +
  scale_fill_brewer(palette="Dark2") +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))


ggplot(Birgit_fish_final_31_08_, aes(x=habitat, y=NL, fill=kroppsfarge)) +
  geom_boxplot(position="dodge")+
  labs(y= "Lengde (mm)", x = "Kroppsfarge")+
  theme_classic(base_size = 20) +
  scale_fill_brewer(palette="Dark2") +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))




model_lengde_morph <- lm(NL_felt ~ kroppsfarge, All_info_my_fish)

anova(model_lengde_morph)
summary(model_lengde_morph)

par(mfrow=c(2,2))
plot(model_lengde_morph)

#relevel intercept



All_info_my_fish$korppsfarge <- as.factor(All_info_my_fish$kroppsfarge)
All_info_my_fish$kroppsfarge <- relevel(All_info_my_fish$kroppsfarge, ref = "brun")



summary(lm(NL_felt ~ kroppsfarge,
           data=All_info_my_fish))




#Vekt (mangler 6?)
ggerrorplot(All_info_my_fish, x = "kroppsfarge", y = "vekt_felt", 
            desc_stat = "mean_sd", color = "black",
            add = "jitter", add.params = list(color = "darkgray",
                                              error.plot = "errorbar")
)


model_vekt_morph <- lm(vekt_felt ~ kroppsfarge, All_info_my_fish)

anova(model_vekt_morph)
summary(model_vekt_morph)

par(mfrow=c(2,2))
plot(model_vekt_morph)


#Parasitter####
ggerrorplot(All_info_my_fish, x = "kroppsfarge", y = "antall_cyster", 
            desc_stat = "mean_sd", color = "black",
            add = "jitter", add.params = list(color = "darkgray",
                                              error.plot = "errorbar")
)


ggplot(data=All_info_my_fish, aes(x=antall_cyster, fill = kroppsfarge)) + geom_histogram(bins=10)

model_parasites <- glm(antall_cyster~kroppsfarge, family=poisson, data=All_info_my_fish)

summary(model_parasites)


##Is there a significant difference in the frequency of capture between habitats (littoral vs. profundal)?####
#Should not be, since I tried to selet an equal amount of fish from each habitat and morph..


#chi-squared test of independence

#reject nullhypothesis??


library(vcd)

mosaic(~ kroppsfarge + habitat,
       direction = c("v", "h"),
       data = Chi_squared,
       shade = TRUE
)

#What about for all of the fish in the large dataset??
#Removed NAs from the dataset (N=7)
library(readxl)
Chi_squared <- read_excel("~/Documents/Master/MASTER/Chi_squared.xlsx")

chisq.test(table(Chi_squared$kroppsfarge, Chi_squared$habitat))



library(vcd)

mosaic(~ kroppsfarge + habitat,
       direction = c("v", "h"),
       data = Chi_squared,
       shade = TRUE
)



ggplot(Chi_squared) +
  aes(x = kroppsfarge, fill = habitat) +
  geom_bar(position = "fill") +
  theme_classic(base_size = 20) +
  scale_fill_brewer(palette="Dark2") 

#Snudd om: best? 
mosaic(~ habitat + kroppsfarge,
       direction = c("v", "h"),
       data = Chi_squared,
       shade = TRUE
)

library(dplyr)
library(sjPlot)

src <- Chi_squared %>% select(Habitat, Bodycoloration)

src %>%
  sjtab(fun = "xtab", var.labels=c("Habitat", "Kroppsfarge"),
        show.row.prc=T, show.col.prc=T, show.summary=T, show.exp=T, show.legend=T)


ggplot(Chi_squared) +
  aes(x = habitat, fill = kroppsfarge) +
  geom_bar(position = "fill") +
  theme_classic(base_size = 20) +
  scale_fill_brewer(palette="Dark2") +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))

#annet plot

library(ggstatsplot)
library(ggplot2)

ggbarstats(data = Chi_squared,
                      x = Habitat,
                      y = Bodycoloration) +
  labs(caption = NULL)




#Histogram
ggplot(Chi_squared) +
  aes(x = habitat, fill = kroppsfarge) +
  geom_bar(position = "dodge")+
  theme_classic(base_size = 20) +
  scale_fill_brewer(palette="Dark2") +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))

#%-histogram
ggplot(Chi_squared, aes(x= Bodycoloration,  group=Habitat)) + 
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") + 
  scale_y_continuous(labels=scales::percent) +
  labs(y = "Percent", x= "Bodycolor", fill="Kroppsfarge") +
  facet_grid(~habitat)+
  theme_classic(base_size = 20) +
  scale_fill_brewer(palette="Dark2") +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))

  

  

ggplot(Chi_squared, aes(x= Bodycoloration,  group=Habitat)) + 
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", fill="Bodycoloration") +
  facet_grid(~Habitat) +
  scale_y_continuous(labels = scales::percent)+
  theme_classic(base_size = 20) +
  scale_fill_brewer(palette="Dark2") +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))



#Reject null hypothesis


##Is there a significant difference in the depth of capture between morphgroups (kroppsfarge)?####
ggplot(All_info_my_fish, aes(x=kroppsfarge, y=gj_dyp, fill=kroppsfarge)) +
  geom_boxplot(position="dodge")+
  labs(y= "Gjennomsnittlig dybde (m)", x = "Kroppsfarge")+
  theme_classic(base_size = 20) +
  scale_fill_brewer(palette="Dark2") +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))

All_info_my_fish.new <- All_info_my_fish %>% 
  subset(kjonn != "NA")
ggplot(All_info_my_fish.new, aes(x=kroppsfarge, y=gj_dyp, fill=kjonn)) +
  geom_boxplot(position="dodge")+
  labs(y= "Gjennomsnittlig dybde (m)", x = "Kroppsfarge")+
  theme_classic(base_size = 20) 


install.packages("ggpubr")
library("ggpubr")


ggerrorplot(All_info_my_fish, x = "kroppsfarge", y = "gj_dyp", 
            desc_stat = "mean_sd", color = "black",
            add = "jitter", add.params = list(color = "darkgray",
                                              error.plot = "errorbar")
)
 

library(ggplot2)
            
ggplot(data=All_info_my_fish, aes(x=NL_felt, fill = kroppsfarge)) + geom_histogram(bins=10) +
  theme_classic(base_size = 20) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))
  

Birgit_fish_final_31_08_
#all fish 
ggplot(data=Birgit_fish_final_31_08_, aes(x=NL, fill = kroppsfarge)) + geom_histogram(bins=10) +
  theme_classic(base_size = 20) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  labs(y= "Antall", x = "Lengde (mm)")


##
  scale_fill_brewer(palette="Dark2")

  


model_dyp_bunngarn_morph <- lm(gj_dyp~factor(kroppsfarge), data = All_info_my_fish)

anova(model_dyp_bunngarn_morph)
summary(model_dyp_bunngarn_morph)

par(mfrow=c(2,2))
plot(model_dyp_bunngarn_morph)

#min dyp

model_min_dyp <- lm(min_dyp~factor(kroppsfarge), data = All_info_my_fish)

anova(model_min_dyp)
summary(model_min_dyp)

par(mfrow=c(2,2))
plot(model_min_dyp)

#max_dyp
model_max_dyp <- lm(max_dyp~factor(kroppsfarge), data = All_info_my_fish)

anova(model_max_dyp)
summary(model_max_dyp)

par(mfrow=c(2,2))
plot(model_max_dyp)

#####Diett#####

ggplot(data=MAGER_, aes(x=NL, fill = kroppsfarge)) + geom_histogram(bins=10) +
  theme_classic(base_size = 20) +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  labs(y= "Antall", x = "Lengde (mm)")

#####DEPTH####

Bunngarn <- read_excel("Documents/Master/MASTER/Bunngarn.xlsx", 
                            col_types = c("text", "text", "text", 
                                                    "text", "text", "numeric", "text", 
                                                    "text", "text", "text", "numeric", 
                                                    "numeric", "text", "text", "text", 
                                                    "text", "text", "text", "text", "text", 
                                                    "text", "text", "text", "text", "text", 
                                                    "text", "text", "text", "text", "text", 
                                                    "text", "text", "text", "text", "text", 
                                                    "text", "text", "text", "text", "numeric", 
                                                   "numeric", "numeric", "numeric", 
                                                    "text"))

DEPTH_ <- lm(Depth~factor(Bodycoloration) , data = Bunngarn)

plot(DEPTH_)
anova(DEPTH_)
summary(DEPTH_)

library(lme4)
library(lmerTest)


lmerTest::lmer(Depth ~ Bodycoloration +  
                       (1|garnnr),
                     data=Bunngarn)

par(mfrow=c(2,2))
plot(ss)
 
library(nlme)
lme(Depth~Factor(Bodycoloration)+(1|garnnr), data = Bunngarn)

library(lmerTest)


(2.3944)/(2.3944+0.4568)
 
 #
 library(ggplot2)
 
 ggplot(Bunngarn, aes(x=Bodycoloration, y=Depth, fill=Bodycoloration)) +
   geom_boxplot(position="dodge")+
   labs(y= "Average depth (m)", x = "Bodycoloration")+
   theme_classic(base_size = 20) +
   scale_fill_brewer(palette="Dark2") +
   scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
   scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))
 
 library(ggpubr)
 ggerrorplot(Bunngarn, x = "Bodycoloration", y = "Depth", 
             desc_stat = "mean_sd", color = "black",
             add = "jitter", add.params = list(color = "darkgray",
                                               error.plot = "errorbar")
 )
 
 
 
 install.packages("fitdistrplus")
 library(fitdistrplus)

 descdist(Bunngarn$Depth, discrete = TRUE)
 
 