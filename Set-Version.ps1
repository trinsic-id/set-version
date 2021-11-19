param
(
    [Parameter(Mandatory = $true)]
    $Repo,
    [Parameter(Mandatory = $true)]
    $GithubToken,
    $ManualVersion
)

$json = Invoke-WebRequest "https://api.github.com/repos/$Repo/releases/latest" `
    -Headers @{ "Authorization" = "Token $GithubToken" } | ConvertFrom-Json

$version = if ([string]::IsNullOrEmpty($ManualVersion)) { $json.tag_name.Trim("v") } else { $ManualVersion.Trim("v") }

Write-Output "::set-output name=releaseVersion::$($json.tag_name)"
Write-Output "::set-output name=packageVersion::$version"