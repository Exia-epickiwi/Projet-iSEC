Param(
    [string] $BaseGroupName,
    [string] $GroupCsvLocation,
    [string] $ServicesHomeLocation
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

            if((Get-ADGroup -Filter ("name -Like '{0}'" -f $_.name)).Length -eq 0){
                Write-Output ("Création du groupe {0} ({1})" -f $_.displayName,$_.name)
                $parent = Get-ADOrganizationalUnit -Filter ("name -Like '{0}'" -f $_.name)
                New-ADGroup -Name $_.name -DisplayName $_.displayName -Description $_.description -GroupScope $_.groupScope -GroupCategory $_.groupType -Path $parent
            } else {
                Write-Output ("Le groupe {0} ({1}) existe déjÃ " -f $_.displayName,$_.name)
            }

            $servicePath = "{0}\{1}" -f $ServicesHomeLocation,$_.name
            if(-Not (Test-Path $servicePath)){
                Write-Output "Création du dossier de service"
                New-Item $servicePath -ItemType directory > $null
            }
        } else {
            Write-Output ("L'unité d'organisation {0} ({1}) existe déjà " -f $_.displayName,$_.name)
            $groupCounter--
        }
    } else {
        if((Get-ADGroup -Filter ("name -Like '{0}'" -f $_.name)).Length -eq 0){
            Write-Output ("Création du groupe {0} ({1})" -f $_.displayName,$_.name)
            $parent = Get-ADOrganizationalUnit -Filter ("name -Like '{0}'" -f $_.parentGroup)
            New-ADGroup -Name $_.name -DisplayName $_.displayName -Description $_.description -GroupScope $_.groupScope -GroupCategory $_.groupType -Path $parent

            if((Get-ADGroup -Filter ("name -Like '{0}'" -f $_.parentGroup)).Length -eq 0){
                Write-Output ("Le groupe parent {0} n'existe pas" -f $_.parentGroup)
            } else {
                $pgroup = Get-ADGroup -Filter ("name -Like '{0}'" -f $_.parentGroup)
                Add-ADGroupMember -Identity $pgroup -Members (Get-ADGroup -Filter ("name -Like '{0}'" -f $_.name))
            }

        } else {
            Write-Output ("Le groupe {0} ({1}) existe déjà " -f $_.displayName,$_.name)
            $groupCounter--
        }
    }
    $groupCounter++
}

Write-Output ("Tout les groupes ont été créés ({0} opérations)" -f $groupCounter)
