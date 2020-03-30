cls
$servers = get-content servers.txt

#Schtasks /Query

$filelist =@()

foreach($item in $servers){
#$item
$outf = "C:\AdminDir\sveta\sched\$item.xml"
#$outf

 Schtasks /Query /s $item /xml > $outf
 $filelist += $outf 
}


#$filelist

foreach($file in $filelist)
{
	$content = get-content $file
	foreach($strng in $content)
	{
		if ($strng.contains("shutdown")){
			write-host $file  -ForegroundColor Yellow  
			write-host "shutdown found" -ForegroundColor Yellow  
		}
	}
}
# Schtasks /Query /s DESKTOP-AQQCIKR /xml> C:\AdminDir\sveta\sched\DESKTOP-AQQCIKR.log