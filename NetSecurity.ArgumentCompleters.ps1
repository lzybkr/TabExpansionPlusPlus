## NetSecurity module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -Name argument to *-NetConnectionProfile cmdlets
#
function NetFirewallRuleNameParameterCompleter
{
    [ArgumentCompleter(
        Parameter = 'Name',
        Command = { Get-CommandWithParameter -Module NetSecurity -Noun NetFirewallRule -ParameterName Name | Where-Object Verb -ne New},
        Description = 'Complete the -Name argument to *-NetFirewallRule cmdlets, for example: Get-NetFirewallRule -Name <TAB>')]

    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    NetSecurity\Get-NetFirewallRule -Name "$wordToComplete*" | Sort-Object Name | ForEach-Object {
        New-CompletionResult $_.Name "Name: $($_.Name)"
    }
}


#
# .SYNOPSIS
#
#    Complete the -DisplayName argument to *-NetFirewallRule cmdlets
#
function NetFirewallRuleDisplayNameParameterCompleter
{
    [ArgumentCompleter(
        Parameter = 'DisplayName',
        Command = { Get-CommandWithParameter -Module NetSecurity -Noun NetFirewallRule -ParameterName DisplayName | Where-Object Verb -ne New},
        Description = 'Complete the -DisplayName argument to *-NetFirewallRule cmdlets, for example: Get-NetFirewallRule -DisplayName <TAB>')]

    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    NetSecurity\Get-NetFirewallRule -DisplayName "$wordToComplete*" | Sort-Object DisplayName | ForEach-Object {
        New-CompletionResult $_.DisplayName "DisplayName: $($_.DisplayName)"
    }
}

