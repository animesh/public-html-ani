<?php
#header("Refresh:5");
echo "<title>Life is Fuzzy, lets try to deFuzzyify, Bit by bIT</title>";
echo "<h1 style=\"color: #5e9ca0;\">Life is Fuzzy, lets try to <span style=\"color: #2b2301;\">deFuzzyify</span>, Bit by bIT</h1>";
echo "<h2>Trying to develop an Artificial Intelligence powered system to augment doctors in interpreting symptoms w.r.t. demography backed by data</h2>";
echo "<p>probabilistic diagnosis, specifically, interpret lab tests and imaging results coming from suspected infectious disease and risk assessment of other conditions e.g. cancer";
echo "<p>able to integrate into available health infrastructure via API(s)";
echo "<p>locally sourced data, predicting an outbreak, aiding resource allocation;add Bhojpuri/Hindi to aid urban and rural health care providers respectively";
echo "<p><h2>If you would like to get involved, contact <a href=\"mailto:animesh@fuzzylife.org\">animesh@fuzzylife.org</a></h2>";
echo "<p>currently processing...";
echo "<div style=\"float:left; width:50%;\">";
$response = file_get_contents('https://en.wikipedia.org/wiki/Special:RandomInCategory/Diseases%20and%20disorders');
echo "<div style='text-align:center'>". $response .  "</div>";
echo "</div>";
echo "<div style=\"float:left; width:50%;\">";
echo "<img src='https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Notable_mutations.svg/500px-Notable_mutations.svg.png'>";
echo "<img src='foo.png')";
echo "</div>";
mail('animesh@fuzzylife.org', 'fuzzylife.org accessed', $response);
#echo "<body style='background-color:darkkhaki'>";
?>
