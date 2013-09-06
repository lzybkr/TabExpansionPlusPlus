## Dism module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -FeatureName argument to DISM cmdlets
#
function Dism_WindowsOptionalFeatureNameCompleter
{
    [ArgumentCompleter(
        Parameter = 'FeatureName',
        Command = {Get-CommandWithParameter -Module DISM -ParameterName FeatureName},
        Description = 'Complete the -FeatureName argument to DISM cmdlets:  Get-WindowsOptionalFeature -FeatureName xps* -Online <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Dism\Get-WindowsOptionalFeature -Online | Where-Object FeatureName -like "$wordToComplete*" | Sort-Object FeatureName | ForEach-Object {
        New-CompletionResult $_.FeatureName "FeatureName '$($_.FeatureName)'"
    }
}
