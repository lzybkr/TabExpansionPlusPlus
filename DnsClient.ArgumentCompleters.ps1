## DnsClient module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -InterfaceAlias arguments to DnsClient module cmdlets
#
function DnsClientInterfaceAliasParameterCompleter
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    DnsClient\Get-DnsClient -InterfaceAlias "$wordToComplete*" | Sort-Object InterfaceAlias | ForEach-Object {
        New-CompletionResult $_.InterfaceAlias "InterfaceAlias: $($_.InterfaceAlias)"
    }
}


Register-ArgumentCompleter `
    -Command ('Get-DnsClient','Get-DnsClientServerAddress','Set-DnsClient','Set-DnsClientServerAddress') `
    -Parameter 'InterfaceAlias' `
    -Description 'Complete the -InterfaceAlias arguments to DnsClient module cmdlets. For example:  Get-DnsClient -InterfaceAlias <TAB>' `
    -ScriptBlock $function:DnsClientInterfaceAliasParameterCompleter
