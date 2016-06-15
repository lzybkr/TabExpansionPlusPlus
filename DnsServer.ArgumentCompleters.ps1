# ARGUMENT COMPLETER FUNCTIONS #################################################

# DNS ZONE NAME
function DNSServer_ZoneNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalParams = @{}
    $CN = $fakeBoundParameter["ComputerName"]
    $CIMSession = $fakeBoundParameter["CimSession"]
    if($CN) { $optionalParams.ComputerName = $CN }
    if($CIMSession) { $optionalParams.CimSession = $CIMSession }

    DnsServer\Get-DnsServerZone @optionalParams |
        Where-Object {$_.ZoneName -like "$wordToComplete*"} |
        Sort-Object -Property ZoneName |
        ForEach-Object {
            $ToolTip = "ZoneType: {0} `nIsDSIntegrated: {1} - Dynamic Updates: {2} `nIsReverseLookupZone: {3} - IsAutoCreated: {4}" -f $_.ZoneType,$_.IsDsIntegrated,$_.DynamicUpdate,$_.IsReverseLookupZone,$_.IsAutoCreated
            New-CompletionResult -CompletionText $_.ZoneName -ToolTip $ToolTip
        }
}

# DNS ZONE FILE
function DNSServer_ZoneFileArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-CompletionWithExtension -lastWord $lastWord -extensions ('.dns')
}

# DNS RESOURCE RECORD
function DNSServer_ResourceRecordNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalParams = @{}
    $CN         = $fakeBoundParameter["ComputerName"]
    $CIMSession = $fakeBoundParameter["CimSession"]
    $ZoneName   = $fakeBoundParameter["ZoneName"]
    $RRType     = $fakeBoundParameter["RRType"]

    if($CN)         { $optionalParams.ComputerName = $CN }
    if($CIMSession) { $optionalParams.CimSession   = $CIMSession }
    if($ZoneName)   { $optionalParams.ZoneName     = $ZoneName }
    if($RRType)     { $optionalParams.RRType       = $RRType }
    # These completions are slow 
    DnsServer\Get-DnsServerResourceRecord @optionalParams |
        Where-Object {$_.HostName -like "$wordToComplete*"} |
        Sort-Object -Property HostName |
        ForEach-Object {
            $ToolTip = "Data: {0} - Type: {1} `nTimeStamp: {2} - TTL: {3}" -f $_.RecordData.IPv4Address,$_.RecordType,$_.TimeStamp,$_.TimeToLive
            New-CompletionResult -CompletionText $_.HostName -ToolTip $ToolTip
        }
}

# DNS DIRECTORY PARTITION NAME
function DNSServer_DirectoryPartitionNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalParams = @{}
    $CN         = $fakeBoundParameter["ComputerName"]
    $CIMSession = $fakeBoundParameter["CimSession"]

    if($CN)         { $optionalParams.ComputerName = $CN }
    if($CIMSession) { $optionalParams.CimSession   = $CIMSession }

    DnsServer\Get-DnsServerDirectoryPartition @optionalParams |
        Where-Object {$_.DirectoryPartitionName -like "$wordToComplete*"} |
        Sort-Object -Property DirectoryPartitionName |
        ForEach-Object {
            $ToolTip = "State: {0} - Flags: {1} - ZoneCount: {2}" -f $_.State,$_.Flags,$_.ZoneCount
            New-CompletionResult -CompletionText $_.DirectoryPartitionName -ToolTip $ToolTip
        }
}

# ARGUMENT COMPLETER REGISTRATION ##############################################

# DNS ZONE NAME
Register-ArgumentCompleter `
    -Command ('Add-DnsServerConditionalForwarderZone','Add-DnsServerPrimaryZone','Add-DnsServerResourceRecord','Add-DnsServerResourceRecordA','Add-DnsServerResourceRecordAAAA','Add-DnsServerResourceRecordCName','Add-DnsServerResourceRecordDnsKey','Add-DnsServerResourceRecordDS','Add-DnsServerResourceRecordMX','Add-DnsServerResourceRecordPtr','Add-DnsServerSecondaryZone','Add-DnsServerSigningKey','Add-DnsServerStubZone','Add-DnsServerZoneDelegation','Clear-DnsServerStatistics','ConvertTo-DnsServerPrimaryZone','ConvertTo-DnsServerSecondaryZone','Disable-DnsServerSigningKeyRollover','Enable-DnsServerSigningKeyRollover','Export-DnsServerDnsSecPublicKey','Export-DnsServerZone','Get-DnsServerDnsSecZoneSetting','Get-DnsServerResourceRecord','Get-DnsServerSigningKey','Get-DnsServerStatistics','Get-DnsServerZone','Get-DnsServerZoneAging','Get-DnsServerZoneDelegation','Import-DnsServerResourceRecordDS','Invoke-DnsServerSigningKeyRollover','Invoke-DnsServerZoneSign','Invoke-DnsServerZoneUnsign','Remove-DnsServerResourceRecord','Remove-DnsServerSigningKey','Remove-DnsServerZone','Remove-DnsServerZoneDelegation','Reset-DnsServerZoneKeyMasterRole','Restore-DnsServerPrimaryZone','Restore-DnsServerSecondaryZone','Resume-DnsServerZone','Set-DnsServerConditionalForwarderZone','Set-DnsServerDnsSecZoneSetting','Set-DnsServerPrimaryZone','Set-DnsServerResourceRecord','Set-DnsServerResourceRecordAging','Set-DnsServerSecondaryZone','Set-DnsServerSigningKey','Set-DnsServerStubZone','Set-DnsServerZoneAging','Set-DnsServerZoneDelegation','Start-DnsServerZoneTransfer','Step-DnsServerSigningKeyRollover','Suspend-DnsServerZone','Sync-DnsServerZone','Test-DnsServer','Test-DnsServerDnsSecZoneSetting') `
    -Parameter 'ZoneName' `
    -Description 'Complete DNS Zone names, for example: Get-DnsServerZone -Name <TAB>' `
    -ScriptBlock $function:DNSServer_ZoneNameArgumentCompletion

# DNS ZONE FILE
Register-ArgumentCompleter `
    -Command ('Add-DnsServerPrimaryZone','Add-DnsServerSecondaryZone','Add-DnsServerStubZone','ConvertTo-DnsServerPrimaryZone','ConvertTo-DnsServerSecondaryZone','Set-DnsServerPrimaryZone','Set-DnsServerSecondaryZone') `
    -Parameter 'ZoneFile' `
    -Description 'Complete DNS Zone names, for example: Get-DnsServerZone -Name <TAB>' `
    -ScriptBlock $function:DNSServer_ZoneFileArgumentCompletion

# DNS RESOURCE RECORD
Register-ArgumentCompleter `
    -Command ('Get-DnsServerResourceRecord') `
    -Parameter 'Name' `
    -Description 'Complete DNS Resource Record names, for example: Get-DnsServerResourceRecord -ZoneName <ZoneName> -Name <TAB>' `
    -ScriptBlock $function:DNSServer_ResourceRecordNameArgumentCompletion

# DNS DIRECTORY PARTITION NAME
Register-ArgumentCompleter `
    -Command ('Add-DnsServerConditionalForwarderZone','Add-DnsServerDirectoryPartition','Add-DnsServerPrimaryZone','Add-DnsServerStubZone','ConvertTo-DnsServerPrimaryZone','Get-DnsServerDirectoryPartition','Register-DnsServerDirectoryPartition','Remove-DnsServerDirectoryPartition','Set-DnsServerConditionalForwarderZone','Set-DnsServerPrimaryZone','Set-DnsServerStubZone','Unregister-DnsServerDirectoryPartition') `
    -Parameter 'DirectoryPartitionName' `
    -Description 'Complete DNS Directory Partition names, for example: Add-DnsServerPrimaryZone -DirectoryPartitionName <TAB>' `
    -ScriptBlock $function:DNSServer_DirectoryPartitionNameArgumentCompletion

Register-ArgumentCompleter `
    -Command ('Get-DnsServerDirectoryPartition') `
    -Parameter 'Name' `
    -Description 'Complete DNS Directory Partition names, for example: Get-DnsServerDirectoryPartition -Name <TAB>' `
    -ScriptBlock $function:DNSServer_DirectoryPartitionNameArgumentCompletion
