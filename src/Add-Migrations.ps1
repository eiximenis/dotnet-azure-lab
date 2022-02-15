# This script adds migrations to the supplaay database
Param
(
    [Parameter(Mandatory = $false, HelpMessage = 'Generate migrations')][bool] $generate=$true,
    [Parameter(Mandatory = $false, HelpMessage = 'Migration name')][String] $migration="NewMigration",
    [Parameter(Mandatory = $false, HelpMessage = 'Update Database')][Boolean] $apply=$false,
    [Parameter(Mandatory = $false, HelpMessage = 'Consolidate migrations (CAUTION)!!!')][Boolean] $consolidate=$false
)

Push-Location .\Beers.Api

if ($generate) {
    if ($consolidate) {
        Write-Host "Deleting previous migrations..." -ForegroundColor Green
        Get-ChildItem -Path ".\Migrations" | Remove-Item
        $migration = "Initial"
    }
    dotnet ef migrations add $migration 
}
else {
    Write-Host "Skipped generate migrations because generate is $generate" -ForegroundColor Yellow
}

if( -not $? ) {
    Write-Host "Errors detected." -ForegroundColor Red
    Pop-Location
    exit
}


if ($apply) {
    Write-Host "Applying database changes..." -ForegroundColor Green
    dotnet ef database update 
}


Pop-Location