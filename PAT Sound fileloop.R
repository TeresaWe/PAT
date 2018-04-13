# first set subjects folder as wd
setwd("~/files/PAT/IS17THE058_2018_Jan_24_1419")
# read in PAT results
##change subject file name
PAT_AZ17FRA106 <- read.csv("~/files/PAT/IS17THE058_2018_Jan_24_1419/Absolute Pitch Experiment.csv")
target.note<-PAT_AZ17FRA106$target.note #insert correct PAT file

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
  testwave <-data_list[[i]]
  testwave <- mono(testwave, "both")
  plot(testwave, info = FALSE, xunit = c("time", "samples"), 
       ylim = c(-10000,10000),xlim=c(0,16), main = NULL, sub = NULL, xlab = NULL, ylab = NULL, 
       simplify = TRUE, nr = 2500, axes = TRUE, yaxt = par("yaxt"), las = 1, 
       center = TRUE)
  perioWav <- periodogram(testwave, width = 4096)
  freqWav <- FF(perioWav)
  noteWav <- noteFromFF(freqWav) # or after removing first end last frame (see below)
  #plot(perioWav)
  #plot(freqWav)
  #plot(noteWav)
  #if necessary:
  freqWav2<-freqWav[-1] #remove artefakt frame (1st frame), 
  #plot(freqWav2)
  #if further necessary
  freqWav2<-freqWav2[1:(length(freqWav2)-1)] #ggf. last also
  plot(freqWav2)
  noteWav2 <- noteFromFF(freqWav2)
  plot(noteWav2)
  mono_list[[i]] <- testwave
  expNotes<-numeric(length(noteWav2))
  expNotes[1:length(expNotes)]<-target.note[i]
  #plot melodie
  melodyplot(perioWav, observed = noteWav2, expected = expNotes, plotenergy = FALSE, gridcol = "grey")
  noteWavNames <- noteWav2[!is.na(noteWav2)]
  notenames(noteWavNames)
  }
