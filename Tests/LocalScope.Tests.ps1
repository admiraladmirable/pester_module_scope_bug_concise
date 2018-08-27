# Using normal scope
Import-Module .\Modules\Module1.psm1 -Force
Import-Module .\Modules\Module2.psm1 -Force
Describe "Get-FunctionModule2 Normal Scope" {
    It "Should Return 'Get-FunctionModule2'" {
        Get-FunctionModule2 | Should Be "Get-FunctionModule2"
    }
}