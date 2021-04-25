<?php
header("Refresh:5");
echo "<title>Life is Fuzzy, lets try to deFuzzyify, Bit by bIT</title>";
echo "Trying to develop an Artificial Intelligence powered system to augment doctors in interpreting symptoms w.r.t. demography backed by data;
probabilistic diagnosis, specifically, interpret lab tests and imaging results coming from suspected infectious disease and risk assessment of other conditions e.g. cancer;
able to integrate into available health infrastructure via API(s);
locally sourced data, predicting an outbreak, aiding resource allocation;
add Bhojpuri/Hindi to aid urban and rural health care providers respectively;
If you would like to get involved, contact animesh@fuzzylife.org";
echo "<div style=\"float:left; width:50%;\">";
$response = file_get_contents('https://en.wikipedia.org/wiki/Special:RandomInCategory/Diseases%20and%20disorders');
echo "<div style='text-align:center'>". $response .  "</div>";
echo "</div>";
echo "<div style=\"float:left; width:50%;\">";
echo "<img src='https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Notable_mutations.svg/500px-Notable_mutations.svg.png'>";
echo "<img src='foo.png')";
echo "</div>";
#echo "<body style='background-color:darkkhaki'>";
?>
