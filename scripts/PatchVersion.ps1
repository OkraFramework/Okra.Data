[CmdletBinding()]
Param([Parameter(Mandatory=$True)][Version]$versionNumber)

# Validate parameters

If ($versionNumber.Revision -eq -1)
{
    throw "Paramter error: Version numbers should be four digit"
}

# Move to the project root folder (parent from current script folder)

function Get-ScriptDirectory
{ 
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value 
    Split-Path $Invocation.MyCommand.Path 
}

$rootFolder = (Get-Item (Get-ScriptDirectory)).Parent.FullName
Set-Location $rootFolder

# Import modules

Import-Module -Name ".\scripts\Update-Version.psm1"

# Patch files

write-host "Patching AssemblyInfo.cs files to" $versionNumber.ToString()

Update-AssemblyInfo ".\src\Okra.Data\Properties\AssemblyInfo.cs" $versionNumber
Update-AssemblyInfo ".\test\Okra.Data.Tests\Properties\AssemblyInfo.cs" $versionNumber

write-host "Patching *.nuspec files to" $versionNumber

Update-Nuspec ".\src\Okra.Data\Okra.Data.nuspec" $versionNumber.ToString()