Param(
    [string] $UserCsvLocation
)

function Get-ADParent ([string] $dn){
    $parts = $dn -split '(?<![\\]),'
    $parts[1..$($parts.Count-1)] -join ','
}

$rawCsvUsers = Import-Csv $UserCsvLocation -Delimiter ";"
$userCounter = 0

$rawCsvUsers | % {

    $group = Get-ADGroup -Filter ("name -Like '{0}'" -f $_.groupe)
    if($group.length -eq 0){
        Write-Output ("Le groupe {0} de l'utilisateur {1} {2} n'existe pas" -f $_.groupe,$_.prenom,$_.nom)
    } else {
        $name = "{0}-{1}" -f $_.prenom.ToLower(),$_.nom.ToLower()
        if((Get-ADUser -Filter ("name -Like '{0}'" -f $name)).length -eq 0){
            Write-Output ("Cr�ation de l'utilisateur {1} {2}" -f $_.groupe,$_.prenom,$_.nom)
            $parent = Get-ADParent($group)
            $password = ConvertTo-SecureString "Cesi2017!" -AsPlainText -Force
            New-ADUser -Name $name -GivenName $_.prenom -Surname $_.nom -SamAccountName $_.login -Enabled:$true -AccountPassword $password -Path $parent
            Add-ADGroupMember -Identity $group -Members (Get-ADUser -Filter ("name -Like '{0}'" -f $name))
        } else {
            Write-Output ("L'utilisateur {1} {2} n'existe pas" -f $_.groupe,$_.prenom,$_.nom)
            $userCounter--
        }
    }
    $userCounter++

}

Write-Output ("Tout les utilisateurs ont �t� cr��s ({0} op�rations)" -f $userCounter)
