## NetAdapter module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -Name argument to Get-VM
#
function NetAdapter_AdapterNameArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'Name',
        Command = { Get-CommandWithParameter -Module NetAdapter -ParameterName Name },
        Description = 'Complete Adapter names, for example: Get-NetAdapter -Name <TAB>')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)


    NetAdapter\Get-NetAdapter -Name "$wordToComplete*" |
        Sort-Object |
        ForEach-Object {
            $toolTip = "Index: $($_.IfIndex) Description: $($_.InterfaceDescription)"
            New-CompletionResult $_.Name $toolTip
        } 
}

function NetAdapter_InterfaceIndexArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'InterfaceIndex',
        Command = { Get-CommandWithParameter -Module NetAdapter -ParameterName InterfaceIndex },
        Description = 'Complete interface indexes, for example: Get-NetAdapter -InterfaceIndex <TAB>')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)


    NetAdapter\Get-NetAdapter | where InterfaceIndex -Like "$wordToComplete*" |
        Sort-Object |
        ForEach-Object {
            $toolTip = "Name: $($_.Name) Description: $($_.InterfaceDescription)"
            New-CompletionResult $_.InterfaceIndex $toolTip
        } 
}

function NetAdapter_InterfaceDescriptionArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'InterfaceDescription',
        Command = { Get-CommandWithParameter -Module NetAdapter -ParameterName InterfaceDescription },
        Description = 'Complete interface indexes, for example: Get-NetAdapter -InterfaceDescription <TAB>')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)


    NetAdapter\Get-NetAdapter -InterfaceDescription "$wordToComplete*" |
        Sort-Object |
        ForEach-Object {
            $toolTip = "Name: $($_.Name) Index: $($_.ifIndex)"
            New-CompletionResult $_.InterfaceDescription $toolTip
        } 
}
