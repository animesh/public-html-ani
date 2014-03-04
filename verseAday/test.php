<?php
$c=0;
while($c<10){
	$chapter=rand(1,18);
/*
	if($chapter==1){
		if($chapter>15&&$chapter<19){
			$verse="16-18";
		}
		if($chapter>20&&$chapter<23){
			$verse="21-22";
		}
		if($chapter>31&&$chapter<36){
			$verse="32-35";
		}
		if($chapter>36&&$chapter<39){
			$verse="37-38";
		}
		else{$verse=rand(1,46);}
	}
	if($chapter==2){
		if($chapter>41&&$chapter<44){
			$verse="42-43";
		}
		else{$verse=rand(1,72);}
	}
	if($chapter==3){$verse=rand(1,43);}
	if($chapter==4){$verse=rand(1,42);}
	if($chapter==5){
                if($chapter>7&&$chapter<10){
                        $verse="8-9";
                }
                if($chapter>26 && $chapter<29){
                        $verse="27-28";
                }
		else{$verse=rand(1,29);}
	}
	if($chapter==6){
                if($chapter>10&&$chapter<13){
                        $verse="11-12";
                }
                if($chapter>12&&$chapter<15){
                        $verse="13-14";
                }
                if($chapter>19&&$chapter<24){
                        $verse="20-23";
                }
                if($chapter>36&&$chapter<39){
                        $verse="37-38";
                }
		else{$verse=rand(1,47)};
	}
	if($chapter==7){$verse=rand(1,30);}
	if($chapter==8){$verse=rand(1,28);}
	if($chapter==9){$verse=rand(1,34);}
	if($chapter==10){
                if($chapter>3&&$chapter<6){
                        $verse="4-5";
                }
                if($chapter>11&&$chapter<14){
                        $verse="12-13";
                }
		else{$verse=rand(1,42);}
	}
	if($chapter==11){
                if($chapter>9&&$chapter<12){
                        $verse="10-11";
                }
                if($chapter>25&&$chapter<28){
                        $verse="26-27";
                }
                if($chapter>40&&$chapter<43){
                        $verse="41-42";
                }
		else{$verse=rand(1,55);}
	}
	if($chapter==12){
                if($chapter>2&&$chapter<5){
                        $verse="3-4";
                }
                if($chapter>5&&$chapter<8){
                        $verse="6-7";
                }
                if($chapter>12&&$chapter<15){
                        $verse="13-14";
                }
               if($chapter>17&&$chapter<20){
                        $verse="18-19";
                }
 		else{$verse=rand(1,20);}
	}
	if($chapter==13){
                if($chapter>0&&$chapter<3){
                        $verse="1-2";
                }
                if($chapter>5&&$chapter<8){
                        $verse="6-7";
                }
                if($chapter>9&&$chapter<13){
                        $verse="8-12";
                }
		else{$verse=rand(1,35);}
	}
	if($chapter==14){
        	if($chapter>21&&$chapter<26){
                        $verse="22-25";
                }
		else{$verse=ra27(1,27);}
	}
	if($chapter==15){
                if($chapter>2&&$chapter<5){
                        $verse="3-4";
                }
		else{$verse=rand(1,20);}
	}
	if($chapter==16){
                if($chapter>0&&$chapter<4){
                        $verse="1-3";
                }
                if($chapter>10&&$chapter<13){
                        $verse="11-12";
                }
                if($chapter>12&&$chapter<16){
                        $verse="13-15";
                }
		else{$verse=rand(1,24);}
	}
	if($chapter==17){
                if($chapter>4&&$chapter<7){
                        $verse="5-6";
                }
                if($chapter>25&&$chapter<28){
                        $verse="26-27";
                }
		else{$verse=rand(1,28);}
	}
	if($chapter==18){
                if($chapter>50&&$chapter<54){
                        $verse="51-53";
                }
		else{$verse=rand(1,78);}
	}
	echo $chapter . "\t"  $verse ; 
	echo "<br>";
	$c++;
}

*/

$html = file_get_contents("http://vedabase.net/bg/1/2/en");

preg_match_all(
    '/<li>.*?<h1><a href="(.*?)">(.*?)<\/a><\/h1>.*?<span class="date">(.*?)<\/span>.*?<div class="section">(.*?)<\/div>.*?<\/li>/s',
    $html,
    $posts, // will contain the blog posts
    PREG_SET_ORDER // formats data into an array of posts
);

foreach ($posts as $post) {
    $link = $post[1];
    $title = $post[2];
    $date = $post[3];
    $content = $post[4];

    // do something with data
}

?>

