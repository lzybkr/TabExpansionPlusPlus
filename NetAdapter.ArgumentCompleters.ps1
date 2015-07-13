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
    -Command ('Disable-NetAdapter','Disable-NetAdapterBinding','Disable-NetAdapterChecksumOffload','Disable-NetAdapterEncapsulatedPacketTaskOffload','Disable-NetAdapterIPsecOffload','Disable-NetAdapterLso','Disable-NetAdapterPowerManagement','Disable-NetAdapterQos','Disable-NetAdapterRdma','Disable-NetAdapterRsc','Disable-NetAdapterRss','Disable-NetAdapterSriov','Disable-NetAdapterVmq','Enable-NetAdapter','Enable-NetAdapterBinding','Enable-NetAdapterChecksumOffload','Enable-NetAdapterEncapsulatedPacketTaskOffload','Enable-NetAdapterIPsecOffload','Enable-NetAdapterLso','Enable-NetAdapterPowerManagement','Enable-NetAdapterQos','Enable-NetAdapterRdma','Enable-NetAdapterRsc','Enable-NetAdapterRss','Enable-NetAdapterSriov','Enable-NetAdapterVmq','Get-NetAdapter','Get-NetAdapterAdvancedProperty','Get-NetAdapterBinding','Get-NetAdapterChecksumOffload','Get-NetAdapterEncapsulatedPacketTaskOffload','Get-NetAdapterHardwareInfo','Get-NetAdapterIPsecOffload','Get-NetAdapterLso','Get-NetAdapterPowerManagement','Get-NetAdapterQos','Get-NetAdapterRdma','Get-NetAdapterRsc','Get-NetAdapterRss','Get-NetAdapterSriov','Get-NetAdapterSriovVf','Get-NetAdapterStatistics','Get-NetAdapterVmq','Get-NetAdapterVmqQueue','Get-NetAdapterVPort','New-NetAdapterAdvancedProperty','Remove-NetAdapterAdvancedProperty','Rename-NetAdapter','Reset-NetAdapterAdvancedProperty','Restart-NetAdapter','Set-NetAdapter','Set-NetAdapterAdvancedProperty','Set-NetAdapterBinding','Set-NetAdapterChecksumOffload','Set-NetAdapterEncapsulatedPacketTaskOffload','Set-NetAdapterIPsecOffload','Set-NetAdapterLso','Set-NetAdapterPowerManagement','Set-NetAdapterQos','Set-NetAdapterRdma','Set-NetAdapterRsc','Set-NetAdapterRss','Set-NetAdapterSriov','Set-NetAdapterVmq') `
    -Parameter 'Name' `
    -Description 'Complete Adapter names, for example: Get-NetAdapter -Name <TAB>' `
    -ScriptBlock $function:NetAdapter_AdapterNameArgumentCompletion


Register-ArgumentCompleter `
    -Command ('Get-NetAdapter') `
    -Parameter 'InterfaceIndex' `
    -Description 'Complete interface indexes, for example: Get-NetAdapter -InterfaceIndex <TAB>' `
    -ScriptBlock $function:NetAdapter_InterfaceIndexArgumentCompletion


Register-ArgumentCompleter `
    -Command ('Disable-NetAdapter','Disable-NetAdapterBinding','Disable-NetAdapterChecksumOffload','Disable-NetAdapterEncapsulatedPacketTaskOffload','Disable-NetAdapterIPsecOffload','Disable-NetAdapterLso','Disable-NetAdapterPowerManagement','Disable-NetAdapterQos','Disable-NetAdapterRdma','Disable-NetAdapterRsc','Disable-NetAdapterRss','Disable-NetAdapterSriov','Disable-NetAdapterVmq','Enable-NetAdapter','Enable-NetAdapterBinding','Enable-NetAdapterChecksumOffload','Enable-NetAdapterEncapsulatedPacketTaskOffload','Enable-NetAdapterIPsecOffload','Enable-NetAdapterLso','Enable-NetAdapterPowerManagement','Enable-NetAdapterQos','Enable-NetAdapterRdma','Enable-NetAdapterRsc','Enable-NetAdapterRss','Enable-NetAdapterSriov','Enable-NetAdapterVmq','Get-NetAdapter','Get-NetAdapterAdvancedProperty','Get-NetAdapterBinding','Get-NetAdapterChecksumOffload','Get-NetAdapterEncapsulatedPacketTaskOffload','Get-NetAdapterHardwareInfo','Get-NetAdapterIPsecOffload','Get-NetAdapterLso','Get-NetAdapterPowerManagement','Get-NetAdapterQos','Get-NetAdapterRdma','Get-NetAdapterRsc','Get-NetAdapterRss','Get-NetAdapterSriov','Get-NetAdapterSriovVf','Get-NetAdapterStatistics','Get-NetAdapterVmq','Get-NetAdapterVmqQueue','Get-NetAdapterVPort','New-NetAdapterAdvancedProperty','Remove-NetAdapterAdvancedProperty','Rename-NetAdapter','Reset-NetAdapterAdvancedProperty','Restart-NetAdapter','Set-NetAdapter','Set-NetAdapterAdvancedProperty','Set-NetAdapterBinding','Set-NetAdapterChecksumOffload','Set-NetAdapterEncapsulatedPacketTaskOffload','Set-NetAdapterIPsecOffload','Set-NetAdapterLso','Set-NetAdapterPowerManagement','Set-NetAdapterQos','Set-NetAdapterRdma','Set-NetAdapterRsc','Set-NetAdapterRss','Set-NetAdapterSriov','Set-NetAdapterVmq') `
    -Parameter 'InterfaceDescription' `
    -Description 'Complete interface indexes, for example: Get-NetAdapter -InterfaceDescription <TAB>' `
    -ScriptBlock $function:NetAdapter_InterfaceDescriptionArgumentCompletion
