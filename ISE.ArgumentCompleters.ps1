## ISE custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -Module argument to Import-IseSnippet
#
function IseSnippetModuleCompleter
{
    [ArgumentCompleter(
        Parameter = 'Module',
        Command = 'Import-IseSnippet',
        Description = 'Complete the -Module argument to Import-IseSnippet: Import-IseSnippet -Module <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Microsoft.PowerShell.Core\Get-Module -Name "$wordToComplete*" -ListAvailable | Sort-Object Name | Foreach-Object {
        New-CompletionResult $_.Name $_.Name
    }
}
