#Removed NAs from the dataset (N=7)

library(readxl)
Chi_squared <- read_excel("~/Documents/Master/MASTER/Chi_squared.xlsx")
View(Chi_squared)

chisq.test(table(Chi_squared$Bodycoloration, Chi_squared$Habitat))



#library(vcd)
#
#mosaic(~ Bodycoloration + Habitat,
#       direction = c("v", "h"),
#       data = Chi_squared,
#       shade = TRUE
#)


#annet plot

library(ggstatsplot)
library(ggplot2)

ggbarstats(data = Chi_squared,
           x = Habitat,
           y = Bodycoloration) +
  labs(caption = NULL)


#Histogram (count)
ggplot(Chi_squared) +
  aes(x = Habitat, fill = Bodycoloration) +
  geom_bar(position = "dodge")+
  theme_classic(base_size = 20) +
  scale_fill_brewer(palette="Dark2") +
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))

#Histogram (%)
ggplot(Chi_squared, aes(x= Bodycoloration,  group=Habitat)) + 
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") + 
  scale_y_continuous(labels=scales::percent) +
  labs(y = "Percent", x= "Bodycolor", fill="Kroppsfarge") +
  facet_grid(~Habitat)+
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

