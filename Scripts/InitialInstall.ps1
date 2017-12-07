Param(
    [string] $UserHomeLocation,
    [string] $ServicesHomeLocation,
    [string] $HomeShareName,
    [string] $ServiceShareName
)

if(-Not (Test-Path $UserHomeLocation)){
    Write-Output "Création du dossier de base utilisateur"
    New-Item $UserHomeLocation -ItemType directory > $null
    New-SmbShare -Name $HomeShareName -Path $UserHomeLocation > $null
}

if(-Not (Test-Path $ServiceShareName)){
    Write-Output "Création du dossier de base services"
    New-Item $ServicesHomeLocation -ItemType directory > $null
    New-SmbShare -Name $ServiceShareName -Path $ServicesHomeLocation > $null
}