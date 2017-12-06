Param(
    [string] $BaseGroupName,
    [string] $GroupCsvLocation
)

$rootOUGroup = Get-ADOrganizationalUnit -Filter ("name -Like '{0}'" -f $BaseGroupName)
if($rootOUGroup.length -eq 0){
    Write-Output "Le groupe initial n'éxiste pas, il sera créé"
    New-ADOrganizationalUnit -Name $BaseGroupName.ToLower()
    $rootOUGroup = Get-ADOrganizationalUnit -Filter ("name -Like '{0}'" -f $BaseGroupName)
}

$rawCsvGroups = Import-Csv $GroupCsvLocation -Delimiter ";"
$groupCounter = 0

$rawCsvGroups | % {
    if($_.parentGroup -eq ""){
        if((Get-ADOrganizationalUnit -Filter ("name -Like '{0}'" -f $_.name)).Length -eq 0){
            Write-Output ("Création de l'unité d'organisation {0} ({1})" -f $_.displayName,$_.name)
            New-ADOrganizationalUnit -Name $_.name -DisplayName $_.displayName -Description $_.description -Path $rootOUGroup
        } else {
            Write-Output ("L'unité d'organisation {0} ({1}) existe déjà " -f $_.displayName,$_.name)
            $groupCounter--
        }
    } else {
        if((Get-ADGroup -Filter ("name -Like '{0}'" -f $_.name)).Length -eq 0){
            Write-Output ("Création du groupe {0} ({1})" -f $_.displayName,$_.name)
            $parent = Get-ADOrganizationalUnit -Filter ("name -Like '{0}'" -f $_.parentGroup)
            New-ADGroup -Name $_.name -DisplayName $_.displayName -Description $_.description -GroupScope $_.groupScope -GroupCategory $_.groupType -Path $parent
        } else {
            Write-Output ("Le groupe {0} ({1}) existe déjÃ " -f $_.displayName,$_.name)
            $groupCounter--
        }
    }
    $groupCounter++
}

Write-Output ("Tout les groupes ont été créés ({0} opérations)" -f $groupCounter)
