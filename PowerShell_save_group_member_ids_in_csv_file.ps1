Add-PSSnapin Microsoft.SharePoint.Powershell

///This code has been tested in SharePoint 2010 and 2013
//Essentailly, by changing the URL and group names, and location at the end of document
//It copies all your group memembers and saves them to 3 csv files


$url="http://win-l31vicrc3b5:1966/"
$members="Bob Members"
$owners="Bob Owners
$visiors="Bob Visitors"

$oldm = Get-SPuser -Web $url -Group $members
$oldo = Get-SPuser -Web $url -Group $owners
$oldv = Get-SPuser -Web $url -Group $visitors
 
 

$results=@()
$results1=@()
$results2=@()
 
 

foreach ($spuser in $oldm){

$psObject = $null
$psObject = New-Object psobject
 Add-Member -InputObject $psobject -MemberType noteproperty `
    -Name 'Members' -Value $spuser

$results += $psObject

}
foreach ($spuser in $oldo){
 
$psObject1 = $null
$psObject1 = New-Object psobject
 Add-Member -InputObject $psobject1 -MemberType noteproperty `
    -Name 'Owners' -Value $spuser

$results1 += $psObject1
}

foreach ($spuser in $oldv){

$psObject2 = $null
$psObject2 = New-Object psobject
 Add-Member -InputObject $psobject2 -MemberType noteproperty `
    -Name 'Visitors' -Value $spuser

$results2 += $psObject2
}

$results | Export-Csv c:\backup\2013members.csv -NoTypeInformation -Force
$results1 | Export-Csv c:\backup\2013owners.csv -NoTypeInformation -Force
$results2 | Export-Csv c:\backup\2013visitors.csv -NoTypeInformation -Force

write-host "Done"
$host.enternestedprompt()
