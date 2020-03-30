Start-Transcript  TasksStatus.log
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
			$filen =  get-Item $file
			$bname = $filen.BaseName+".csv"
			$fullname = $filen.DirectoryName+"\"+$bname
			#write-host $fullname
			Schtasks /Query /v /s $($filen.BaseName) /FO csv > $fullname
			$csvRep = get-content $fullname
			foreach($repstr in $csvRep){
				if ($repstr.Contains("shutdown")){
					write-host $repstr -ForegroundColor Yellow 
				}
			}
		}
	}
}
Stop-Transcript