$prefix = $Global:globalVariables.prefix
$ftpBaseResultFolder = "PS Reports"
$ftpResultFolder = "$ftpBaseResultFolder/$($Global:globalVariables.prefix)"


$ipaddress = $(ipconfig | where {$_ -match 'IPv4.+\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' } | out-null; $Matches[1])
$PSShell = $PSVersionTable.PsVersion.Major 
"IP Address of the server"+" " +$ipaddress +"  " + "Version of PS is" +"  "+ $PSShell | out-file 'c:\temp\version.txt'

$localFile = 'c:\temp\version.txt'
New-FTPDirectory $ftpBaseResultFolder
New-FTPDirectory $ftpResultFolder

Send-File "$($ftpResultFolder)/$($Global:globalVariables.prefix).txt" $localFile
LogMessage "PS Version report uploaded."