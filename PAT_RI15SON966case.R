# PAT_AR13ROB161 processing
# remove before processing other PAT's
#load again after processing of other files!
source('~/files/PAT/readloopPAT.R')
# lookup table frequencies:
small<-c("C"=130.813, "C# / Db"=138.591, "D"=146.832, "D# / Eb"=155.563, "E"=164.814, "F"=174.614, "F# / Gb"=184.997,
         "G"=195.998, "G# / Ab"=207.652, "A"=220.000, "A# / B"=233.082, "H"=246.942)
one<-c("C"=261.626, "C# / Db"=277.183, "D"= 293.665, "D# / Eb"= 311.127, "E"=329.628, "F"=349.228, "F# / Gb"=369.994,
       "G"=391.995, "G# / Ab"=415.305, "A"=440.000, "A# / B"=466.164, "H"=493.883)
two<-c("C"=523.251, "C# / Db"=554.365, "D"= 587.330, "D# / Eb"= 622.254, "E"=659.255, "F"=698.456, "F# / Gb"=739.989,
       "G"=783.991, "G# / Ab"=830.609, "A"=880.000, "A# / B"=932.328, "H"=987.767)
three<-c("C"=1046.50, "C# / Db"=1108.73, "D"=1174.66, "D# / Eb"=1244.51, "E"=1318.51, "F"=1396.91, "F# / Gb"=1479.98,
         "G"=1567.98, "G# / Ab"=1661.22, "A"=1760.00, "A# / B"=1864.66, "H"=1975.53)
vec<-numeric(108)
vec[107]<-NA
vec[108]<-NA 
#table
for (i in 1:106) {
  entered<-PAT_RI15SON966[i,4] #table
  label<-as.character(PAT_RI15SON966[i,6]) #table
  l_sm<-unname(small[label])
  l_one<-unname(one[label])
  l_two<-unname(two[label])
  l_three<-unname(three[label])
  distance<-log2(entered/c(l_sm,l_one,l_two,l_three))*1200 #distanzen zu zieltönen in verschiedenen Oktaven
  abs_distance<-abs(distance) #Betrag
  octave<-which(abs_distance==min(abs_distance))
  c<-distance[octave]
  vec[i]<-c #table
  dev_RI15SON966<-data.frame(vec,PAT_RI15SON966$target.note) #into data frame
  colnames(dev_RI15SON966)<-c("c","note") 
  i=i+1
}
dev_PAT_RI15SON966 <-dev_RI15SON966
