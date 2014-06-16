# Move to the project root folder (parent from current script folder)

function Get-ScriptDirectory
{ 
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value 
    Split-Path $Invocation.MyCommand.Path 
}

$rootFolder = (Get-Item (Get-ScriptDirectory)).Parent.FullName
Set-Location $rootFolder

# Import modules

Import-Module -Name ".\scripts\Invoke-MsBuild.psm1"

# Perform builds

$okraDataBuild = Invoke-MsBuild -Path ".\src\Okra.Data\Okra.Data.csproj" -Params "/verbosity:minimal /property:Configuration=Release;VisualStudioVersion=12.0"

if (!$okraDataBuild)
{
    throw("Building Okra.Data failed")
}