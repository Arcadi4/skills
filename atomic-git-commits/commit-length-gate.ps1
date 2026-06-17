<#
.SYNOPSIS
  Commit with subject length enforcement (max 72 chars).
.DESCRIPTION
  Validates the subject line is ≤ 72 characters before passing to git commit.
  Each additional argument becomes a -m paragraph in the commit body.
.EXAMPLE
  ./commit-length-gate.ps1 "Fix null check in auth flow"
.EXAMPLE
  ./commit-length-gate.ps1 "Refactor session handling" "Extracted session logic into dedicated module for testability."
#>
param(
    [Parameter(Mandatory, Position = 0)]
    [string]$Subject,

    [Parameter(ValueFromRemainingArguments)]
    [string[]]$Body
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ($Subject.Length -gt 72) {
    Write-Error "Subject too long: $($Subject.Length) chars (max 72)`nSubject: $Subject"
    exit 1
}

$args = @('-m', $Subject)
foreach ($paragraph in $Body) {
    $args += @('-m', $paragraph)
}

git commit @args
