param (
    [string]$CsvPath = "$PSScriptRoot\random_users.csv",
    [string]$TargetOU = "OU=Users,OU=Office,DC=linax,DC=local"
)

Import-Module ActiveDirectory

$users = Import-Csv -Path $CsvPath

foreach ($user in $users) {
    Write-Host "Creating AD user: $($user.FullName)..." -ForegroundColor Cyan

    $securePassword = ConvertTo-SecureString $user.Password -AsPlainText -Force

    $upn = "$($user.Username)@linax.local"

    # Create user
    try {
        New-ADUser `
            -Name $user.FullName `
            -GivenName $user.FirstName `
            -Surname $user.LastName `
            -SamAccountName $user.Username `
            -UserPrincipalName $upn `
            -Title $user.Title `
            -Department $user.Department `
            -AccountPassword $securePassword `
            -Path $TargetOU `
            -Enabled $true `
            -ChangePasswordAtLogon $false

        Write-Host "✅ Created: $($user.Username)" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Failed to create: $($user.Username) — $_" -ForegroundColor Red
    }
}