## NetTCPIP module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -InterfaceAlias,ifAlias arguments to NetTCPIP module cmdlets
#
function NetIPAddressInterfaceAliasParameterCompleter
{
    [ArgumentCompleter(
        Parameter = 'InterfaceAlias',
        Command = { Get-CommandWithParameter -Module NetTCPIP -ParameterName InterfaceAlias},
        Description = 'Complete InterfaceAlias names, for example: Get-NetIPAddress -InterfaceAlias <TAB>')]

    [ArgumentCompleter(
        Parameter = 'ifAlias',
        Command = { Get-CommandWithParameter -Module NetTCPIP -ParameterName ifAlias},
        Description = 'Complete ifAlias names, for example: Get-NetIPAddress -ifAlias <TAB>')]

    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    NetTCPIP\Get-NetIPAddress -InterfaceAlias "$wordToComplete*" | Sort-Object InterfaceAlias | ForEach-Object {
        New-CompletionResult $_.InterfaceAlias $_.InterfaceAlias
    }
}

