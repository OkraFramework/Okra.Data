function Update-AssemblyInfo
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$True, Position = 1)][string]$FileName,
        [Parameter(Mandatory=$True, Position = 2)][Version]$VersionNumber
    )

    $assemblyVersionRegex = 'AssemblyVersion\("[^"]+"\)'
    $assemblyVersion = 'AssemblyVersion("' + $VersionNumber + '")'

    $assemblyFileVersionRegex = 'AssemblyFileVersion\("[^"]+"\)'
    $assemblyFileVersion = 'AssemblyFileVersion("' + $VersionNumber + '")'

    $assemblyInformationalVersionRegex = 'AssemblyInformationalVersion\("[^"]+"\)'
    $assemblyInformationalVersion = 'AssemblyInformationalVersion("' + $VersionNumber.ToString(3) + '")'

    (Get-Content $FileName) |
        ForEach-Object {$_ -replace $assemblyVersionRegex, $assemblyVersion} |
        ForEach-Object {$_ -replace $assemblyFileVersionRegex, $assemblyFileVersion} |
        ForEach-Object {$_ -replace $assemblyInformationalVersionRegex, $assemblyInformationalVersion} |
        Set-Content $FileName
}

function Update-Nuspec
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$True, Position = 1)][string]$FileName,
        [Parameter(Mandatory=$True, Position = 2)][Version]$VersionNumber
    )

    $versionRegex = '<version>[^\<]+</version>'
    $version = '<version>' + $VersionNumber + '</version>'

    (Get-Content $FileName) |
        ForEach-Object {$_ -replace $versionRegex, $version} |
        Set-Content $FileName
}

Export-ModuleMember -Function Update-AssemblyInfo
Export-ModuleMember -Function Update-Nuspec