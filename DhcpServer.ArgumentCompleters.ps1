# ARGUMENT COMPLETER FUNCTIONS #################################################

# DHCPSERVER
function DhcpServer_ComputerNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    DhcpServer\Get-DhcpServerInDC |
        Where-Object {$_.DnsName -like "$wordToComplete*"} |
        Sort-Object -Property DnsName |
        ForEach-Object {
            $ToolTip = "IP: {0}" -f $_.IPAddress
            New-CompletionResult -CompletionText $_.DnsName -ToolTip $ToolTip
        }
}
# DHCPSERVER v4 SCOPEID
function DhcpServer_v4ScopeIdArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalParams = @{}
    $ComputerName = $fakeBoundParameter["ComputerName"]
    $CIMSession   = $fakeBoundParameter["CimSession"]

    if($ComputerName) { $optionalParams.ComputerName = $ComputerName }
    if($CIMSession)   { $optionalParams.CimSession   = $CIMSession }
 
    $CacheKey = if($ComputerName)   { "DHCPServer_v4Scope_$ComputerName" } 
                elseif($CIMSession) { "DHCPServer_v4Scope_$CimSession" }
                else { "DHCPServer_v4Scope" }
    $Cache = Get-CompletionPrivateData -Key $CacheKey
    if ($Cache) { return $Cache }

    # These completions are slow 
    $ArgumentList = DhcpServer\Get-DhcpServerv4Scope @optionalParams |
        Where-Object {$_.Name -like "$wordToComplete*"} |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - State: {1} - ScopeId: {2} `nLease Duration: {3}" -f $_.Name,$_.State,$_.ScopeId,$_.LeaseDuration
            New-CompletionResult -CompletionText $_.ScopeId -ToolTip $ToolTip -ListItemText $_.Name
        }

    Set-CompletionPrivateData -Key $CacheKey -Value $ArgumentList -ExpirationSeconds 900 # Expiration: 15 min
    return $ArgumentList
}
# DHCPSERVER v6 SCOPEID - N/A

# DHCPSERVER v4 POLICY NAME
function DhcpServer_v4PolicyNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalParams = @{}
    $ComputerName = $fakeBoundParameter["ComputerName"]
    $CIMSession   = $fakeBoundParameter["CimSession"]

    if($ComputerName) { $optionalParams.ComputerName = $ComputerName }
    if($CIMSession)   { $optionalParams.CimSession   = $CIMSession }

    DhcpServer\Get-DhcpServerv4Policy @optionalParams |
        Where-Object {$_.Name -like "$wordToComplete*"} |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Scope Id: {0} - Description {1} - Enabled: {2}" -f $_.ScopeID,$_.Description,$_.Enabled
            New-CompletionResult -CompletionText $_.Name -ToolTip $ToolTip
        }
}
# DHCPSERVER v6 POLICY NAME - N/A

# DHCPSERVER v4 CLASSNAME
function DhcpServer_v4ClassNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalParams = @{}
    $CN         = $fakeBoundParameter["ComputerName"]
    $CIMSession = $fakeBoundParameter["CimSession"]

    if($CN)         { $optionalParams.ComputerName = $CN }
    if($CIMSession) { $optionalParams.CimSession   = $CIMSession }

    DhcpServer\Get-DhcpServerv4Class @optionalParams |
        Where-Object {$_.Name -like "$wordToComplete*"} |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - Class Type: {1} `nDescription: {2}" -f $_.Name,$_.Type,$_.Description
            $ListItemText = "{0} [Class: {1}]" -f $_.Name,$_.Type
            New-CompletionResult -CompletionText $_.Name -ToolTip $ToolTip -ListItemText $ListItemText
        }
}
# DHCPSERVER v6 CLASSNAME
function DhcpServer_v6ClassNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalParams = @{}
    $CN         = $fakeBoundParameter["ComputerName"]
    $CIMSession = $fakeBoundParameter["CimSession"]

    if($CN)         { $optionalParams.ComputerName = $CN }
    if($CIMSession) { $optionalParams.CimSession   = $CIMSession }

    DhcpServer\Get-DhcpServerv6Class @optionalParams |
        Where-Object {$_.Name -like "$wordToComplete*"} |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - Class Type: {1} `nDescription: {2}" -f $_.Name,$_.Type,$_.Description
            $ListItemText = "{0} [Class: {1}]" -f $_.Name,$_.Type
            New-CompletionResult -CompletionText $_.Name -ToolTip $ToolTip -ListItemText $ListItemText
        }
}
# DHCPSERVER v4 OPTIONID
function DhcpServer_v4OptionIdArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalParams = @{}
    $CN         = $fakeBoundParameter["ComputerName"]
    $CIMSession = $fakeBoundParameter["CimSession"]

    if($CN)         { $optionalParams.ComputerName = $CN }
    if($CIMSession) { $optionalParams.CimSession   = $CIMSession }

    DhcpServer\Get-DhcpServerv4OptionDefinition @optionalParams |
        Where-Object {$_.Name -like "$wordToComplete*"} |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - OptionId: {1} - Type: {2}" -f $_.Name,$_.OptionId,$_.Type
            $ListItemText = "{0} [{1}]" -f $_.Name,$_.OptionId
            New-CompletionResult -CompletionText $_.OptionId -ToolTip $ToolTip -ListItemText $ListItemText
        }
}
# DHCPSERVER v6 OPTIONID
function DhcpServer_v6OptionIdArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalParams = @{}
    $CN         = $fakeBoundParameter["ComputerName"]
    $CIMSession = $fakeBoundParameter["CimSession"]

    if($CN)         { $optionalParams.ComputerName = $CN }
    if($CIMSession) { $optionalParams.CimSession   = $CIMSession }

    DhcpServer\Get-DhcpServerv6OptionDefinition @optionalParams |
        Where-Object {$_.Name -like "$wordToComplete*"} |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - OptionId: {1} - Type: {2}" -f $_.Name,$_.OptionId,$_.Type
            $ListItemText = "{0} [{1}]" -f $_.Name,$_.OptionId
            New-CompletionResult -CompletionText $_.OptionId -ToolTip $ToolTip -ListItemText $ListItemText
        }
}

# ARGUMENT COMPLETER REGISTRATION ##############################################

# COMPUTERNAME
Register-ArgumentCompleter `
    -Command ('Reconcile-DhcpServerv4IPRecord','Add-DhcpServerSecurityGroup','Add-DhcpServerv4Class','Add-DhcpServerv4ExclusionRange','Add-DhcpServerv4Failover','Add-DhcpServerv4FailoverScope','Add-DhcpServerv4Filter','Add-DhcpServerv4Lease','Add-DhcpServerv4MulticastExclusionRange','Add-DhcpServerv4MulticastScope','Add-DhcpServerv4OptionDefinition','Add-DhcpServerv4Policy','Add-DhcpServerv4PolicyIPRange','Add-DhcpServerv4Reservation','Add-DhcpServerv4Scope','Add-DhcpServerv4Superscope','Add-DhcpServerv6Class','Add-DhcpServerv6ExclusionRange','Add-DhcpServerv6Lease','Add-DhcpServerv6OptionDefinition','Add-DhcpServerv6Reservation','Add-DhcpServerv6Scope','Backup-DhcpServer','Export-DhcpServer','Get-DhcpServerAuditLog','Get-DhcpServerDatabase','Get-DhcpServerDnsCredential','Get-DhcpServerSetting','Get-DhcpServerv4Binding','Get-DhcpServerv4Class','Get-DhcpServerv4DnsSetting','Get-DhcpServerv4ExclusionRange','Get-DhcpServerv4Failover','Get-DhcpServerv4Filter','Get-DhcpServerv4FilterList','Get-DhcpServerv4FreeIPAddress','Get-DhcpServerv4Lease','Get-DhcpServerv4MulticastExclusionRange','Get-DhcpServerv4MulticastLease','Get-DhcpServerv4MulticastScope','Get-DhcpServerv4MulticastScopeStatistics','Get-DhcpServerv4OptionDefinition','Get-DhcpServerv4OptionValue','Get-DhcpServerv4Policy','Get-DhcpServerv4PolicyIPRange','Get-DhcpServerv4Reservation','Get-DhcpServerv4Scope','Get-DhcpServerv4ScopeStatistics','Get-DhcpServerv4Statistics','Get-DhcpServerv4Superscope','Get-DhcpServerv4SuperscopeStatistics','Get-DhcpServerv6Binding','Get-DhcpServerv6Class','Get-DhcpServerv6DnsSetting','Get-DhcpServerv6ExclusionRange','Get-DhcpServerv6FreeIPAddress','Get-DhcpServerv6Lease','Get-DhcpServerv6OptionDefinition','Get-DhcpServerv6OptionValue','Get-DhcpServerv6Reservation','Get-DhcpServerv6Scope','Get-DhcpServerv6ScopeStatistics','Get-DhcpServerv6StatelessStatistics','Get-DhcpServerv6StatelessStore','Get-DhcpServerv6Statistics','Get-DhcpServerVersion','Import-DhcpServer','Invoke-DhcpServerv4FailoverReplication','Remove-DhcpServerDnsCredential','Remove-DhcpServerv4Class','Remove-DhcpServerv4ExclusionRange','Remove-DhcpServerv4Failover','Remove-DhcpServerv4FailoverScope','Remove-DhcpServerv4Filter','Remove-DhcpServerv4Lease','Remove-DhcpServerv4MulticastExclusionRange','Remove-DhcpServerv4MulticastLease','Remove-DhcpServerv4MulticastScope','Remove-DhcpServerv4OptionDefinition','Remove-DhcpServerv4OptionValue','Remove-DhcpServerv4Policy','Remove-DhcpServerv4PolicyIPRange','Remove-DhcpServerv4Reservation','Remove-DhcpServerv4Scope','Remove-DhcpServerv4Superscope','Remove-DhcpServerv6Class','Remove-DhcpServerv6ExclusionRange','Remove-DhcpServerv6Lease','Remove-DhcpServerv6OptionDefinition','Remove-DhcpServerv6OptionValue','Remove-DhcpServerv6Reservation','Remove-DhcpServerv6Scope','Rename-DhcpServerv4Superscope','Repair-DhcpServerv4IPRecord','Restore-DhcpServer','Set-DhcpServerAuditLog','Set-DhcpServerDatabase','Set-DhcpServerDnsCredential','Set-DhcpServerSetting','Set-DhcpServerv4Binding','Set-DhcpServerv4Class','Set-DhcpServerv4DnsSetting','Set-DhcpServerv4Failover','Set-DhcpServerv4FilterList','Set-DhcpServerv4MulticastScope','Set-DhcpServerv4OptionDefinition','Set-DhcpServerv4OptionValue','Set-DhcpServerv4Policy','Set-DhcpServerv4Reservation','Set-DhcpServerv4Scope','Set-DhcpServerv6Binding','Set-DhcpServerv6Class','Set-DhcpServerv6DnsSetting','Set-DhcpServerv6OptionDefinition','Set-DhcpServerv6OptionValue','Set-DhcpServerv6Reservation','Set-DhcpServerv6Scope','Set-DhcpServerv6StatelessStore') `
    -Parameter 'ComputerName' `
    -Description 'Complete DHCP Server ComputerName, for example: Get-DhcpServerV4Scope -ComputerName <TAB>' `
    -ScriptBlock $function:DhcpServer_ComputerNameArgumentCompletion

# CIMSESSION
Register-ArgumentCompleter `
    -Command ('Reconcile-DhcpServerv4IPRecord','Add-DhcpServerInDC','Add-DhcpServerSecurityGroup','Add-DhcpServerv4Class','Add-DhcpServerv4ExclusionRange','Add-DhcpServerv4Failover','Add-DhcpServerv4FailoverScope','Add-DhcpServerv4Filter','Add-DhcpServerv4Lease','Add-DhcpServerv4MulticastExclusionRange','Add-DhcpServerv4MulticastScope','Add-DhcpServerv4OptionDefinition','Add-DhcpServerv4Policy','Add-DhcpServerv4PolicyIPRange','Add-DhcpServerv4Reservation','Add-DhcpServerv4Scope','Add-DhcpServerv4Superscope','Add-DhcpServerv6Class','Add-DhcpServerv6ExclusionRange','Add-DhcpServerv6Lease','Add-DhcpServerv6OptionDefinition','Add-DhcpServerv6Reservation','Add-DhcpServerv6Scope','Backup-DhcpServer','Export-DhcpServer','Get-DhcpServerAuditLog','Get-DhcpServerDatabase','Get-DhcpServerDnsCredential','Get-DhcpServerInDC','Get-DhcpServerSetting','Get-DhcpServerv4Binding','Get-DhcpServerv4Class','Get-DhcpServerv4DnsSetting','Get-DhcpServerv4ExclusionRange','Get-DhcpServerv4Failover','Get-DhcpServerv4Filter','Get-DhcpServerv4FilterList','Get-DhcpServerv4FreeIPAddress','Get-DhcpServerv4Lease','Get-DhcpServerv4MulticastExclusionRange','Get-DhcpServerv4MulticastLease','Get-DhcpServerv4MulticastScope','Get-DhcpServerv4MulticastScopeStatistics','Get-DhcpServerv4OptionDefinition','Get-DhcpServerv4OptionValue','Get-DhcpServerv4Policy','Get-DhcpServerv4PolicyIPRange','Get-DhcpServerv4Reservation','Get-DhcpServerv4Scope','Get-DhcpServerv4ScopeStatistics','Get-DhcpServerv4Statistics','Get-DhcpServerv4Superscope','Get-DhcpServerv4SuperscopeStatistics','Get-DhcpServerv6Binding','Get-DhcpServerv6Class','Get-DhcpServerv6DnsSetting','Get-DhcpServerv6ExclusionRange','Get-DhcpServerv6FreeIPAddress','Get-DhcpServerv6Lease','Get-DhcpServerv6OptionDefinition','Get-DhcpServerv6OptionValue','Get-DhcpServerv6Reservation','Get-DhcpServerv6Scope','Get-DhcpServerv6ScopeStatistics','Get-DhcpServerv6StatelessStatistics','Get-DhcpServerv6StatelessStore','Get-DhcpServerv6Statistics','Get-DhcpServerVersion','Import-DhcpServer','Invoke-DhcpServerv4FailoverReplication','Remove-DhcpServerDnsCredential','Remove-DhcpServerInDC','Remove-DhcpServerv4Class','Remove-DhcpServerv4ExclusionRange','Remove-DhcpServerv4Failover','Remove-DhcpServerv4FailoverScope','Remove-DhcpServerv4Filter','Remove-DhcpServerv4Lease','Remove-DhcpServerv4MulticastExclusionRange','Remove-DhcpServerv4MulticastLease','Remove-DhcpServerv4MulticastScope','Remove-DhcpServerv4OptionDefinition','Remove-DhcpServerv4OptionValue','Remove-DhcpServerv4Policy','Remove-DhcpServerv4PolicyIPRange','Remove-DhcpServerv4Reservation','Remove-DhcpServerv4Scope','Remove-DhcpServerv4Superscope','Remove-DhcpServerv6Class','Remove-DhcpServerv6ExclusionRange','Remove-DhcpServerv6Lease','Remove-DhcpServerv6OptionDefinition','Remove-DhcpServerv6OptionValue','Remove-DhcpServerv6Reservation','Remove-DhcpServerv6Scope','Rename-DhcpServerv4Superscope','Repair-DhcpServerv4IPRecord','Restore-DhcpServer','Set-DhcpServerAuditLog','Set-DhcpServerDatabase','Set-DhcpServerDnsCredential','Set-DhcpServerSetting','Set-DhcpServerv4Binding','Set-DhcpServerv4Class','Set-DhcpServerv4DnsSetting','Set-DhcpServerv4Failover','Set-DhcpServerv4FilterList','Set-DhcpServerv4MulticastScope','Set-DhcpServerv4OptionDefinition','Set-DhcpServerv4OptionValue','Set-DhcpServerv4Policy','Set-DhcpServerv4Reservation','Set-DhcpServerv4Scope','Set-DhcpServerv6Binding','Set-DhcpServerv6Class','Set-DhcpServerv6DnsSetting','Set-DhcpServerv6OptionDefinition','Set-DhcpServerv6OptionValue','Set-DhcpServerv6Reservation','Set-DhcpServerv6Scope','Set-DhcpServerv6StatelessStore') `
    -Parameter 'CimSession' `
    -Description 'Complete DHCP Server CimSession Name, for example: Get-DhcpServerV4Scope -CimSession <TAB>' `
    -ScriptBlock $function:DhcpServer_ComputerNameArgumentCompletion

# DHCPSERVER V4 SCOPEID
Register-ArgumentCompleter `
    -Command ('Get-DhcpServerv4DnsSetting','Get-DhcpServerv4ExclusionRange','Get-DhcpServerv4Failover','Get-DhcpServerv4FreeIPAddress','Get-DhcpServerv4Lease','Get-DhcpServerv4OptionValue','Get-DhcpServerv4Policy','Get-DhcpServerv4PolicyIPRange','Get-DhcpServerv4Reservation','Get-DhcpServerv4Scope','Get-DhcpServerv4ScopeStatistics') `
    -Parameter 'ScopeId' `
    -Description 'Complete DHCP Server v4 Scope names, for example: Get-DhcpServerV4Scope -ScopeId <TAB>' `
    -ScriptBlock $function:DhcpServer_v4ScopeIdArgumentCompletion

# DHCPSERVER V4 POLICY
Register-ArgumentCompleter `
    -Command ('Add-DhcpServerv4PolicyIPRange','Get-DhcpServerv4Policy','Get-DhcpServerv4PolicyIPRange','Remove-DhcpServerv4Policy','Remove-DhcpServerv4PolicyIPRange','Set-DhcpServerv4Policy') `
    -Parameter 'Name' `
    -Description 'Complete DHCP Server Policy names, for example: Get-DhcpServerV4Policy -Name <TAB>' `
    -ScriptBlock $function:DhcpServer_v4PolicyNameArgumentCompletion

# DHCPSERVER V4 CLASS
Register-ArgumentCompleter `
    -Command ('Get-DhcpServerv4Class') `
    -Parameter 'Name' `
    -Description 'Complete DHCP Server Class names, for example: Get-DhcpServerV4Class -Name <TAB>' `
    -ScriptBlock $function:DhcpServer_v4ClassNameArgumentCompletion

# DHCPSERVER V6 CLASS
Register-ArgumentCompleter `
    -Command ('Get-DhcpServerv6Class') `
    -Parameter 'Name' `
    -Description 'Complete DHCP Server Class names, for example: Get-DhcpServerV6Class -Name <TAB>' `
    -ScriptBlock $function:DhcpServer_v6ClassNameArgumentCompletion

# DHCPSERVER V4 VENDORCLASS
Register-ArgumentCompleter `
    -Command ('Add-DhcpServerv4OptionDefinition','Add-DhcpServerv4Policy','Get-DhcpServerv4OptionDefinition','Get-DhcpServerv4OptionValue','Remove-DhcpServerv4OptionDefinition','Remove-DhcpServerv4OptionValue','Set-DhcpServerv4OptionDefinition','Set-DhcpServerv4OptionValue','Set-DhcpServerv4Policy') `
    -Parameter 'VendorClass' `
    -Description 'Complete DHCP Server v4 Vendor Class names, for example: Get-DhcpServerV6Policy -VendorClass <TAB>' `
    -ScriptBlock $function:DhcpServer_v4ClassNameArgumentCompletion

# DHCPSERVER V6 VENDORCLASS
Register-ArgumentCompleter `
    -Command ('Add-DhcpServerv6OptionDefinition','Get-DhcpServerv6OptionDefinition','Get-DhcpServerv6OptionValue','Remove-DhcpServerv6OptionDefinition','Remove-DhcpServerv6OptionValue','Set-DhcpServerv6OptionDefinition','Set-DhcpServerv6OptionValue') `
    -Parameter 'VendorClass' `
    -Description 'Complete DHCP Server v6 Vendor Class names, for example: Set-DhcpServerV6Policy -VendorClass <TAB>' `
    -ScriptBlock $function:DhcpServer_v6ClassNameArgumentCompletion

# DHCPSERVER V4 USERCLASS
Register-ArgumentCompleter `
    -Command ('Add-DhcpServerv4Policy','Get-DhcpServerv4OptionValue','Remove-DhcpServerv4OptionValue','Set-DhcpServerv4OptionValue','Set-DhcpServerv4Policy') `
    -Parameter 'UserClass' `
    -Description 'Complete DHCP Server v4 User Class names, for example: Get-DhcpServerV4Policy -UserClass <TAB>' `
    -ScriptBlock $function:DhcpServer_v4ClassNameArgumentCompletion

# DHCPSERVER V6 USERCLASS
Register-ArgumentCompleter `
    -Command ('Get-DhcpServerv6OptionValue','Remove-DhcpServerv6OptionValue','Set-DhcpServerv6OptionValue') `
    -Parameter 'UserClass' `
    -Description 'Complete DHCP Server v6 User Class names, for example: Get-DhcpServerV6Policy -UserClass <TAB>' `
    -ScriptBlock $function:DhcpServer_v6ClassNameArgumentCompletion

# DHCPSERVER v4 OPTIONID
Register-ArgumentCompleter `
    -Command ('Add-DhcpServerv4OptionDefinition','Get-DhcpServerv4OptionDefinition','Get-DhcpServerv4OptionValue','Remove-DhcpServerv4OptionDefinition','Remove-DhcpServerv4OptionValue','Set-DhcpServerv4OptionDefinition','Set-DhcpServerv4OptionValue') `
    -Parameter 'OptionId' `
    -Description 'Complete DHCP Server v4 Option ID names, for example: Get-DhcpServerV4OptionDefinition -OptionId <TAB>' `
    -ScriptBlock $function:DhcpServer_v4OptionIdArgumentCompletion

# DHCPSERVER v6 OPTIONID
Register-ArgumentCompleter `
    -Command ('Add-DhcpServerv6OptionDefinition','Get-DhcpServerv6OptionDefinition','Get-DhcpServerv6OptionValue','Remove-DhcpServerv6OptionDefinition','Remove-DhcpServerv6OptionValue','Set-DhcpServerv6OptionDefinition','Set-DhcpServerv6OptionValue') `
    -Parameter 'OptionId' `
    -Description 'Complete DHCP Server v6 Option ID names, for example: Get-DhcpServerV6OptionDefinition -OptionId <TAB>' `
    -ScriptBlock $function:DhcpServer_v6OptionIdArgumentCompletion
