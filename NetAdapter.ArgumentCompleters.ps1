## NetAdapter module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -Name argument to commands in NetAdapter module
#
function NetAdapter_AdapterNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    NetAdapter\Get-NetAdapter -Name "$wordToComplete*" |
        Sort-Object |
        ForEach-Object {
            $toolTip = "Index: $($_.IfIndex) Description: $($_.InterfaceDescription)"
            New-CompletionResult $_.Name $toolTip
        }
}

#
# .SYNOPSIS
#
#    Complete the -InterfaceIndex argument to commands in NetAdapter module
#
function NetAdapter_InterfaceIndexArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    NetAdapter\Get-NetAdapter | where InterfaceIndex -Like "$wordToComplete*" |
        Sort-Object |
        ForEach-Object {
            $toolTip = "Name: $($_.Name) Description: $($_.InterfaceDescription)"
            New-CompletionResult $_.InterfaceIndex $toolTip
        }
}

#
# .SYNOPSIS
#
#    Complete the -InterfaceDescription argument to commands in NetAdapter module
#
function NetAdapter_InterfaceDescriptionArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    NetAdapter\Get-NetAdapter -InterfaceDescription "$wordToComplete*" |
        Sort-Object |
        ForEach-Object {
            $toolTip = "Name: $($_.Name) Index: $($_.ifIndex)"
            New-CompletionResult $_.InterfaceDescription $toolTip
        }
}


Register-ArgumentCompleter `
    -Command ( Get-CommandWithParameter -Module NetAdapter -ParameterName Name ) `
    -Parameter 'Name' `
    -Description 'Complete Adapter names, for example: Get-NetAdapter -Name <TAB>' `
    -ScriptBlock $function:NetAdapter_AdapterNameArgumentCompletion


Register-ArgumentCompleter `
    -Command ( Get-CommandWithParameter -Module NetAdapter -ParameterName InterfaceIndex ) `
    -Parameter 'InterfaceIndex' `
    -Description 'Complete interface indexes, for example: Get-NetAdapter -InterfaceIndex <TAB>' `
    -ScriptBlock $function:NetAdapter_InterfaceIndexArgumentCompletion


Register-ArgumentCompleter `
    -Command ( Get-CommandWithParameter -Module NetAdapter -ParameterName InterfaceDescription ) `
    -Parameter 'InterfaceDescription' `
    -Description 'Complete interface indexes, for example: Get-NetAdapter -InterfaceDescription <TAB>' `
    -ScriptBlock $function:NetAdapter_InterfaceDescriptionArgumentCompletion
