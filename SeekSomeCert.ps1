<#.....................................................................................
Sigma Software
Ukraine Kharkiv

Author: Zibnitskii Aleksandr
Date: 16/10/2019
Version: 1.0

Description: скрипт для поиска сертификатов по условию строки в поле Issue сертификата
с последующим экспортом полученного массива в .csv-файл
......................................................................................#>
$currentlocation = Get-Location

$CertLocation=$null
$CertBranch=$null
$CertArray=@()
$ResultLog="D:\certlist.csv"

$AllCerts = Get-ChildItem -Recurse
foreach ($SingleCert in $AllCerts)
{
    If ($SingleCert.Location) {
        $CertLocation = $SingleCert.Location }
    If ($SingleCert.Name) {
        $CertBranch = $SingleCert.Name }
    If ($SingleCert.Issuer -contains 'CN=Sigma Software Root CA')
    {      
        $CertRecord = [ordered]@{
            FullPatch = "$CertLocation`\$CertBranch"
            eSerial = $SingleCert.ThumbPrint
            Subject = $SingleCert.Subject
            StartDate = $SingleCert.NotBefore
            EndDate = $SingleCert.NotAfter
        }
      $CertArray += New-Object psobject -Property $CertRecord
    }
}
$CertArray | Export-Csv -Delimiter ";" -Path $ResultLog -NoTypeInformation
sl $currentlocation