<?php
$host=$_GET['symptom1'];
$feber=$_GET['symptom2'];
$tpust=$_GET['symptom3'];

if($host && $feber && $tpust) {
echo"Oppsøk lege umiddelbart.";
}

else if($host && $feber) {
echo"Kontakt lege dersom det blir verre.";
}

else if(isset($host)){
echo"Du er mest sannsynlig bare forkjølet, ikke noe å stresse over";
}

else if(isset($feber)){
echo"Ved veldig høy feber, oppsøk lege, men ellers bare ta febernedsettende og ta en dag på sofaen";
}

else if(isset($tpust)){
echo"Hvis du bare er tung pustet, er det ikke noe å stresse over, dette kan skyldes mange ulike ting";
}
else{echo "fyfæn!";}
?>

