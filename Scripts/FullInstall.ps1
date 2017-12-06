Param(
    [string] $BaseGroupName,
    [string] $GroupCsvLocation,
    [string] $UserCsvLocation
)

./CreateGroups.ps1 $BaseGroupName $GroupCsvLocation
./CreateUsers.ps1 $UserCsvLocation
