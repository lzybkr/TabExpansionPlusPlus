## Hyper-V module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -VMName argument to Get-VM
#
function HyperV_VMNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCn = @{}
    $cn = $fakeBoundParameter["ComputerName"]
    if($cn)
    {
        $optionalCn.ComputerName = $cn
    }

    Hyper-V\Get-VM -Name "$wordToComplete*" @optionalCn |
        Sort-Object |
        ForEach-Object {
            $toolTip = "State: $($_.State) Status: $($_.Status)"
            New-CompletionResult $_.Name $toolTip
        }
}


#
# .SYNOPSIS
#
#    Complete the -Name or -VMSwitch argument to various Hyper-V cmdlets.
#
function HyperV_VMSwitchArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCn = @{}
    $cn = $fakeBoundParameter["ComputerName"]
    if($cn)
    {
        $optionalCn.ComputerName = $cn
    }

    Hyper-V\Get-VMSwitch -Name "$wordToComplete*" @optionalCn |
        Sort-Object |
        ForEach-Object {
            $tooltip = "Description: $($_.NetAdapterInterfaceDescription)"
            New-CompletionResult $_.Name $tooltip
        }
}


#
# .SYNOPSIS
#
#    Complete the -Name argument to *-VMIntegrationService cmdlets
#
function HyperV_VMIntegrationServiceNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $vm = $fakeBoundParameter["VMName"]
    if (!$vm)
    {
        return
    }

    $optionalCn = @{}
    $cn = $fakeBoundParameter["ComputerName"]
    if($cn)
    {
        $optionalCn.ComputerName = $cn
    }

    Hyper-V\Get-VMIntegrationService -Name "$wordToComplete*" -VMName $vm @optionalCn |
        Sort-Object |
        ForEach-Object {
            # TODO - need a tooltip
            New-CompletionResult $_.Name
        }
}


#
# .SYNOPSIS
#
#    Complete vhd/vhdx files for -Path and -ParentPath parameters to *-VHD commands.
#
function HyperV_VHDPathArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-CompletionWithExtension $lastWord ('.vhd', '.vhdx')
}


#
# .SYNOPSIS
#
#     Tab-complete for -VMNetworAdapter -Name when -VMName is provided.
#
function HyperV_VMNetworkAdapterNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $vm = $fakeBoundParameter['VMName']
    if ($vm)
    {
        Hyper-V\Get-VMNetworkAdapter -VMName $vm -Name "$wordToComplete*" |
            Sort-Object -Property Name |
            ForEach-Object {
                $toolTip = "MAC: {0} Connected to: {1}" -f $_.MacAddress, $_.SwitchName
                New-CompletionResult $_.Name $toolTip
            }
    }
}


Register-ArgumentCompleter `
    -Command ( Get-CommandWithParameter -Module Hyper-V -Noun VM -ParameterName Name ) `
    -Parameter 'Name' `
    -Description 'Complete VM names, for example: Get-VM -Name <TAB>' `
    -ScriptBlock $function:HyperV_VMNameArgumentCompletion


Register-ArgumentCompleter `
    -Command ( Get-CommandWithParameter -Module Hyper-V -ParameterName VMName ) `
    -Parameter 'VMName' `
    -Description 'Complete VM names, for example: Set-VMMemory -VMName <TAB>' `
    -ScriptBlock $function:HyperV_VMNameArgumentCompletion


Register-ArgumentCompleter `
    -Command ('Get-VMSwitch', 'Remove-VMSwitch', 'Rename-VMSwitch', 'Set-VMSwitch') `
    -Parameter 'Name' `
    -Description 'Complete switch names, for example: Get-VMSwitch -Name <TAB>' `
    -ScriptBlock $function:HyperV_VMSwitchArgumentCompletion


Register-ArgumentCompleter `
    -Command ( Get-CommandWithParameter -Module Hyper-V -ParameterName SwitchName ) `
    -Parameter 'SwitchName' `
    -Description 'Complete switch names, for example: New-VM -SwitchName <TAB>' `
    -ScriptBlock $function:HyperV_VMSwitchArgumentCompletion


Register-ArgumentCompleter `
    -Command ( Get-CommandWithParameter -Module Hyper-V -Noun VMIntegrationService -ParameterName Name ) `
    -Parameter 'Name' `
    -Description 'Complete integration service names, e.g. Get-VMIntegrationService -VMName myvm -Name <TAB>' `
    -ScriptBlock $function:HyperV_VMIntegrationServiceNameArgumentCompletion


Register-ArgumentCompleter `
    -Command ( Get-CommandWithParameter -Module Hyper-V -Noun VHD -ParameterName Path |
                        Where-Object Name -ne 'New-VHD' ) `
    -Parameter 'Path' `
    -Description 'Completion VHD[X] files for various commands' `
    -ScriptBlock $function:HyperV_VHDPathArgumentCompletion


Register-ArgumentCompleter `
    -Command ( Get-CommandWithParameter -Module Hyper-V -Noun VHD -ParameterName ParentPath ) `
    -Parameter 'ParentPath' `
    -Description 'Completion VHD[X] files for various commands' `
    -ScriptBlock $function:HyperV_VHDPathArgumentCompletion


Register-ArgumentCompleter `
    -Command ( Get-CommandWithParameter -Module Hyper-V -Noun VMNetworkAdapter -ParameterName Name |
            where Verb -NE Add
        ) `
    -Parameter 'Name' `
    -Description 'Tab completes names of VM network adapaters, for example:  Get-VMNetworkAdapter -VMName Foo -Name <TAB>' `
    -ScriptBlock $function:HyperV_VMNetworkAdapterNameArgumentCompletion
