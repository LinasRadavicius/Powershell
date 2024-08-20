# STH
# Define the OU where you want to create users
$OUPath = "OU=YourOU,DC=example,DC=com"

# Number of users to create
$NumberOfUsers = 10

# Function to generate random names
function Get-RandomName {
    $FirstName = Get-Random -InputObject @("John", "Jane", "Michael", "Sarah", "David", "Emily")
    $LastName = Get-Random -InputObject @("Smith", "Johnson", "Brown", "Davis", "Miller", "Wilson")
    $FullName = "$FirstName $LastName"
    return $FirstName, $LastName
}

# Loop to create users
for ($i = 1; $i -le $NumberOfUsers; $i++) {
    $FirstName, $LastName = Get-RandomName
    $UserName = "$FirstName$LastName"  # You can customize the username generation logic
    $UserPassword = "P@ssw0rd"  # You can set a common password here or generate random ones
    
    New-ADUser -Name $UserName -GivenName $FirstName -Surname $LastName -UserPrincipalName "$UserName@example.com" -Path $OUPath -AccountPassword (ConvertTo-SecureString $UserPassword -AsPlainText -Force) -Enabled $true
    Write-Host "Created user: $UserName"
}