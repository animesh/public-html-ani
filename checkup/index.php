<?php
header("Refresh:5");
echo "<div style=\"float:left; width:50%;\">";
$response = file_get_contents('https://en.wikipedia.org/wiki/Special:RandomInCategory/Diseases%20and%20disorders');
echo "<div style='text-align:center'>". $response .  "</div>";
echo "</div>";
echo "<div style=\"float:left; width:50%;\">";
#massaa => https://en.wikipedia.org/w/index.php?title=Proteinogenic_amino_acid&section=2
#aamm = pd.read_table('/home/animeshs/Documents/scripts/massaa')
#aamm['AminoAcids'] = aamm['Mon. Mass§ (Da)'].astype(str)+' '+ aamm['Abbrev.']+' '+ aamm['Formula']+' '+ aamm['Short']
#aamm.sort_values('Mon. Mass§ (Da)', ascending=False).plot(kind='barh',y='Avg. Mass (Da)',x='AminoAcids', color='orange').figure.savefig('foo.png',dpi=100,bbox_inches = "tight")
#echo "<div style='text-align:right'><h1>". date("l") .  date("h:i:sa") . date("d/m/Y") .  "</h1></div>";
#echo str_pad((date("l") . date("Y/m/d") . date("h:i:sa") . "<br>"), 10, "-=", STR_PAD_LEFT);
#$response = file_get_contents('http://www.weddslist.com/ms/tables.html#tm4');
#echo "<div style='text-align:center'>". $response .  "</div>";
#echo "<body style='background: url(https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Notable_mutations.svg/1000px-Notable_mutations.svg.png) no-repeat center center;'>";
echo "<img src='https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Notable_mutations.svg/500px-Notable_mutations.svg.png'>";
echo "<img src='foo.png')";
#echo "<img src='https://ai2-s2-public.s3.amazonaws.com/figures/2017-08-08/1da4b201861591b0ac3707f3971614ae02d76e87/49-Table2-1.png')";
#echo "<img src='https://upload.wikimedia.org/wikipedia/commons/7/72/Notable_mutations.svg'>";
echo "</div>";
#echo "<body style='background-color:darkkhaki'>";
?>

