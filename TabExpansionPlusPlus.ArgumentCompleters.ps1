## TabExpansion++ custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -FilePath argument to Update-ArgumentCompleter
#
function UpdateArgumentFilePathCompleter
{
   param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    TabExpansion++\Get-ArgumentCompleter | Where-Object File -like *$wordToComplete* | ForEach-Object File | Sort-Object -Unique | Foreach-Object {
        New-CompletionResult "$PSScriptRoot\$_" $_
    }
}


Register-ArgumentCompleter `
    -Command 'Update-ArgumentCompleter' `
    -Parameter 'FilePath' `
    -Description 'Complete the -FilePath argument to Update-ArgumentCompleter: Update-ArgumentCompleter -FilePath <TAB>' `
    -ScriptBlock $function:UpdateArgumentFilePathCompleter
