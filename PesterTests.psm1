function Install-Dependency {
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

function Invoke-TestScript {
    param (
        [Parameter(Mandatory = $true)]
        [array] $Scripts,
        [Parameter(Mandatory = $true)]
        [string] $LogDir
    )

    New-Item -ItemType Directory $LogDir -Force > $null
    $results = Invoke-Pester -PassThru -OutputFile "$LogDir\PSResults.xml" -OutputFormat "NUnitXml" -Script $Scripts
}