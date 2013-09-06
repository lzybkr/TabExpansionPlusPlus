## TabExpansion++ custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -FilePath argument to Update-ArgumentCompleter
#
function UpdateArgumentFilePathCompleter
{
    [ArgumentCompleter(
        Parameter = 'FilePath',
        Command = 'Update-ArgumentCompleter',
        Description = 'Complete the -FilePath argument to Update-ArgumentCompleter: Update-ArgumentCompleter -FilePath <TAB>'
    )]
   param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    TabExpansion++\Get-ArgumentCompleter | Where-Object File -like *$wordToComplete* | ForEach-Object File | Sort-Object -Unique | Foreach-Object {
        New-CompletionResult "$PSScriptRoot\$_" $_
    }
}
