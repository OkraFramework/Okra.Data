# Move to the project root folder (parent from current script folder)

function Get-ScriptDirectory
{ 
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value 
    Split-Path $Invocation.MyCommand.Path 
}

$rootFolder = (Get-Item (Get-ScriptDirectory)).Parent.FullName
Set-Location $rootFolder

# Functions

function Remove-IfExists
{
    Param([string]$filePath)

    If (Test-Path $filePath)
    {
        Remove-Item $filePath -Recurse
    }
}

# Remove the artifacts folder

Remove-IfExists .\artifacts

# Remove any build artifacts

Remove-IfExists .\src\Okra.Data\bin
Remove-IfExists .\src\Okra.Data\obj
Remove-IfExists .\test\Okra.Data.Tests\bin
Remove-IfExists .\test\Okra.Data.Tests\obj