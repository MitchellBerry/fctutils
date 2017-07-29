$version = Read-Host "Enter Version Number For Binaries (eg. 4.2.4)"
$url = "https://github.com/FactomProject/distribution/releases/download/v0.$version/FactomInstall-amd64.msi"
$outfile = $PSScriptRoot + "FactomInstall-amd64.msi"
$ProgressPreference="SilentlyContinue"

function FatalError{
    Write-Host $args[0]"Exiting."
    Start-Sleep -s 5
    Exit}

try{
    Write-Host "Checking for previous versions..."
    $app = Get-WmiObject -Class Win32_Product -Filter "Name = 'Factom'"
    $installedversion = $app.Version
    $guid = $app.IdentifyingNumber}
catch{
    Write-Host "No Previous Version Found."}

if ($version -eq $installedversion){
    FatalError "Version already installed."}

try{
    Invoke-WebRequest $url -OutFile $outfile
    Write-Host "Downloaded Version $version"}
catch{
    FatalError "$url
URL Not Found. Check Version Entered."}

try{
    Start-Process -FilePath "msiexec.exe" -ArgumentList @("/x", $guid) -Wait
    Write-Host "Uninstalled previous version: $installedversion"}
catch{
    "Nothing Uninstalled"}

try{
    Write-Host "Installing..."
    Start-Process $outfile -Wait}
catch{
    FatalError "Failed to install."}

try{
    Remove-Item $outfile
    Write-Host "Deleted installer file: $outfile"
    Write-Host "All Done!"
    Start-Sleep -s 5}
catch{
    FatalError "Failed to remove installation file"}
