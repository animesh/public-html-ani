# Accessing a random verse from [Srimad Bhagavad-Gita](https://bhagavad-gita.org/)
source:	[R](https://github.com/animesh/public-html-ani/blob/gita/R/gita.r)
email: 		[ani](mailto:sharma.animesh@gmail.com?subject=BhagwatGita)

## Features
- Downloads a random verse from the Bhagavad Gita (source: [bhagavad-gita.org](https://bhagavad-gita.org/))
- Downloads the corresponding PNG image of the verse
- Processes the PNG image to:
  - Invert its colors (with alpha preserved)
  - Generate an orange-on-white version for better readability
  - Saves debug images for grayscale and mask to assist with image processing

## Usage
```bash
git clone https://github.com/animesh/public-html-ani/
git checkout -b gita
# Run the R script (requires R and internet access)
Rscript R/gita.r
```

## Output
- `data.png`: Original verse image
- `data_inverted.png`: Inverted color image
- `data_orange_on_white.png`: Orange text on white background
- `gray_mask.png`, `text_mask.png`: Debug images for image processing

## Source
- Verses and images are sourced from [bhagavad-gita.org](https://bhagavad-gita.org/)

# [base](https://github.com/animesh/public-html-ani/blob/gita/gita.Rproj)

# schedule
```
cron: "45 6 * * *"
```
