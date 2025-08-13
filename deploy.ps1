function Symlink-File {
    $DestPath = $args[0]
    $SourcePath = $args[1]
    if (Test-Path $DestPath) {
        Write-Warning "$DestPath is already symlinked"
    } else {
        if ((Get-Item $SourcePath) -is [System.IO.DirectoryInfo]) {
            cmd /c mklink /D "$DestPath" "$SourcePath"
        } else {
            cmd /c mklink "$DestPath" "$SourcePath"
        }
        echo "$DestPath has been symlinked"
    }
}

function Deploy-Manifest {
    $ManifestFile = $args[0]

    echo "Deploying $ManifestFile..."

    $Manifest = Import-Csv -Header ("source", "dest") -Delimiter ("|") -Path ".\$ManifestFile"
    foreach ($ManifestRow in $Manifest) {
        $DeployFile = $ManifestRow.source
        $SourcePath = "$PSScriptRoot\$DeployFile"

        $DestFile = $ManifestRow.dest
        $DestPath = "$Home\$DestFile"

        Symlink-File $DestPath $SourcePath
    }
}

$HomeExists = Test-Path Env:HOME
if ($HomeExists -ne $True) {
    echo "Creating HOME environment variable and targeting it to $env:USERPROFILE"
    [Environment]::SetEnvironmentVariable("HOME", $env:USERPROFILE, "User")
} else {
    Write-Warning "HOME environment variable already exists. Not modifying the existing value."
}

Deploy-Manifest MANIFEST

pause
