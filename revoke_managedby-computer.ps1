##$test = 'OU=example,DC=example,DC=test'

$computers = Get-ADComputer -filter *
$computers > C:\Data\comps.txt

#$test | ForEach (Get-ADGroup -Filter * -Properties ManagedBy -SearchBase $_ ) |
#Select Name, ManagedBy |
#Sort -Property Name |
#Out-File C:\Data\test.csv