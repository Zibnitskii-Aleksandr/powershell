#$search_context="OU=Çâ³ëüíåí³,OU=ÄÊÏ,DC=corp,DC=cyberpolice,DC=gov,DC=ua"
$search_context="...Domain context..."

# Ïîëó÷àåì ñïèñîê âñåõ ïîëüçîâàòåëåé â Active Directory
$users = Get-ADUser -filter * -SearchBase $search_context

# Ïîëó÷àåì ñïèñîê âñåõ ãðóïï â Active Directory
$groups = Get-ADGroup -Filter *

foreach ($user in $users) {
    # Ïîëó÷àåì âñå ãðóïïû, â êîòîðûõ ñîñòîèò òåêóùèé ïîëüçîâàòåëü
    $userGroups = Get-ADUser $user.SamAccountName | Get-ADPrincipalGroupMembership

    foreach ($group in $userGroups) {
        # Óäàëÿåì òåêóùåãî ïîëüçîâàòåëÿ èç òåêóùåé ãðóïïû
#        Remove-ADGroupMember -Identity $group -Members $user -Confirm:$false
        Write-Host "Ïîëüçîâàòåëü $($user.SamAccountName) óñïåøíî óäàëåí èç ãðóïïû $($group.SamAccountName)."
    }
}
