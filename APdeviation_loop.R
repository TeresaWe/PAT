
# Formula from Dohn, 2012: they used 768 steps on the scroll wheel per octave. 
#Therefore they have a complicated way to measure the distance between target and selected frequency in cent (modulo etc.)
#c=(((log2(fselected/ftarget)*Nsteps+Nsteps/2) Mod(Nsteps)-Nsteps/2)*1200/Nsteps)
# e.g. c = (((log2(451.3616/440)*768+768/2)Mod(768)-768/2)*1200/768)
#c=(Mod((log2(451.3616/440)*1200+(1200/2))/1200)-(1200/2))*1200/1200 #(in R)


# for us, the short part is sufficient,as we have a resolution of 1200 cent per octave (100 per semitone)
# this ist: log2(fselected/ftarget)*1200
# e.g. log2(466.164/440)*1200 --> 100.0009
# log2(932.328/880)*1200 --> 100.0009

## first load data table:
# lookup table frequencies: (CAUTION:lookup takes position of letter/factor level, if not changed to class character!
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
rm(PAT_AR13ROB161)
rm(PAT_RI15SON966)
file_list_raw = ls(pattern="^PAT_[A-Z]{2}[0-9]{2}[A-Z]{3}[0-9]{3}")
name_lookup<-vector(mode= "character", length=length(file_list_raw))
for (j in seq_along(file_list_raw)) {
  #rm(dev_raw, vec, nam)
  dev_raw = get(file_list_raw[[j]])
  nam <- paste("dev_", file_list_raw[[j]], sep = "")
  vec<-numeric(108) #table
  #print(j)
  for (i in 1:108) {
    entered<-as.numeric(dev_raw[i,4]) #table
    label<-dev_raw[i,6] #table
    target<-dev_raw$target.note # column name sometimes changes depending on type of read in...
    target<-as.character(target)
    label<-as.character(label)
    l_big<-unname(big[label])
    l_sm<-unname(small[label])
    l_one<-unname(one[label])
    l_two<-unname(two[label])
    l_three<-unname(three[label])
    distance<-log2(entered/c(l_big,l_sm,l_one,l_two,l_three))*1200 #distanzen zu zieltönen in verschiedenen Oktaven
    abs_distance<-abs(distance) #Betrag
    octave<-which(abs_distance==min(abs_distance))
    c<-distance[octave]
    vec[i]<-c #table
    assign(nam, data.frame(vec,dev_raw$target.note,target)) #into data frame
    #col.names=c("c","note")
    i=i+1
  }
  j=j+1
}