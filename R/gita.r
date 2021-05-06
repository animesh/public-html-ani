chapter<-sample.int(18, 1, replace = TRUE)
if(chapter == 1){
  verse=sample.int(46,1)
  if(verse>15 && verse<19){
    verse="16-18";
  }
  else if(verse>20 && verse<23){
    verse="21-22";
  }
  else if(verse>31 && verse<36){
    verse="32-35";
  }
  else if(verse>36 && verse<39){
    verse="37-38";
  }
}
if(chapter == 2){
  verse=sample.int(72,1)
  if(chapter>41 && chapter<44){
    verse="42-43";
  }
}
if(chapter == 3){verse=sample.int(43,1)}
if(chapter == 4){verse=sample.int(42,1)}
if(chapter == 5){
  verse=sample.int(29,1)
  if(verse>7  &&  verse<10){
    verse="8-9";
  }
  else if(verse>26  &&  verse<29){
    verse="27-28";
  }
}
if(chapter==6){
  verse=sample.int(47,1)
  if(chapter>10&&chapter<13){
    verse="11-12";
  }
  else if(chapter>12&&chapter<15){
    verse="13-14";
  }
  else if(chapter>19&&chapter<24){
    verse="20-23";
  }
  else if(chapter>36&&chapter<39){
    verse="37-38";
  }
}
if(chapter == 7){verse=sample.int(30,1)}
if(chapter == 8){verse=sample.int(28,1)}
if(chapter == 9){verse=sample.int(34,1)}
if(chapter == 10){
  verse=sample.int(42,1)
  if(verse>3 && verse<6){
    verse="4-5";
  }
  else if(verse>11 && verse<14){
    verse="12-13";
  }
}
if(chapter == 11){
  verse=sample.int(55,1)
  if(verse>9 && verse<12){
    verse="10-11";
  }
  else if(verse>25 && verse<28){
    verse="26-27";
  }
  else if(verse>40 && verse<43){
    verse="41-42";
  }
}
if(chapter == 12){
  verse=sample.int(20,1)
  if(verse>2 && verse<5){
    verse="3-4";
  }
  else if(verse>5 && verse<8){
    verse="6-7";
  }
  else if(verse>12 && verse<15){
    verse="13-14";
  }
  else if(verse>17 && verse<20){
    verse="18-19";
  }
}
if(chapter == 13){
  verse=sample.int(35,1)
  if(verse>0 && verse<3){
    verse="1-2";
  }
  else if(verse>5 && verse<8){
    verse="6-7";
  }
  else if(verse>9 && verse<13){
    verse="8-12";
  }
}
if(chapter == 14){
  verse=sample.int(27,1)
  if(verse>21 && verse<26){
    verse="22-25";
  }
}
if(chapter == 15){
  verse=sample.int(20,1)
  if(verse>2 && verse<5){
    verse="3-4";
  }
}
if(chapter == 16){
  verse=sample.int(24,1)
  if(verse>0 && verse<4){
    verse="1-3";
  }
  else if(verse>10 && verse<13){
    verse="11-12";
  }
  else if(verse>12 && verse<16){
    verse="13-15";
  }
}
if(chapter == 17){
  verse=sample.int(28,1)
  if(verse>4 && verse<7){
    verse="5-6";
  }
  else if(verse>25 && verse<28){
    verse="26-27";
  }
}
if(chapter == 18){
  verse=sample.int(78,1)
  if(verse>50 && verse<54){
    verse="51-53";
  }
}
if(verse == ""){verse = 20;}
#gURL="http://vedabase.com/bg/chapter/verse";
#header("Location: $gURL",1)
#exit(,1)
#echo '<a href=';
#echo $gURL;
#echo " > Bhagwat Gita chapter.verse </a> <br> <br> ";
#$c++;
#}
gURL<-paste0("http://vedabase.io/en/library/bg/",chapter,"/",verse,"/")
#download.file(gURL,"data.html", mode = 'wb',headers = c("User-Agent" = "R"),method="auto")
#system(paste("curl",gURL,"-x 140.227.61.25:58888 -o data.html"))
system(paste("wget -U \"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:39.0) Gecko/20100101 Firefox/39.0\" --header=\"Accept: text/html\" --header=\"Cookie: __cfduid=xpzezr54v5qnaoet5v2dx1ias5xx8m4faj7d5mfg4og; cf_clearance=0n01f6dkcd31en6v4b234a6d1jhoaqgxa7lklwbj-1438079290-3600\" -np ",gURL,"-O data.html"))
getwd()
rawHTML <- paste(readLines("data.html"))#, collapse="\n")
write.csv(as.data.frame(rawHTML),paste0("data_html.csv"))
cn<-rawHTML[grep("<title>",rawHTML)]
cn<-gsub("</title>","",cn)
cn<-gsub("<title>Bg. ","",cn)
cn<-gsub(" ","",fixed=T,cn)
print(cn)
shloka<-rawHTML[grep("r r-lang-en r-translation",rawHTML)]
shlokaClean<-gsub(".*r r-lang-en r-translation(.+)div.*", "\\1", shloka)
shlokaClean<-gsub(" ><p><strong>", "\n", shlokaClean)
shlokaClean<-gsub(" ><p><strong>", "\n", shlokaClean)
shlokaClean<-gsub("</strong></p></", "\"\n", shlokaClean)
shlokaClean<-gsub("\\s*\\[[^\\)]+\\]","",shlokaClean)
shlokaClean<-gsub("â€“","-",shlokaClean)
#https://rstudio-pubs-static.s3.amazonaws.com/279354_f552c4c41852439f910ad620763960b6.html
#Encoding(shlokaClean)
#Encoding('ʘ')
#print(Sys.info()[1:6])
#getOption("encoding")
#Sys.getlocale("LC_ALL")
#length(unique(iconvlist()))
#results <-  sapply(iconvlist(),         function(to)           try(iconv(x, from = Encoding(x), to = to), silent = TRUE))
#sum(isErrors <- grepl("^Error in", results))
#errors <- results[isErrors]
#names(errors)
#shlokaClean<-iconv(shlokaClean, "latin1", "ASCII//TRANSLIT")
shlokaClean<-paste(strwrap(shlokaClean,width=50),collapse="\n")
writeLines(shlokaClean,paste0("data_html.txt"))
gURL<-paste0("Chapter.Verse-",cn)
png("data.png")
par(mar = c(0,0,0,0),bg = "chocolate",family = 'mono')
plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
text(x = 0.5, y = 0.75, paste(gURL,"\n",shlokaClean),cex = 1.2, col = "white")
dev.off()
