## PowerShellWebAccess module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -RuleName argument to *-PswaAuthorizationRule cmdlets
#
function PowerShellWebAccess_PswaAuthorizationRuleNameParameterCompleter
{
    [ArgumentCompleter(
        Parameter = 'RuleName',
        Command = {'Get-PswaAuthorizationRule','Add-PswaAuthorizationRule'},
        Description = 'Complete the -RuleName argument to *-PswaAuthorizationRule cmdlets. For example: Get-PswaAuthorizationRule -RuleName <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    PowerShellWebAccess\Get-PswaAuthorizationRule | Where-Object RuleName -like "$wordToComplete*" | Sort-Object RuleName | ForEach-Object{
        New-CompletionResult $_.RuleName "RuleName: $($_.RuleName)"
    }
}


