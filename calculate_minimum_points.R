setwd("~/files/PAT/IS17THE058_2018_Jan_24_1419")
file_list = list.files(pattern="*.wav")
data_list <- vector("list", "length" = length(file_list))
length_trials <- sapply(dev_sounds_IS17THE058, length)
#find minimum value for each trial
minimum<-apply(t(abs_trial_dev_IS17THE058),1,min,na.rm=TRUE)
#find indices for minimums
vec<-numeric(length(minimum))
latency_sec<-numeric(length(minimum))
for (i in 1:length(minimum)) {
index<-which(abs_trial_dev_IS17THE058[,i]==minimum[i])
vec[i]<-index[1] #only first closest value
filename = file_list[[i]]
# Read data in
df <- tuneR::readWave(filename, from = 1, to = Inf, header = FALSE, toWaveMC = NULL)
data_list[[i]] <- df
testwave <- data_list[[i]]
testwave <- mono(testwave, "both")

#transform vec into time values
seconds<-((length(testwave))/44100)
pointsnumber_trial<-length_trials[i]
pointspersecond<-(pointsnumber_trial+2)/seconds # because of cutting first and last point!
latency_sec[i]<-((vec[i])/pointspersecond)#from first "real" frequency
i=i+1
}
#create trial index vector
trial_number<-numeric(length(minimum))
trial_number<-1:length(minimum)

#bind into table
new_events_IS17THE058<-cbind(trial_number,minimum,vec,latency_sec)
