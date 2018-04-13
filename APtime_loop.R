

file_list_raw = ls(pattern="^PAT_[A-Z]{2}[0-9]{2}[A-Z]{3}[0-9]{3}")
name_lookup<-vector(mode= "character", length=length(file_list_raw))
PAT_RT<-numeric(length(file_list_raw))
for (j in seq_along(file_list_raw)) {
  #rm(dev_raw, vec, nam)
  dev_raw = get(file_list_raw[[j]])
  time<-as.numeric(dev_raw[i,5])#table
  meantime<-mean(time)
  PAT_RT[j]<-meantime #table
  j=j+1
}
assign("PAT_RT", data.frame(PAT_RT, row.names = file_list_raw)) #into data frame
#ggf
AP_measures<-data.frame(AP_measures, PAT_RT)