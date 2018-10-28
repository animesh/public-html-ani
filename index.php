<?php
header("Refresh:10");
$response = file_get_contents('https://en.wikipedia.org/wiki/Special:RandomInCategory/Proteins');
#echo str_pad((date("l") . date("Y/m/d") . date("h:i:sa") . "<br>"), 10, "-=", STR_PAD_LEFT);
#echo "<body style='background-color:darkkhaki'>";
echo "<body style='background-color:grey'>";
#echo "<div style='text-align:right'><h1>". date("l") .  date("h:i:sa") . date("d/m/Y") .  "</h1></div>";
echo "<div style='text-align:center'>". $response .  "</div>";
#print $response;
?>

