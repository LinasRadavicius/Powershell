function Generate-RandomUsers {
    param (
        [int]$UserCount = 10
    )

    $firstNameArray = @( 
        "James", "Olivia", "Amelia", "Isla", "Lily", "Ivy", "Freya", "Florence", "Mia", "Willow",
        "Sienna", "Sophia", "Elsie", "Rosie", "Grace", "Noah", "Muhammad", "George", "Oliver", "Smith",
        "Ryan", "Theo", "Theodore", "Freddie", "Archie", "Lucas", "Michael", "Jack", "Harry", "Charlie",
        "Thomas", "Isaac", "Alexander", "Roman", "Rowan", "Alexis", "Ali", "Riley", "Alex", "Eden",
        "Frankie", "Robin", "Eden", "Casey", "Lowen", "Neo"
    )

    $secondNameArray = @(
        "Smith", "Johnson", "Ryan", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis",
        "Martinez", "Hernandez", "Lopez", "Gonzales", "Wilson", "Anderson", "Thomas", "Taylor", 
        "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", 
        "Clark", "Lewis", "Ramirez", "Walker", "Young", "Allen", "King", "Wright", "Scott"
    )

    $titles = @(
        "HR Assistant", "HR Manager",
        "Office Admin", "Office Manager",
        "Finance Analyst", "Finance Manager",
        "IT Support", "IT Manager",
        "Sales Rep", "Sales Manager",
        "Marketing Executive", "Marketing Manager",
        "Customer Support", "Customer Success Manager"
    )

    $createdUsers = @()
    $uniqueUsernames = @{}

    while ($createdUsers.Count -lt $UserCount) {
        $first = Get-Random -InputObject $firstNameArray
        $last = Get-Random -InputObject $secondNameArray
        $username = ($first.Substring(0,1) + $last).ToLower()

        if ($uniqueUsernames.ContainsKey($username)) {
            continue
        }

        $password = "Welcome1"

        $title = Get-Random -InputObject $titles

        $department = $title.Split(" ")[0]

        $userObj = [PSCustomObject]@{
            FirstName = $first
            LastName = $last
            FullName = "$first $last"
            Username = $username
            Password = $password
            Title = $title
            Department = $department
        }

        $createdUsers += $userObj
        $uniqueUsernames[$username] = $true
    }

    return $createdUsers
}

$users = Generate-RandomUsers -UserCount 25
$users | Export-Csv -Path "$PSScriptRoot\random_users.csv" -NoTypeInformation
$users | Format-Table