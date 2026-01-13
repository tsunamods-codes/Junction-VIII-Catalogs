if ($env:_BUILD_BRANCH -eq "refs/heads/master" -Or $env:_BUILD_BRANCH -eq "refs/tags/canary") {
  $env:_IS_BUILD_CANARY = "true"
  $env:_IS_GITHUB_RELEASE = "true"
}
elseif ($env:_BUILD_BRANCH -like "refs/tags/*") {
  $env:_BUILD_VERSION = $env:_BUILD_VERSION.Substring(0, $env:_BUILD_VERSION.LastIndexOf('.')) + ".0"
  $env:_IS_GITHUB_RELEASE = "true"
}
$env:_RELEASE_VERSION = "v${env:_BUILD_VERSION}"

Write-Output "--------------------------------------------------"
Write-Output "RELEASE VERSION: $env:_RELEASE_VERSION"
Write-Output "--------------------------------------------------"

Write-Output "_BUILD_VERSION=${env:_BUILD_VERSION}" >> ${env:GITHUB_ENV}
Write-Output "_RELEASE_VERSION=${env:_RELEASE_VERSION}" >> ${env:GITHUB_ENV}
Write-Output "_IS_BUILD_CANARY=${env:_IS_BUILD_CANARY}" >> ${env:GITHUB_ENV}
Write-Output "_IS_GITHUB_RELEASE=${env:_IS_GITHUB_RELEASE}" >> ${env:GITHUB_ENV}

# Combine XML files
$finalXml = "tsunamods.xml"
Set-Content -Path $finalXml -Value '<?xml version="1.0"?>'
Add-Content -Path $finalXml -Value '<Catalog Name="Tsunamods Catalog" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'
Add-Content -Path $finalXml -Value '<Mods>'

# Loop over XML files
$files = Get-ChildItem -Path "mods" -Recurse -Filter *.xml
foreach ($file in $files) {
    # Read the mod.xml
    $xml = Get-Content -LiteralPath $file.FullName -Raw

    # Remove the initial xml tag
    $xml = $xml.Replace('<?xml version="1.0"?>', '')

    # Add content to final xml
    Add-Content -Path $finalXml -Value $xml
}

Add-Content -Path $finalXml -Value '</Mods>'
Add-Content -Path $finalXml -Value '</Catalog>'

# Lint the final XML
dotnet run --project app/CatalogValidator $finalXml

if ($LASTEXITCODE -ne 0) {
  Write-Error "Catalog validation failed for: $finalXml"
  exit $LASTEXITCODE
}
