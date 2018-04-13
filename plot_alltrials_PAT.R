#####create data frame
library(stringi)
## Compute maximum length
max.length <- max(sapply(dev_sounds_IS17THE058, length))
## Add NA values to list elements
trial_dev_IS17THE058 <- lapply(dev_sounds_IS17THE058, function(v) { c(v, rep(NA, max.length-length(v)))})
max.length<-numeric(max.length)
max.length<-1:length(max.length)
trial_dev_IS17THE058<-as.data.frame(trial_dev_IS17THE058,max.length)
abs_trial_dev_IS17THE058<-abs(trial_dev_IS17THE058)
trial_dev_IS17THE058$mean = apply(abs(trial_dev_IS17THE058),1,mean,na.rm=TRUE)
trial_dev_IS17THE058$sd = apply(abs(trial_dev_IS17THE058),1,sd,na.rm=TRUE)
trial_dev_IS17THE058$meanplussd<-trial_dev_IS17THE058$mean+trial_dev_IS17THE058$sd
trial_dev_IS17THE058$meanminussd<-trial_dev_IS17THE058$mean-trial_dev_IS17THE058$sd
###plot all
f<-ggplot(trial_dev_IS17THE058, aes(x=max.length,y=vec))
print(f+geom_smooth(color="red")+geom_smooth(aes(x=max.length, y=vec.1),color="red")+
        geom_smooth(aes(x=max.length, y=vec.2),color="red")+
        geom_smooth(aes(x=max.length, y=vec.3),color="red")+
        geom_smooth(aes(x=max.length, y=vec.4),color="red")+
        geom_smooth(aes(x=max.length, y=vec.5),color="red")+
        geom_smooth(aes(x=max.length, y=vec.6),color="red")+
        geom_smooth(aes(x=max.length, y=vec.7),color="red")+
        geom_smooth(aes(x=max.length, y=vec.8),color="red")+
        geom_smooth(aes(x=max.length, y=vec.9),color="red")+
        geom_smooth(aes(x=max.length, y=vec.10),color="red")+
        geom_smooth(aes(x=max.length, y=vec.11),color="red")+
        geom_smooth(aes(x=max.length, y=vec.12),color="red")+
        geom_smooth(aes(x=max.length, y=vec.13),color="red")+
        geom_smooth(aes(x=max.length, y=vec.14),color="red")+
        geom_smooth(aes(x=max.length, y=vec.15),color="red")+
        geom_smooth(aes(x=max.length, y=vec.16),color="red")+
        geom_smooth(aes(x=max.length, y=vec.17),color="red")+
        geom_smooth(aes(x=max.length, y=vec.18),color="red")+
        geom_smooth(aes(x=max.length, y=vec.19),color="red")+
        geom_smooth(aes(x=max.length, y=vec.20),color="red")+
        geom_smooth(aes(x=max.length, y=vec.21),color="red")+
        geom_smooth(aes(x=max.length, y=vec.22),color="red")+
        geom_smooth(aes(x=max.length, y=vec.23),color="red")+
        geom_smooth(aes(x=max.length, y=vec.24),color="red")+
        geom_smooth(aes(x=max.length, y=vec.25),color="red")+
        geom_smooth(aes(x=max.length, y=vec.26),color="red")+
        geom_smooth(aes(x=max.length, y=vec.27),color="red")+
        geom_smooth(aes(x=max.length, y=vec.28),color="red")+
        geom_smooth(aes(x=max.length, y=vec.29),color="red")+
        geom_smooth(aes(x=max.length, y=vec.30),color="red")+
        geom_smooth(aes(x=max.length, y=vec.31),color="red")+
        geom_smooth(aes(x=max.length, y=vec.32),color="red")+
        geom_smooth(aes(x=max.length, y=vec.33),color="red")+
        geom_smooth(aes(x=max.length, y=vec.34),color="red")+
        geom_smooth(aes(x=max.length, y=vec.35),color="red")+
        geom_smooth(aes(x=max.length, y=vec.36),color="red")+
        geom_smooth(aes(x=max.length, y=vec.37),color="red")+
        geom_smooth(aes(x=max.length, y=vec.38),color="red")+
        geom_smooth(aes(x=max.length, y=vec.39),color="red")+
        geom_smooth(aes(x=max.length, y=vec.40),color="red")+
        geom_smooth(aes(x=max.length, y=vec.41),color="red")+
        geom_smooth(aes(x=max.length, y=vec.42),color="red")+
        geom_smooth(aes(x=max.length, y=vec.43),color="red")+
        geom_smooth(aes(x=max.length, y=vec.44),color="red")+
        geom_smooth(aes(x=max.length, y=vec.45),color="red")+
        geom_smooth(aes(x=max.length, y=vec.46),color="red")+
        geom_smooth(aes(x=max.length, y=vec.47),color="red")+
        geom_smooth(aes(x=max.length, y=vec.48),color="red")+
        geom_smooth(aes(x=max.length, y=vec.49),color="red")+
        geom_smooth(aes(x=max.length, y=vec.50),color="red")+
        geom_smooth(aes(x=max.length, y=vec.51),color="red")+
        geom_smooth(aes(x=max.length, y=vec.52),color="red")+
        geom_smooth(aes(x=max.length, y=vec.53),color="red")+
        geom_smooth(aes(x=max.length, y=vec.54),color="red")+
        geom_smooth(aes(x=max.length, y=vec.55),color="red")+
        geom_smooth(aes(x=max.length, y=vec.56),color="red")+
        geom_smooth(aes(x=max.length, y=vec.57),color="red")+
        geom_smooth(aes(x=max.length, y=vec.58),color="red")+
        geom_smooth(aes(x=max.length, y=vec.59),color="red")+
        geom_smooth(aes(x=max.length, y=vec.60),color="red")+
        geom_smooth(aes(x=max.length, y=vec.61),color="red")+
        geom_smooth(aes(x=max.length, y=vec.62),color="red")+
        geom_smooth(aes(x=max.length, y=vec.63),color="red")+
        geom_smooth(aes(x=max.length, y=vec.64),color="red")+
        geom_smooth(aes(x=max.length, y=vec.65),color="red")+
        geom_smooth(aes(x=max.length, y=vec.66),color="red")+
        geom_smooth(aes(x=max.length, y=vec.67),color="red")+
        geom_smooth(aes(x=max.length, y=vec.68),color="red")+
        geom_smooth(aes(x=max.length, y=vec.69),color="red")+
        geom_smooth(aes(x=max.length, y=vec.70),color="red")+
        geom_smooth(aes(x=max.length, y=vec.71),color="red")+
        geom_smooth(aes(x=max.length, y=vec.72),color="red")+
        geom_smooth(aes(x=max.length, y=vec.73),color="red")+
        geom_smooth(aes(x=max.length, y=vec.74),color="red")+
        geom_smooth(aes(x=max.length, y=vec.75),color="red")+
        geom_smooth(aes(x=max.length, y=vec.76),color="red")+
        geom_smooth(aes(x=max.length, y=vec.77),color="red")+
        geom_smooth(aes(x=max.length, y=vec.78),color="red")+
        geom_smooth(aes(x=max.length, y=vec.79),color="red")+
        geom_smooth(aes(x=max.length, y=vec.80),color="red")+
        geom_smooth(aes(x=max.length, y=vec.81),color="red")+
        geom_smooth(aes(x=max.length, y=vec.82),color="red")+
        geom_smooth(aes(x=max.length, y=vec.83),color="red")+
        geom_smooth(aes(x=max.length, y=vec.84),color="red")+
        geom_smooth(aes(x=max.length, y=vec.85),color="red")+
        geom_smooth(aes(x=max.length, y=vec.86),color="red")+
        geom_smooth(aes(x=max.length, y=vec.87),color="red")+
        geom_smooth(aes(x=max.length, y=vec.88),color="red")+
        geom_smooth(aes(x=max.length, y=vec.89),color="red")+
        geom_smooth(aes(x=max.length, y=vec.90),color="red")+
        geom_smooth(aes(x=max.length, y=vec.91),color="red")+
        geom_smooth(aes(x=max.length, y=vec.92),color="red")+
        geom_smooth(aes(x=max.length, y=vec.93),color="red")+
        geom_smooth(aes(x=max.length, y=vec.94),color="red")+
        geom_smooth(aes(x=max.length, y=vec.95),color="red")+
        geom_smooth(aes(x=max.length, y=vec.96),color="red")+
        geom_smooth(aes(x=max.length, y=vec.97),color="red")+
        geom_smooth(aes(x=max.length, y=vec.98),color="red")+
        geom_smooth(aes(x=max.length, y=vec.99),color="red")+
        geom_smooth(aes(x=max.length, y=vec.100),color="red")+
        geom_smooth(aes(x=max.length, y=vec.101),color="red")+
        geom_smooth(aes(x=max.length, y=vec.102),color="red")+
        geom_smooth(aes(x=max.length, y=vec.103),color="red")+
        geom_smooth(aes(x=max.length, y=vec.104),color="red")+
        geom_smooth(aes(x=max.length, y=vec.105),color="red")+
        geom_smooth(aes(x=max.length, y=vec.106),color="red")+
        geom_smooth(aes(x=max.length, y=vec.107),color="red")+
        geom_smooth(aes(x=max.length, y=mean),color="blue")+
        geom_smooth(aes(x=max.length, y=meanplussd),color="black")+
        geom_smooth(aes(x=max.length, y=meanminussd),color="black")+
        
        
        coord_cartesian(ylim=c(-1200,1200),xlim=c(0,length(max.length)))) #C1-C3
