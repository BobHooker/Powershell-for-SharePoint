Add-PSSnapin Microsoft.SharePoint.Powershell

#
# 
# In this code you will  set the url, the code assumes 3 security groups
# I copies the members of the groups, restores a backup from C drive
# Then it restores the old user set, removing the back users
#


$urlid = <URL in form "http://fcdn">

$oldm = Get-SPuser -Web $urlid  -Group "Team Site Members"
$oldo = Get-SPuser -Web $urlid  -Group "Team Site Owners"
$oldv = Get-SPuser -Web $urlid  -Group "Team Site Visitors"
 
Restore-SPSite $urlid  -Path C:\backup\back.back -Force

$newm = Get-SPuser -Web $urlid  -Group "Team Site Members"
$newo = Get-SPuser -Web $urlid  -Group "Team Site Owners"
$newv = Get-SPuser -Web $urlid -Group "Team Site Visitors"
 
foreach ($spuser in $newm){Remove-SPUser -Web $urlid  -Identity $spuser -Group "Team Site Members" -confirm:$false}
foreach ($spuser in $newo){Remove-SPUser -Web $urlid  -Identity $spuser -Group "Team Site Owners" -confirm:$false}

foreach ($spuser in $newv){Remove-SPUser -Web $urlid  -Identity $spuser -Group "Team Site Visitors" -confirm:$false}
 
 
foreach ($spuser in $oldm){Set-SPUser -Web $urlid  -Identity $spuser -Group "Team Site Members" -confirm:$false}
foreach ($spuser in $oldo){Set-SPUser -Web $urlid  -Identity $spuser -Group "Team Site Owners" -confirm:$false}

foreach ($spuser in $oldv){Set-SPUser -Web $urlid  -Identity $spuser -Group "Team Site Visitors" -confirm:$false}
 
 
## In testing I found it made sense to force a Team Site Owner account as the last step

Set-SPUser -Web $urlid  -Identity <AD id of owner> -Group "Team Site Owners"
 

write-host "Done"
