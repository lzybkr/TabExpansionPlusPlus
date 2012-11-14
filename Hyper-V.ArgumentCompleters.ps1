## Hyper-V module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -VMName argument to Get-VM
#
function HyperV_VMNameArgumentCompletion
{
    [ArgumentCompleterAttribute(
        Parameter = 'Name',
        # REVIEW - exclude New-VM?  Others?
        Command = { Get-CommandWithParameter -Module Hyper-V -Noun VM -ParameterName Name},
        Description = 'Complete VM names, for example: Get-VM -Name <TAB>')]
    [ArgumentCompleterAttribute(
        Parameter = 'VMName',
        Command = { Get-CommandWithParameter -Module Hyper-V -ParameterName VMName },
        Description = 'Complete VM names, for example: Set-VMMemory -VMName <TAB>')]
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
#    Complete the -Name or  -VMSwitch argument to various Hyper-V cmdlets.
#
function HyperV_VMSwitchArgumentCompletion
{
    [ArgumentCompleterAttribute(
        Parameter = 'Name',
        Command = ('Get-VMSwitch', 'Remove-VMSwitch', 'Rename-VMSwitch', 'Set-VMSwitch'),
        Description = 'Complete switch names, for example: Get-VMSwitch -Name <TAB>')]
    [ArgumentCompleterAttribute(
        Parameter = 'SwitchName',
        Command = { Get-CommandWithParameter -Module Hyper-V -ParameterName SwitchName  },
        Description = 'Complete switch names, for example: New-VM -SwitchName <TAB>')]
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
    [ArgumentCompleterAttribute(
        Parameter = 'Name',
        Command = { Get-Command -Module Hyper-V -Noun VMIntegrationService -ParameterName Name  },
        Description = 'Complete integration service names, e.g. Get-VMIntegrationService -VMName myvm -Name <TAB>')]
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
