# Using module scope
Import-Module .\Modules\Module1.psm1 -Force
Import-Module .\Modules\Module2.psm1 -Force
InModuleScope Module1 {
    Describe "Get-FunctionModule2 InModuleScope Module1" {
        It "Should Return 'Get-FunctionModule2'" {
            Get-FunctionModule2 | Should Be "Get-FunctionModule2"
        }
    }
}