Param(
    [string] $DomainName,
    [string] $BaseGroupName,
    [string] $GroupCsvLocation,
    [string] $UserCsvLocation,
    [string] $UserHomeLocation,
    [string] $ServicesHomeLocation,
    [string] $HomeShareName,
    [string] $ServiceShareName
)

.\InitialInstall.ps1 $UserHomeLocation $ServicesHomeLocation $HomeShareName $ServiceShareName
Write-Output ""
.\CreateGroups.ps1 $BaseGroupName $GroupCsvLocation $ServicesHomeLocation
Write-Output ""
.\CreateUsers.ps1 $DomainName $UserCsvLocation $HomeShareName
