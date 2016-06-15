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
    -Command ('Checkpoint-VM','Compare-VM','Debug-VM','Export-VM','Get-VM','Measure-VM','Move-VM','New-VM','Remove-VM','Rename-VM','Restart-VM','Resume-VM','Save-VM','Set-VM','Start-VM','Stop-VM','Suspend-VM') `
    -Parameter 'Name' `
    -Description 'Complete VM names, for example: Get-VM -Name <TAB>' `
    -ScriptBlock $function:HyperV_VMNameArgumentCompletion


Register-ArgumentCompleter `
    -Command ('Add-VMDvdDrive','Add-VMFibreChannelHba','Add-VMHardDiskDrive','Add-VMNetworkAdapter','Add-VMNetworkAdapterAcl','Add-VMNetworkAdapterExtendedAcl','Add-VmNetworkAdapterRoutingDomainMapping','Add-VMRemoteFx3dVideoAdapter','Add-VMScsiController','Add-VMSwitchExtensionPortFeature','Complete-VMFailover','Connect-VMNetworkAdapter','Disable-VMIntegrationService','Disable-VMResourceMetering','Disconnect-VMNetworkAdapter','Enable-VMIntegrationService','Enable-VMReplication','Enable-VMResourceMetering','Export-VMSnapshot','Get-VMBios','Get-VMComPort','Get-VMConnectAccess','Get-VMDvdDrive','Get-VMFibreChannelHba','Get-VMFirmware','Get-VMFloppyDiskDrive','Get-VMHardDiskDrive','Get-VMIdeController','Get-VMIntegrationService','Get-VMMemory','Get-VMNetworkAdapter','Get-VMNetworkAdapterAcl','Get-VMNetworkAdapterExtendedAcl','Get-VMNetworkAdapterFailoverConfiguration','Get-VmNetworkAdapterIsolation','Get-VMNetworkAdapterRoutingDomainMapping','Get-VMNetworkAdapterVlan','Get-VMProcessor','Get-VMRemoteFx3dVideoAdapter','Get-VMReplication','Get-VMScsiController','Get-VMSnapshot','Get-VMSwitchExtensionPortData','Get-VMSwitchExtensionPortFeature','Grant-VMConnectAccess','Import-VMInitialReplication','Measure-VMReplication','Move-VMStorage','Remove-VMDvdDrive','Remove-VMFibreChannelHba','Remove-VMHardDiskDrive','Remove-VMNetworkAdapter','Remove-VMNetworkAdapterAcl','Remove-VMNetworkAdapterExtendedAcl','Remove-VMNetworkAdapterRoutingDomainMapping','Remove-VMRemoteFx3dVideoAdapter','Remove-VMReplication','Remove-VMSavedState','Remove-VMScsiController','Remove-VMSnapshot','Remove-VMSwitchExtensionPortFeature','Rename-VMNetworkAdapter','Rename-VMSnapshot','Reset-VMReplicationStatistics','Reset-VMResourceMetering','Restore-VMSnapshot','Resume-VMReplication','Revoke-VMConnectAccess','Set-VMBios','Set-VMComPort','Set-VMDvdDrive','Set-VMFibreChannelHba','Set-VMFirmware','Set-VMFloppyDiskDrive','Set-VMHardDiskDrive','Set-VMMemory','Set-VMNetworkAdapter','Set-VMNetworkAdapterFailoverConfiguration','Set-VmNetworkAdapterIsolation','Set-VmNetworkAdapterRoutingDomainMapping','Set-VMNetworkAdapterVlan','Set-VMProcessor','Set-VMRemoteFx3dVideoAdapter','Set-VMReplication','Set-VMSwitchExtensionPortFeature','Start-VMFailover','Start-VMInitialReplication','Stop-VMFailover','Stop-VMInitialReplication','Stop-VMReplication','Suspend-VMReplication','Test-VMNetworkAdapter') `
    -Parameter 'VMName' `
    -Description 'Complete VM names, for example: Set-VMMemory -VMName <TAB>' `
    -ScriptBlock $function:HyperV_VMNameArgumentCompletion


Register-ArgumentCompleter `
    -Command ('Get-VMSwitch', 'Remove-VMSwitch', 'Rename-VMSwitch', 'Set-VMSwitch') `
    -Parameter 'Name' `
    -Description 'Complete switch names, for example: Get-VMSwitch -Name <TAB>' `
    -ScriptBlock $function:HyperV_VMSwitchArgumentCompletion


Register-ArgumentCompleter `
    -Command ('Add-VMNetworkAdapter','Add-VMSwitchExtensionPortFeature','Add-VMSwitchExtensionSwitchFeature','Connect-VMNetworkAdapter','Get-VMNetworkAdapter','Get-VMSwitchExtensionPortData','Get-VMSwitchExtensionPortFeature','Get-VMSwitchExtensionSwitchData','Get-VMSwitchExtensionSwitchFeature','New-VM','Remove-VMNetworkAdapter','Remove-VMSwitchExtensionPortFeature','Remove-VMSwitchExtensionSwitchFeature','Set-VMSwitchExtensionPortFeature','Set-VMSwitchExtensionSwitchFeature') `
    -Parameter 'SwitchName' `
    -Description 'Complete switch names, for example: New-VM -SwitchName <TAB>' `
    -ScriptBlock $function:HyperV_VMSwitchArgumentCompletion


Register-ArgumentCompleter `
    -Command ('Disable-VMIntegrationService','Enable-VMIntegrationService','Get-VMIntegrationService') `
    -Parameter 'Name' `
    -Description 'Complete integration service names, e.g. Get-VMIntegrationService -VMName myvm -Name <TAB>' `
    -ScriptBlock $function:HyperV_VMIntegrationServiceNameArgumentCompletion


Register-ArgumentCompleter `
    -Command ('Convert-VHD','Dismount-VHD','Get-VHD','Merge-VHD','Mount-VHD','Optimize-VHD','Resize-VHD','Set-VHD','Test-VHD') `
    -Parameter 'Path' `
    -Description 'Completion VHD[X] files for various commands' `
    -ScriptBlock $function:HyperV_VHDPathArgumentCompletion


Register-ArgumentCompleter `
    -Command ('Convert-VHD','New-VHD','Set-VHD') `
    -Parameter 'ParentPath' `
    -Description 'Completion VHD[X] files for various commands' `
    -ScriptBlock $function:HyperV_VHDPathArgumentCompletion


Register-ArgumentCompleter `
    -Command ('Connect-VMNetworkAdapter','Disconnect-VMNetworkAdapter','Get-VMNetworkAdapter','Remove-VMNetworkAdapter','Rename-VMNetworkAdapter','Set-VMNetworkAdapter','Test-VMNetworkAdapter') `
    -Parameter 'Name' `
    -Description 'Tab completes names of VM network adapaters, for example:  Get-VMNetworkAdapter -VMName Foo -Name <TAB>' `
    -ScriptBlock $function:HyperV_VMNetworkAdapterNameArgumentCompletion
