## ISE custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -Module argument to Import-IseSnippet
#
function IseSnippetModuleCompleter
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Microsoft.PowerShell.Core\Get-Module -Name "$wordToComplete*" -ListAvailable | Sort-Object Name | Foreach-Object {
        New-CompletionResult $_.Name $_.Name
    }
}


Register-ArgumentCompleter `
    -Command 'Import-IseSnippet' `
    -Parameter 'Module' `
    -Description 'Complete the -Module argument to Import-IseSnippet: Import-IseSnippet -Module <TAB>' `
    -ScriptBlock $function:IseSnippetModuleCompleter
