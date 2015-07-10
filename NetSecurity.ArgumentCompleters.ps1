## NetSecurity module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -Name argument to *-NetConnectionProfile cmdlets
#
function NetFirewallRuleNameParameterCompleter
{
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
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    NetSecurity\Get-NetFirewallRule -DisplayName "$wordToComplete*" | Sort-Object DisplayName | ForEach-Object {
        New-CompletionResult $_.DisplayName "DisplayName: $($_.DisplayName)"
    }
}


Register-ArgumentCompleter `
    -Command ( Get-CommandWithParameter -Module NetSecurity -Noun NetFirewallRule -ParameterName Name | Where-Object Verb -ne New) `
    -Parameter 'Name' `
    -Description 'Complete the -Name argument to *-NetFirewallRule cmdlets, for example: Get-NetFirewallRule -Name <TAB>' `
    -ScriptBlock $function:NetFirewallRuleNameParameterCompleter


Register-ArgumentCompleter `
    -Command ( Get-CommandWithParameter -Module NetSecurity -Noun NetFirewallRule -ParameterName DisplayName | Where-Object Verb -ne New) `
    -Parameter 'DisplayName' `
    -Description 'Complete the -DisplayName argument to *-NetFirewallRule cmdlets, for example: Get-NetFirewallRule -DisplayName <TAB>' `
    -ScriptBlock $function:NetFirewallRuleDisplayNameParameterCompleter
