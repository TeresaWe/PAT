# first set subjects folder as wd
setwd("~/files/PAT/AR13ROB161_2017_Dez_11_1406")
# read in PAT results
##change subject file name
PAT_AR13ROB161 <- read.csv("~/files/PAT/AR13ROB161_2017_Dez_11_1406/Absolute Pitch Experiment.csv")
target.note<-PAT_AR13ROB161$target.note #insert correct PAT file

# loop to read in all .wav trials
file_list = list.files(pattern="*.wav")
data_list <- vector("list", "length" = length(file_list))
for (i in seq_along(file_list)) {
  filename = file_list[[i]]
  # Read data in
  df <- tuneR::readWave(filename, from = 1, to = Inf, header = FALSE, toWaveMC = NULL)
  data_list[[i]] <- df
}

#loop to change into mono (with output list of all files, and process basic sound analysis)
mono_list<-vector("list", "length" = length(data_list))
for (i in seq_along(data_list)) {
  print(i)
  testwave <- data_list[[i]]
  testwave <- mono(testwave, "both")
  #plot(testwave, info = FALSE, xunit = c("time", "samples"), 
     # ylim = NULL, main = NULL, sub = NULL, xlab = NULL, ylab = NULL, 
      #simplify = TRUE, nr = 2500, axes = TRUE, yaxt = par("yaxt"), las = 1, 
     # center = TRUE)
  perioWav <- periodogram(testwave, width = 4096)
  freqWav <- FF(perioWav)
  noteWav <- noteFromFF(freqWav) # or after removing first end last frame (see below)
  freqWav<-freqWav[-1] #remove artefact frame (1st frame), 
  freqWav<-freqWav[1:(length(freqWav)-1)] #ggf. last also
  noteWav <- noteFromFF(freqWav) 
  #plot(perioWav)
  #plot(freqWav)
  #plot(noteWav)
  entered<-as.numeric(PAT_IS17THE058[i,4]) #table
  label<-PAT_IS17THE058[i,6] #table
  target<-PAT_IS17THE058$target.note # column name sometimes changes depending on type of read in...
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
    coord_cartesian(ylim=c(220,880),xlim=c(0,150)))
  }
