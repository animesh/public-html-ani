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

getwd()
download.file(gURL,"data_html.txt", mode = 'wb',headers = c("User-Agent" = "R"),method="auto")
file.copy("data_html.txt", "data_html_raw.txt", overwrite = TRUE)
rawHTML <- readLines("data_html.txt")
htmlString <- paste(rawHTML, collapse = " ")
# Extract all text between tags
matches <- gregexpr(">([^<]+)<", htmlString, perl=TRUE)
plainText <- regmatches(htmlString, matches)[[1]]
plainText <- gsub(">|<", "", plainText)
plainText <- gsub("&nbsp;", " ", plainText)
plainText <- gsub("&amp;", "&", plainText)
plainText <- gsub("&lt;", "<", plainText)
plainText <- gsub("&gt;", ">", plainText)
plainText <- gsub("&quot;", '"', plainText)
plainText <- gsub("&#39;", "'", plainText)
plainText <- gsub("[ ]+", " ", plainText)
plainText <- trimws(plainText)
plainText <- plainText[plainText != ""]
# Remove unwanted lines
unwanted <- c(
  'Chapters', 'Sanskrit Vocal', 'Your browser does not support audio element',
  'Transliteration', 'Anvaya', 'Translation', 'Audio',
  'Hindi', 'Bengali', 'English', 'Dutch', 'German', 'Greek', 'Chinese',
  'Japanese', 'French', 'Spanish', 'Italian', 'Portuguese', 'Hebrew',
  'Arabic', 'Serbian', 'Russian'
)
plainText <- plainText[!plainText %in% unwanted]
writeLines(plainText, "debug_plain_text.txt")
writeLines(plainText, "data_html.txt")

# Write HTML with the orange image and a link to the source
link_text <- plainText[1]
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
#html_content <- paste0('<html>','<head>','<title>',link_text,'</title>','<meta http-equiv="refresh" content="0; url=',gURL,'">','</head>','</html>')
#writeLines(html_content, "index.html")
file.copy("data.html", "index.html", overwrite = TRUE)

