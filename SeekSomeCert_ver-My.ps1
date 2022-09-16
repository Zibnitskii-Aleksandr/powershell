<#.....................................................................................
Sigma Software
Ukraine Kharkiv

Author: Zibnitskii Aleksandr
Date: 16/10/2019
Version: 1.1

Description: скрипт для поиска сертификатов по условию строки в поле Issue сертификата
с последующим экспортом полученного массива в .csv-файл
(проверяются только разделы Personal)
......................................................................................#>
$CertSeekPatch = @("CurrentUser","LocalMachine")
$CertArray =@()
$ResultLog="D:\certlist.csv"

$CurrentLocation = Get-Location

Function FindCert
{
    $FindCertArray =@()
    $AllCerts = Get-ChildItem -Recurse
    foreach ($SingleCert in $AllCerts)
    {
        If ($SingleCert.Issuer -like '*Access*')
            {      
            $CertRecord = [ordered]@{
                FullPatch = Get-Location
                eSerial = $SingleCert.ThumbPrint
                Subject = $SingleCert.Subject
                StartDate = $SingleCert.NotBefore
                EndDate = $SingleCert.NotAfter
                }
        $FindCertArray += New-Object psobject -Property $CertRecord
        }
    }
    Return $FindCertArray
}

for ($i=0; $i -lt $CertSeekPatch.count; $i++)
{
    sl "Cert:\"+$CertSeekPatch[$i]+"`\My"
    $CertArray += FindCert
}
$CertArray | Export-Csv -Delimiter ";" -Path $ResultLog -NoTypeInformation
sl $CurrentLocation

