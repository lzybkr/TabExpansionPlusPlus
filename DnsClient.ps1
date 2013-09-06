## DnsClient module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -InterfaceAlias arguments to DnsClient module cmdlets
#
function DnsClientInterfaceAliasParameterCompleter
{
    [ArgumentCompleter(
        Parameter = 'InterfaceAlias',
        Command = {Get-CommandWithParameter -Module DnsClient -ParameterName InterfaceAlias},
        Description = 'Complete the -InterfaceAlias arguments to DnsClient module cmdlets. For example:  Get-DnsClient -InterfaceAlias <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    DnsClient\Get-DnsClient -InterfaceAlias "$wordToComplete*" | Sort-Object InterfaceAlias | ForEach-Object {
        New-CompletionResult $_.InterfaceAlias "InterfaceAlias: $($_.InterfaceAlias)"
    }
}

