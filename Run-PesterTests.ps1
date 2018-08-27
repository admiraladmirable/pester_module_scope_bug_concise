function Install-DependencyLocal {
    try {
        Update-Module Pester
    }
    catch {
        Install-Module -Name Pester -Scope CurrentUser -Force -Confirm:$false -SkipPublisherCheck
    }

    try {
        Update-Module PSScriptAnalyzer
    }
    catch {
        Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force -Confirm:$false -SkipPublisherCheck
    }

    Import-Module Pester
    Import-Module PSScriptAnalyzer
}

function Invoke-TestScriptLocal {
    param (
        [Parameter(Mandatory = $true)]
        [array] $Scripts,
        [Parameter(Mandatory = $true)]
        [string] $LogDir
    )

    New-Item -ItemType Directory $LogDir -Force > $null
    $results = Invoke-Pester -PassThru -OutputFile "$LogDir\PSResults.xml" -OutputFormat "NUnitXml" -Script $Scripts
}

# Calling Invoke-Pester via local wrapper function
Write-Host "Executing tests in local context"
Install-DependencyLocal
Invoke-TestScriptLocal -Scripts @(".\Tests\LocalScope.Tests.ps1", ".\Tests\InModuleScope.Tests.ps1") -LogDir "$PSScriptRoot\localLogs"

# Calling Invoke-Pester via imported module wrapper function
Import-Module .\PesterTests.psm1
Write-Host "Executing tests in module context [Import-Module]"
Install-Dependency
Invoke-TestScript -Scripts @(".\Tests\LocalScope.Tests.ps1", ".\Tests\InModuleScope.Tests.ps1") -LogDir "$PSScriptRoot\moduleLogs"