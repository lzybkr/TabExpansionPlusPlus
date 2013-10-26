## Wdac module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -Name arguments to *-OdbcDriver cmdlets
#
function Wdac_OdbcDriverNameParameterCompletion
{
    [ArgumentCompleter(
        Parameter = 'Name',
        Command = {Get-CommandWithParameter -Module Wdac -Noun OdbcDriver -ParameterName Name},
        Description = 'Complete the -Name arguments to *-OdbcDriver cmdlets. For example: Get-OdbcDriver -Name <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Wdac\Get-OdbcDriver -Name "$wordToComplete*" | Sort-Object Name | ForEach-Object {
        New-CompletionResult $_.Name "Name: $($_.Name)"
    }
}


#
# .SYNOPSIS
#
#    Complete the -Name arguments to *-OdbcDsn cmdlets
#
function Wdac_OdbcDsnNameParameterCompletion
{
    [ArgumentCompleter(
        Parameter = 'Name',
        Command = {Get-CommandWithParameter -Module Wdac -Noun OdbcDsn -ParameterName Name},
        Description = 'Complete the -Name arguments to *-OdbcDsn cmdlets. For example: Get-OdbcDsn -Name <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Wdac\Get-OdbcDsn -Name "$wordToComplete*" | Sort-Object Name | ForEach-Object {
        New-CompletionResult $_.Name "Name: $($_.Name)"
    }
}


#
# .SYNOPSIS
#
#    Complete the -DriverName arguments to *-OdbcDsn cmdlets
#
function Wdac_DriverNameParameterCompletion
{
    [ArgumentCompleter(
        Parameter = 'DriverName',
        Command = {Get-CommandWithParameter -Module Wdac -Noun OdbcDsn -ParameterName DriverName},
        Description = 'Complete the -DriverName arguments to *-OdbcDsn cmdlets. For example: Get-OdbcDsn -DriverName <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Wdac\Get-OdbcDsn -DriverName "$wordToComplete*" | Sort-Object DriverName | ForEach-Object {
        New-CompletionResult $_.DriverName "DriverName: $($_.DriverName)"
    }
}
