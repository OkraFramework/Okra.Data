Import-Module -Name ".\HelperFunctions.psm1"
Import-Module -Name ".\Invoke-MsBuild.psm1"

# Move to the project root folder (parent from current script folder)

$rootFolder = (Get-Item (Get-ScriptDirectory)).Parent.FullName
Set-Location $rootFolder

# Create the artifacts directory if it doesn't exist

New-Item .\artifacts -type directory -Force

# Perform builds

$okraDataBuild = Invoke-MsBuild -Path ".\src\Okra.Data\Okra.Data.csproj" -Params "/verbosity:minimal /property:Configuration=Release;VisualStudioVersion=12.0"

if (!$okraDataBuild)
{
    throw("Building Okra.Data failed")
}

# Check NuGet is installed and updated

If (!(Test-Path .\.nuget\nuget.exe))
{
    New-Item .\.nuget -type directory -Force
    Invoke-WebRequest 'https://www.nuget.org/nuget.exe' -OutFile '.\.nuget\nuget.exe'
}

.\.nuget\NuGet.exe update -self

# Create packages

.\.nuget\NuGet.exe pack .\src\Okra.Data\Okra.Data.nuspec -Prop Configuration=Release -Output .\artifacts -Symbols


