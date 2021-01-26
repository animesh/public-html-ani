# Accessing a random verse from "http://www.ii.uib.no/~animesh/verseAday/" and mapping to yugalsarkar base
<br><br>
app: http://www.ii.uib.no/~animesh/verseAday/ 
<br><br>
source: https://github.com/animesh/scripts/blob/master/diffExprPlots.rmd 
mailto: sharma.animesh@gmail.com?subject=%Bhagwat%20Gita%22
```bash
git clone https://github.com/animesh/public-html-ani/
git checkout -b gita
```
base: https://github.com/animesh/public-html-ani/tree/master/gita

# deps
library(curl)
library(webshot)

# run
cron: "0 * * * *"
