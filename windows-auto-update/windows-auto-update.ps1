$version = Read-Host "Enter Version Number For Binaries (eg. 4.2.4)"
$url = "https://github.com/FactomProject/distribution/releases/download/v0.$version/FactomInstall-amd64.msi"
$outfile = $PSScriptRoot + "FactomInstall-amd64.msi"

try{
    $app = Get-WmiObject -Class Win32_Product -Filter "Name = 'Factom'"
    $installedversion = $app.Version
    $guid = $app.IdentifyingNumber}
catch{
    Write-Host "No Previous Version Found"}

function FatalError{
    Write-Host $args[0]
    Start-Sleep -s 3
    Exit}

if ($version -eq $installedversion){
    FatalError "Version number entered is already installed"}

try{
    Invoke-WebRequest $url -OutFile $outfile}
catch{
    FatalError "Version not found: $version. Exiting"}

try{
    Write-Host "Uninstalling previous version: $installedversion"
    Start-Process -FilePath "msiexec.exe" -ArgumentList @("/x", $guid) -Wait}
catch{
    FatalError "Failed to Uninstall"}

try{
    Write-Host "Installing..."
    Start-Process $outfile -Wait
    Write-Host "Removing installer file..."
    Remove-Item $outfile
    Write-host "All Done!"}
catch{
    FatalError "Failed to install"}
