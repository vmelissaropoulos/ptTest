# >>> This must run on Powershell 5.1. Pwsh 7.x is not compatible

$workingFolder = (Get-Item $PSCommandPath).Directory
$rootSampleName = "SAMPLE"

Set-Location $workingFolder
$rootSamplePath = Join-Path $workingFolder $rootSampleName

$rootSample = Get-Item $rootSamplePath 
 
Set-Location $rootSample

#This solution should work  despite the depth level of the file "script.mts"

foreach ($aFolder in $(Get-ChildItem -Directory)) {

$rootFolderPath= Join-Path $rootSamplePath $aFolder

$rootFolder = Get-Item $rootFolderPath

Set-Location $rootFolder


# >>> This way if a folder has a file named something_script.mts_somethingelse is still considered to exist but we only need the 'script.mts'
Get-ChildItem  -Directory |
Where-Object { -not (Get-ChildItem $_ -File -Recurse  -Filter *script.mts*) } |
Select-Object FullName

}
Set-Location $workingFolder