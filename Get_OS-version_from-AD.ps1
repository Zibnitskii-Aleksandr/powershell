<#.....................................................................................
Author: Zibnitskii Aleksandr
Date: 03/09/2020
Version: 1.0

Description: скрипт для получения информации из Active Directory о версии и наименовании
операционной системы, установленной на активных (зарегистрированных в домене) хостах.
Используется PowerShell-модуль Active Directory, информация выводится в текстовый файл:
наименование файла и его месторасположение задаются в переменной OutFile
......................................................................................#>

$OutFile = 'C:\Temp\os-info.txt'
Get-ADComputer -Filter 'enabled -eq "true"' -Properties * | Sort OperatingSystem, Name | FT Name, OperatingSystem -Autosize > $OutFile