$sysmonExePath = "\\linax-dc\Share\Sysmon\Sysmon64.exe"
$sysmonConfig = "\\linax-dc\Share\Sysmon\sysmonconfig-export.xml"


## in this use it dynamically as below OR you can paste hash manually
$configHash = (Get-FileHash $sysmonConfig).Hash

## ^^ Defining paths to installs || Check if Sysmon already exists
$sysmonService = Get-Service "Sysmon64" -ErrorAction SilentlyContinue

if ($null -ne $sysmonService)
{
    ##Get current config hash 
    $configOutput = & $sysmonExePath -c
    $hashLine = ($configOutput | ? { $_ -match "SHA256=" }) -replace ".*SHA256=", ""
    Write-Output("Current hash: " + $hashLine )

    if ($hashLine -eq $configHash ){
        
        return
    }
    else{
        & $sysmonExePath -c $sysmonConfig

    }

}
else{
    & $sysmonExePath -i $sysmonConfig -accepteula 
}
