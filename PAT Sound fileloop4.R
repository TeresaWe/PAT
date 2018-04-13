# first set subjects folder as wd
setwd("~/files/PAT/AL10KON175_2017_Okt_05_1139")
# read in PAT results
##change subject file name
PAT_AL10KON175 <- read.csv("~/files/PAT/AL10KON175_2017_Okt_05_1139/Absolute Pitch Experiment.csv")
target.note<-PAT_AL10KON175$target.note #insert correct PAT file
#not necessary of APdeviation_loop ran before
big<-c("C"=65.4064, "C# / Db"=69.2957, "D"=73,4162, "D# / Eb"=77.7817, "E"=82.4069, "F"=87.3071, "F# / Gb"=92.4986,
       "G"=97.9989, "G# / Ab"=103.826, "A"=110.000, "A# / B"=116.541, "H"=123.471)
small<-c("C"=130.813, "C# / Db"=138.591, "D"=146.832, "D# / Eb"=155.563, "E"=164.814, "F"=174.614, "F# / Gb"=184.997,
         "G"=195.998, "G# / Ab"=207.652, "A"=220.000, "A# / B"=233.082, "H"=246.942)
one<-c( "C"=261.626, "C# / Db"=277.183, "D"= 293.665, "D# / Eb"= 311.127, "E"=329.628, "F"=349.228, "F# / Gb"=369.994,
        "G"=391.995, "G# / Ab"=415.305, "A"=440.000,"A# / B"=466.164, "H"=493.883)
two<-c("C"=523.251, "C# / Db"=554.365, "D"= 587.330, "D# / Eb"= 622.254, "E"=659.255, "F"=698.456, "F# / Gb"=739.989,
       "G"=783.991, "G# / Ab"=830.609,"A"=880.000, "A# / B"=932.328, "H"=987.767)
three<-c("C"=1046.50, "C# / Db"=1108.73, "D"=1174.66, "D# / Eb"=1244.51, "E"=1318.51, "F"=1396.91, "F# / Gb"=1479.98,
         "G"=1567.98, "G# / Ab"=1661.22, "A"=1760.00, "A# / B"=1864.66, "H"=1975.53)


# loop to read in all .wav trials
file_list = list.files(pattern="*.wav")
data_list <- vector("list", "length" = length(file_list))
for (i in seq_along(file_list)) {
  filename = file_list[[i]]
  # Read data in
  df <- tuneR::readWave(filename, from = 1, to = Inf, header = FALSE, toWaveMC = NULL)
  data_list[[i]] <- df
}
sound_list<-list()

#loop that creates one image per trial and saves frequency- 
#and note-sequence of trial into one list

for (i in seq_along(data_list)) {
  print(i)
  testwave <- data_list[[i]]
  testwave <- mono(testwave, "both")
  #plot(testwave, info = FALSE, xunit = c("time", "samples"), 
     #ylim = NULL, main = NULL, sub = NULL, xlab = NULL, ylab = NULL, 
     #simplify = TRUE, nr = 2500, axes = TRUE, yaxt = par("yaxt"), las = 1, 
     #center = TRUE)
  perioWav <- periodogram(testwave, width = 4096)
  freqWav <- FF(perioWav)
  noteWav <- noteFromFF(freqWav) # or after removing first end last frame (see below)
  freqWav<-freqWav[-1] #remove artefact frame (1st frame), 
  freqWav<-freqWav[1:(length(freqWav)-1)] #ggf. last also
  noteWav <- noteFromFF(freqWav) 
  #plot(perioWav)
  #plot(freqWav)
  #plot(noteWav)
  entered<-as.numeric(PAT_AL10KON175[i,4]) #table
  label<-PAT_AL10KON175[i,6] #table
  target<-PAT_AL10KON175$target.note # column name sometimes changes depending on type of read in...
  target<-as.character(target)
  label<-as.character(label)
  l_big<-unname(big[label])
  l_sm<-unname(small[label])
  l_one<-unname(one[label])
  l_two<-unname(two[label])
  l_three<-unname(three[label])
  target_freqs<-c(l_big,l_sm,l_one,l_two,l_three)
  distance<-log2(entered/c(l_big,l_sm,l_one,l_two,l_three))*1200 #distanzen zu zieltönen in verschiedenen Oktaven
  abs_distance<-abs(distance) #Betrag
  octave<-which(abs_distance==min(abs_distance))
  c<-distance[octave]
  target_freq<-target_freqs[octave]
  count<-numeric(length(freqWav))
  count<-1:length(freqWav) # length(count)/10=seconds 
  data<-data.frame(freqWav,noteWav)
  f<-ggplot(data, aes(x=count,y=freqWav))
  print(f+geom_smooth()+geom_abline(aes(intercept=l_big, slope=0),color="red")+
    geom_abline(aes(intercept=l_sm, slope=0),color="red")+
    geom_abline(aes(intercept=l_one, slope=0),color="red")+
    geom_abline(aes(intercept=l_two, slope=0),color="red")+
    geom_abline(aes(intercept=l_three, slope=0),color="red")+
    coord_cartesian(ylim=c(110,1000),xlim=c(0,150))) #C1-C3
  data<-list(data)
  sound_list<-c(sound_list,data)
}
AL10KON175_sound_list<-sound_list
