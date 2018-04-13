list.dirs(path=getwd()) # to list subfolders/subdirs and use this info to go into the subfolders within a loop
# e.g. Sub-folders
#sub.folders <- list.dirs(parent.folder, recursive=TRUE)[-1]

filenames <- list.files(path=getwd()) # to list all files in a folder, ggf. define type of the file

#####FIRST set WD

setwd("~/files/PAT")


sub.folders <- list.files(path=getwd(), pattern="[A-Z]{2}[0-9]{2}[A-Z]{3}[0-9]{3}_[0-9]{4}_[A-Za-z]{3}_[0-9]{2}_[0-9]{4}",include.dirs = TRUE)
for (j in sub.folders) {
  path<-paste(getwd(),"/",j,sep="")
  filenames = list.files(path=path,pattern="Absolute Pitch Experiment.csv")
  for (i in filenames) {
    name<-substr(j,1,10)
    name <- gsub("Absolute Pitch Experiment",name,i)# gsub(pattern, replacement, x)
    name <- gsub(".csv","",name)
    name <-gsub("/","_",name)
    name<-paste("PAT_",name, sep="")
    assign(name,read.csv(paste(path,"/",i,sep=""))) #read in the table and name as "name"
  }
}
