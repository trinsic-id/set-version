param
(
    [Parameter(Mandatory = $true)]
    $Repo,
    [Parameter(Mandatory = $true)]
    $GithubToken,
    $ManualVersion
)
$json = ""
try {
    $json = Invoke-WebRequest "https://api.github.com/repos/$Repo/releases/latest" `
        -Headers @{ "Authorization" = "Token $GithubToken" } | ConvertFrom-Json
} catch { 
    # Do nothing if the release is manually overridden
}

$version = if ([string]::IsNullOrEmpty($ManualVersion)) { $json.tag_name.Trim("v") } else { $ManualVersion.Trim("v") }

echo "releaseVersion=$($json.tag_name)" >> $env:GITHUB_OUTPUT
echo "packageVersion=$version" >> $env:GITHUB_OUTPUT
