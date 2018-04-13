# Pat measures
library("psych", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.3")
#Mean deviation(MD) (IPT Tuning)
#rm(deviation)
#rm(vec,c)
file_list_dev = ls(pattern="dev_PAT_[A-Z]{2}[0-9]{2}[A-Z]{3}[0-9]{3}")
vec<-numeric(3*length(file_list_dev))
for (i in seq_along(file_list_dev)) {
  deviation = get(file_list_dev[[i]])
  colnames(deviation)<-c("c","note")
  
  c<-deviation$c

  MD = sum(c)/108 #sum all c over all 108 trails and devide by number of trials

  MAD = sum(abs(c))/108 #Mean absolute Deviation, A Measure of Accuracy

  #Standard deviation from own mean (SDfoM), AMeasure of Consistency
  SDfoM =sqrt(sum((c-MD)^2)/(108-1)) 
  vec[(i*3-2):(i*3)] <- c(MD,MAD,SDfoM)
}
dim(vec)<-c(3, length(file_list_dev)) # turn long vector into array(VP, AP_measures)
AP_measures<-data.frame(vec) #turn into dataframe
AP_measures<-t(AP_measures)
colnames(AP_measures)<-c("MD","MAD","SDfoM") #edit columnnames
rownames(AP_measures)<-substring(file_list_dev,9)
i=i+1

###case RI15SON966 : two trials less (by program error)
c<- dev_PAT_RI15SON966$c

MD=sum(c,na.rm=TRUE)/106
MAD = sum(abs(c),na.rm=TRUE)/106
SDfoM =sqrt(sum((c-MD)^2,na.rm=TRUE)/(106-1))
ind_APmeasures<-match(x="RI15SON966", table=rownames(AP_measures))
AP_measures[ind_APmeasures,1:3]<-c(MD,MAD,SDfoM)
