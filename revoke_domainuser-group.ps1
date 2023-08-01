#$search_context="OU=Звільнені,OU=ДКП,DC=corp,DC=cyberpolice,DC=gov,DC=ua"
$search_context="OU=Test-GPO,DC=corp,DC=cyberpolice,DC=gov,DC=ua"

# Получаем список всех пользователей в Active Directory
$users = Get-ADUser -filter * -SearchBase $search_context

# Получаем список всех групп в Active Directory
$groups = Get-ADGroup -Filter *

foreach ($user in $users) {
    # Получаем все группы, в которых состоит текущий пользователь
    $userGroups = Get-ADUser $user.SamAccountName | Get-ADPrincipalGroupMembership

    foreach ($group in $userGroups) {
        # Удаляем текущего пользователя из текущей группы
#        Remove-ADGroupMember -Identity $group -Members $user -Confirm:$false
        Write-Host "Пользователь $($user.SamAccountName) успешно удален из группы $($group.SamAccountName)."
    }
}
