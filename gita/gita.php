<?php
$c=0;
#while($c<10){
	unset($verse);
	$chapter=rand(1,18);
        if($chapter == 1){
		$verse=rand(1,46);
                if($verse>15 && $verse<19){
                        $verse="16-18";
                }
                elseif($verse>20 && $verse<23){
                        $verse="21-22";
                }
                elseif($verse>31 && $verse<36){
                        $verse="32-35";
                }
                elseif($verse>36 && $verse<39){
                        $verse="37-38";
                }
        }
        elseif($chapter == 2){
		$verse=rand(1,72);
                if($chapter>41 && $chapter<44){
                        $verse="42-43";
                }
        }
        elseif($chapter == 3){$verse=rand(1,43);}
        elseif($chapter == 4){$verse=rand(1,42);}
        elseif($chapter == 5){
                $verse=rand(1,29);
                if($verse>7  &&  $verse<10){
                        $verse="8-9";
                }
                elseif($verse>26  &&  $verse<29){
                        $verse="27-28";
                }
        }
	elseif($chapter==6){
		$verse=rand(1,47);
                if($chapter>10&&$chapter<13){
                        $verse="11-12";
                }
                elseif($chapter>12&&$chapter<15){
                        $verse="13-14";
                }
                elseif($chapter>19&&$chapter<24){
                        $verse="20-23";
                }
                elseif($chapter>36&&$chapter<39){
                        $verse="37-38";
                }
        }
        elseif($chapter == 7){$verse=rand(1,30);}
        elseif($chapter == 8){$verse=rand(1,28);}
        elseif($chapter == 9){$verse=rand(1,34);}
        elseif($chapter == 10){
		$verse=rand(1,42);
	        if($verse>3 && $verse<6){
                       $verse="4-5";
                }
                elseif($verse>11 && $verse<14){
                        $verse="12-13";
                }
        }
        elseif($chapter == 11){
		$verse=rand(1,55);
                if($verse>9 && $verse<12){
                        $verse="10-11";
                }
                elseif($verse>25 && $verse<28){
                        $verse="26-27";
                }
                elseif($verse>40 && $verse<43){
                        $verse="41-42";
                }
        }
        elseif($chapter == 12){
		$verse=rand(1,20);
                if($verse>2 && $verse<5){
                        $verse="3-4";
                }
                elseif($verse>5 && $verse<8){
                        $verse="6-7";
                }
                elseif($verse>12 && $verse<15){
                        $verse="13-14";
                }
                elseif($verse>17 && $verse<20){
                        $verse="18-19";
                }
        }
        elseif($chapter == 13){
                $verse=rand(1,35);
                if($verse>0 && $verse<3){
                        $verse="1-2";
                }
                elseif($verse>5 && $verse<8){
                        $verse="6-7";
                }
                elseif($verse>9 && $verse<13){
                        $verse="8-12";
                }
        }
	elseif($chapter == 14){
		$verse=rand(1,27);
                if($verse>21 && $verse<26){
                        $verse="22-25";
                }
        }
        elseif($chapter == 15){
		$verse=rand(1,20);
                if($verse>2 && $verse<5){
                        $verse="3-4";
                }
        }
        elseif($chapter == 16){
		$verse=rand(1,24);
                if($verse>0 && $verse<4){
                        $verse="1-3";
                }
                elseif($verse>10 && $verse<13){
                        $verse="11-12";
                }
                elseif($verse>12 && $verse<16){
                        $verse="13-15";
                }
        }
        elseif($chapter == 17){
		$verse=rand(1,28);
                if($verse>4 && $verse<7){
                        $verse="5-6";
                }
                elseif($verse>25 && $verse<28){
                        $verse="26-27";
                }
        }
        else{
		$verse=rand(1,78);
                if($verse>50 && $verse<54){
                        $verse="51-53";
                }
        }
	if($verse == ""){$verse = 20;}
	$url="http://vedabase.com/bg/$chapter/$verse";
	header("Location: $url");
	#exit();
	#echo '<a href=';
	#echo $url;
	#echo " > Bhagwat Gita $chapter.$verse </a> <br> <br> ";
	#$c++;
#}


$html = file_get_contents("http://vedabase.com/bg/$chapter/$verse");
#$rs='HREF=\"http://vedabase.com/\"';
/*
$html_rep =  preg_replace(
    '/\s(href|src)=["\']?\/?(?!(https?:))([^>"\'\s]+)/i',
    ' $1="http://www.example.com/$3"',
    $html
)
*/
#$html_rep=preg_replace('~HREF="*"~', 'href="http://vedabase.com/bg/"', $html);
$html_rep=preg_replace('~HREF="*"~', 'href="http://vedabase.com/bg"', $html);
#https://stackoverflow.com/a/12111268/1137129
$dom = new DOMDocument();
$dom->loadHTML($html_rep);
$xpath = new DOMXPath($dom);
$div = $xpath->query('//div[@class="col-12"]');#class="col-12"
$div = $div->item(0);
#echo $dom->saveXML($div);
$line = $dom->saveXML($div);
$linetxt = htmlspecialchars(trim(strip_tags($line)));
#echo $linetxt;
echo '<a href=';
echo $url;
echo " > Bhagwat Gita $chapter.$verse </a> <br> <br> ";
#https://www.php.net/manual/en/language.constants.predefined.php
$tmpdir = ".";#dirname(__FILE__);
$tmpfile=$tmpdir."/data.txt";
file_put_contents($tmpfile, serialize($linetxt));
$content = unserialize(file_get_contents($tmpfile));
echo $content;
#list($a, $b) = explode('Bg', $html_rep);
#echo $b;
#echo $html_rep;
#$im = imagecreate(150, 20); // image size 150x20px
#imagecolorallocate($im, 255, 255, 255); // background white
#$text_color = imagecolorallocate($im, 0, 0, 0); // text color black
#imagestring($im, 3, 5, 5, $html_rep, $text_color); // append string to image
#header('Content-type: image/png'); // filetype
#imagepng($im, 'image.png'); // save as image.png
#$im = imagecreatefromstring($html_rep);
#imagepng($im, 'img.png'); // save as image.png
#imagedestroy($im); // free up memory
?>
