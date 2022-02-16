param(
    [string] $ResourceGroup,
    [string] $DbPassword
) 

$pgsql = $(az postgres server list -o json -g $ResourceGroup | ConvertFrom-Json)[0]

$constr = "Host=$($pgsql.fullyQualifiedDomainName);Database=beers;Username=$($pgsql.administratorLogin)@$($pgsql.fullyQualifiedDomainName);Password=$DbPassword" 

$Env:ConnectionStrings__beers=$constr

Push-Location ..\..\src
.\Add-Migrations.ps1 -apply $true -generate $false
Push-Location Beers.Api
dotnet run /seed
Pop-Location
Pop-Location
$Env:ConnectionStrings__beers=""