$AllProfiles = Get-ChildItem "C:\Users" | ? {$_.Name -notin @("Public","Default User","Temp","All Users") -and (Test-Path "$($_.FullName)\Downloads")}

foreach ($profile in $AllProfiles) {
$downloadsPath = "$($profile.FullName)\Downloads"
Get-ChildItem -Path $downloadsPath -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue }