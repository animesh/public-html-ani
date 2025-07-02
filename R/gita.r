chapter<-sample.int(18, 1, replace = TRUE)
if(chapter == 1){
  verse=sample.int(39,1)
}
if(chapter == 2){
  verse=sample.int(71,1)
}
if(chapter == 3){verse=sample.int(43,1)}
if(chapter == 4){verse=sample.int(42,1)}
if(chapter == 5){
  verse=sample.int(27,1)
}
if(chapter==6){
  verse=sample.int(42,1)
}
if(chapter == 7){verse=sample.int(30,1)}
if(chapter == 8){verse=sample.int(28,1)}
if(chapter == 9){verse=sample.int(34,1)}
if(chapter == 10){
  verse=sample.int(40,1)
}
if(chapter == 11){
  verse=sample.int(52,1)
}
if(chapter == 12){
  verse=sample.int(16,1)
}
if(chapter == 13){
  verse=sample.int(29,1)
}
if(chapter == 14){
  verse=sample.int(24,1)
}
if(chapter == 15){
  verse=sample.int(19,1)
}
if(chapter == 16){
  verse=sample.int(19,1)
}
if(chapter == 17){
  verse=sample.int(24,1)
}
if(chapter == 18){
  verse=sample.int(74,1)
}
if(verse == ""){verse = 1;}
chapter<-sprintf("%02d", chapter)
verse<-sprintf("%02d", verse)
gURL<-paste0("https://bhagavad-gita.org/Gita/verse-",chapter,"-",verse,".html")
#download.file(gURL,"data.html", mode = 'wb',headers = c("User-Agent" = "R"),method="auto")
#system(paste("wget -e use_proxy=yes -e http_proxy=13.212.253.139:80  --header="Accept: text/html" --header="Cookie: __cfduid=xpzezr54v5qnaoet5v2dx1ias5xx8m4faj7d5mfg4og; cf_clearance=0n01f6dkcd31en6v4b234a6d1jhoaqgxa7lklwbj-1438079290-3600" -U "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.79 Safari/537.36\" -O data.html",gURL," -O data.html"))
shlokaClean<-paste0("<head>
  <meta http-equiv=\"refresh\" content=\"0; URL=",gURL,"\"/>
  </head>
  <body>
  <p>If you are not redirected, click source: <a href=",gURL,">",gURL,"</a>.</p>
  </body>")
writeLines(shlokaClean,paste0("data.html"))
gURLpng<-paste0("https://bhagavad-gita.org/Gita/png/verse-",chapter,"-",verse,"-4.png")
download.file(gURLpng,"data.png", mode = 'wb',headers = c("User-Agent" = "R"),method="auto")
# libpath fix
#.libPaths(c(.libPaths(), "~/R/library"))
# Inline orange-on-white image processing
#if (!requireNamespace("png", quietly = TRUE)) install.packages("png", repos = "https://cloud.r-project.org", lib = "~/R/library")
library(png)
data_img <- readPNG("data.png")
if (length(dim(data_img)) == 3 && dim(data_img)[3] == 4) {
  rgb <- data_img[,,1:3]
  alpha <- data_img[,,4]
  for (i in 1:3) {
    rgb[,,i] <- rgb[,,i] * alpha + 1 * (1 - alpha)
  }
} else {
  rgb <- data_img
}
gray <- 0.299 * rgb[,,1] + 0.587 * rgb[,,2] + 0.114 * rgb[,,3]
mask <- 1 - (gray - min(gray)) / (max(gray) - min(gray) + 1e-8)
gamma <- 1.25
mask <- mask ^ gamma
out_img <- array(1, dim = c(dim(rgb)[1], dim(rgb)[2], 4))
out_img[,,1] <- mask * 1 + (1 - mask) * 1     # Red: orange=1, white=1
out_img[,,2] <- mask * 0.5 + (1 - mask) * 1   # Green: orange=0.5, white=1
out_img[,,3] <- mask * 0 + (1 - mask) * 1     # Blue: orange=0, white=1
out_img[,,4] <- 1                             # Opaque

# Pad image to 1200x630 (tweet-friendly 16:9 aspect ratio) with minimum 50px margin
library(png)
target_width <- 1200
target_height <- 630
min_margin <- 50
content_width <- target_width - 2 * min_margin
content_height <- target_height - 2 * min_margin
img_height <- dim(out_img)[1]
img_width <- dim(out_img)[2]

# Scale down if image is larger than content area
if (img_width > content_width || img_height > content_height) {
  scale_factor <- min(content_width / img_width, content_height / img_height)
  new_width <- as.integer(img_width * scale_factor)
  new_height <- as.integer(img_height * scale_factor)
  # Use simple nearest-neighbor resizing
  out_img <- out_img[round(seq(1, img_height, length.out = new_height)),
                     round(seq(1, img_width, length.out = new_width)), , drop=FALSE]
  img_width <- new_width
  img_height <- new_height
}

# Center the image with at least 50px margin
pad_top <- min_margin + floor((content_height - img_height) / 2)
pad_left <- min_margin + floor((content_width - img_width) / 2)
y_start <- pad_top + 1
y_end <- pad_top + img_height
x_start <- pad_left + 1
x_end <- pad_left + img_width
padded_img <- array(1, dim = c(target_height, target_width, 4)) # white background
padded_img[y_start:y_end, x_start:x_end, ] <- out_img
out_img <- padded_img

writePNG(out_img, "data_orange_on_white.png")

# Write HTML with the orange image and a link to the source
link_text <- paste0("Chapter ", chapter, ", Verse ", verse)
html_content <- paste0(
  '<html>\n',
  '<head><title>Bhagavad Gita Verse</title></head>\n',
  '<body style="text-align:center;">\n',
  '<img src="data_orange_on_white.png" alt="Verse Image" style="max-width:100%;height:auto;" />\n',
  '<br/><br/>\n',
  '<a href="', gURL, '" target="_blank">', link_text, '</a>\n',
  '</body>\n',
  '</html>'
)
writeLines(html_content, "data.html")
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
#png("data.png")
par(mar = c(0,0,0,0),bg = "white",family = 'mono')
plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
text(x = 0.5, y = 0.75, paste(gURL,"\n",shlokaClean),cex = 1.2, col = "chocolate")
dev.off()


