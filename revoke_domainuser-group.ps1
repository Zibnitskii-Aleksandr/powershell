#$search_context="OU=�������,OU=���,DC=corp,DC=cyberpolice,DC=gov,DC=ua"
$search_context="OU=Test-GPO,DC=corp,DC=cyberpolice,DC=gov,DC=ua"

# �������� ������ ���� ������������� � Active Directory
$users = Get-ADUser -filter * -SearchBase $search_context

# �������� ������ ���� ����� � Active Directory
$groups = Get-ADGroup -Filter *

foreach ($user in $users) {
    # �������� ��� ������, � ������� ������� ������� ������������
    $userGroups = Get-ADUser $user.SamAccountName | Get-ADPrincipalGroupMembership

    foreach ($group in $userGroups) {
        # ������� �������� ������������ �� ������� ������
#        Remove-ADGroupMember -Identity $group -Members $user -Confirm:$false
        Write-Host "������������ $($user.SamAccountName) ������� ������ �� ������ $($group.SamAccountName)."
    }
}
