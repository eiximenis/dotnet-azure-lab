param(
    [string] $ResourceGroup
)

$storage = $(az storage account list -g $ResourceGroup -o json | ConvertFrom-Json)[0]

Write-Host "Uploading images to $($storage.name)"

$key = $( az storage account keys list -g $ResourceGroup --account-name $storage.name -o json | ConvertFrom-Json)[0].value

az storage blob upload-batch  -d images --account-name $storage.name --account-key $key --source ./beerlogos