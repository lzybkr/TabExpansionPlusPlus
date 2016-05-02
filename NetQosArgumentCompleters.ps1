# ARGUMENT COMPLETER FUNCTIONS #################################################

# NETQOS POLICY NAME
function NetQoS_PolicyNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCim = @{}
    $cim = $fakeBoundParameter["CimSession"]
    if($cim)
    {
        $optionalCim.CimSession = $cim
    }

    NetQos\Get-NetQosPolicy -Name "$wordToComplete*" @optionalCim | 
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - Owner: {1} - Throttle Rate: {2:N0} bits/sec" -f $_.Name,$_.Owner,$_.ThrottleRate
            New-CompletionResult -CompletionText $_.Name -ToolTip $ToolTip
        }
}

# ARGUMENT COMPLETER REGISTRATION ##############################################

# NETQOS POLICY NAME
Register-ArgumentCompleter `
    -Command ('Get-NetQosPolicy','Set-NetQosPolicy','Remove-NetQosPolicy') `
    -Parameter 'Name' `
    -Description 'Complete NetQoS Policy names, for example: Get-NetQosPolicy -Name <TAB>' `
    -ScriptBlock $function:NetQoS_PolicyNameArgumentCompletion
