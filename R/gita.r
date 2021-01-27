URL<-"http://www.ii.uib.no/~animesh/verseAday/"
x<-read.csv(url(URL))
cn<-strsplit(colnames(x),"\\.")
ssX<-paste(sapply(cn, "[", 10),sapply(cn, "[", 11))
print(ssX)
write.csv(as.data.frame(x),paste0("data_uib.csv"))
ssX<-"https://www.yugalsarkar.com/bhagwad-gita-chapter-"
URL<-paste0(ssX,sapply(cn, "[", 10),"-shlok-",sapply(cn, "[", 11),"-english")
download.file(URL,paste0("data_ys.html"), mode = 'wb')
URL<-paste0(ssX,sapply(cn, "[", 10),"-shlok-",sapply(cn, "[", 11),"-english.png")
download.file(URL,paste0("data_ys.png"), mode = 'wb')

