# Argument completer by Kurt Roggen [BE] - kurtroggen.be - @roggenk
# Microsoft.PowerShell.LocalAccounts module (Windows 10/Windows Server 2016)
# Supports cmdlets
# - *-LocalUser cmdlets (Parameters -SID)
# - *-LocalGroup cmdlets (Parameters -Name, -SID, -Group)
# - *-LocalGroupMember cmdlets (Parameters -Member)

# ARGUMENT COMPLETER FUNCTIONS #################################################

# LOCALUSER ###############
# LOCALUSER -Name
function LocalAccounts_LocalUserNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Microsoft.PowerShell.LocalAccounts\Get-LocalUser -Name "$wordToComplete*" |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - SID: {1} `nEnabled: {2}" -f $_.Name,$_.Sid ,$_.Enabled
            New-CompletionResult -CompletionText $_.Name -ToolTip $ToolTip
        }
}

# LOCALUSER -SID
function LocalAccounts_LocalUserSIDArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Microsoft.PowerShell.LocalAccounts\Get-LocalUser -Name "$wordToComplete*" |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - SID: {1} `nEnabled: {2}" -f $_.Name,$_.Sid ,$_.Enabled
            New-CompletionResult -CompletionText $_.SID -ToolTip $ToolTip -ListItemText $_.Name
        }
}

# LOCALGROUP ###############
# LOCALGROUP -NAME
function LocalAccounts_LocalGroupNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Microsoft.PowerShell.LocalAccounts\Get-LocalGroup -Name "$wordToComplete*" |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - SID: {1}" -f $_.Name,$_.Sid 
            New-CompletionResult -CompletionText $_.Name -ToolTip $ToolTip
        }
}

# LOCALGROUP -SID
function LocalAccounts_LocalGroupSIDArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Microsoft.PowerShell.LocalAccounts\Get-LocalGroup -Name "$wordToComplete*" |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - SID: {1}" -f $_.Name,$_.Sid 
            New-CompletionResult -CompletionText $_.SID -ToolTip $ToolTip -ListItemText $_.Name
        }
}

# LOCALGROUP -GROUP
function LocalAccounts_LocalGroupGroupArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Microsoft.PowerShell.LocalAccounts\Get-LocalGroup -Name "$wordToComplete*" |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - SID: {1}" -f $_.Name,$_.Sid
            $CompletionText = "(Get-LocalGroup -Name '{0}')" -f $_.Name 
            New-CompletionResult -CompletionText $CompletionText -ToolTip $ToolTip -ListItemText $_.Name -NoQuotes
        }
}

# LOCALGROUPMEMBER -MEMBER
function LocalAccounts_LocalGroupMemberMemberArgumentCompletion    
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $GroupParams = @{}
    $LocalGroupName = $fakeBoundParameter["Name"]
    $LocalGroup     = $fakeBoundParameter["Group"]
    if($LocalGroupName) { $GroupParams.Name  = $LocalGroupName }
    if($LocalGroup)     { $GroupParams.Group = $LocalGroup }

    Microsoft.PowerShell.LocalAccounts\Get-LocalGroupMember @GroupParams |
        Where-Object {$_.Name -like "$wordToComplete*" } |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - SID: {1} `nType: {2} - Source: {3}" -f $_.Name,$_.Sid,$_.ObjectClass,$_.PrincipalSource
            New-CompletionResult -CompletionText $_.Name -ToolTip $ToolTip
        }
}

# ARGUMENT COMPLETER REGISTRATION ##############################################

# LOCALUSER ###############
# LOCALUSER -NAME
Register-ArgumentCompleter `
    -Command ('Disable-LocalUser','Enable-LocalUser','Get-LocalUser','Remove-LocalUser','Rename-LocalUser','Set-LocalUser') `
    -Parameter 'Name' `
    -Description 'Complete local user names, for example: Get-LocalUser -Name <TAB>' `
    -ScriptBlock $function:LocalAccounts_LocalUserNameArgumentCompletion
# LOCALUSER -SID
Register-ArgumentCompleter `
    -Command ('Disable-LocalUser','Enable-LocalUser','Get-LocalUser','Remove-LocalUser','Rename-LocalUser','Set-LocalUser') `
    -Parameter 'SID' `
    -Description 'Complete local user names, for example: Get-LocalUser -Name <TAB>' `
    -ScriptBlock $function:LocalAccounts_LocalUserSIDArgumentCompletion

# LOCALGROUP ###############
# LOCALGROUP -NAME
Register-ArgumentCompleter `
    -Command ('Get-LocalGroup','Remove-LocalGroup','Rename-LocalGroup','Set-LocalGroup') `
    -Parameter 'Name' `
    -Description 'Complete local group names, for example: Get-LocalGroup -Name <TAB>' `
    -ScriptBlock $function:LocalAccounts_LocalGroupNameArgumentCompletion
# LOCALGROUP -SID
Register-ArgumentCompleter `
    -Command ('Get-LocalGroup','Remove-LocalGroup','Rename-LocalGroup','Set-LocalGroup') `
    -Parameter 'SID' `
    -Description 'Complete local group names, for example: Get-LocalGroup -SID <TAB>' `
    -ScriptBlock $function:LocalAccounts_LocalGroupSIDArgumentCompletion

# LOCALGROUPMEMBER ###############
# LOCALGROUPMEMBER -NAME
Register-ArgumentCompleter `
    -Command ('Add-LocalGroupMember','Get-LocalGroupMember','Remove-LocalGroupMember') `
    -Parameter 'Name' `
    -Description 'Complete local group names, for example: Get-LocalGroupMember -Name <TAB>' `
    -ScriptBlock $function:LocalAccounts_LocalGroupNameArgumentCompletion
# LOCALGROUPMEMBER -SID
Register-ArgumentCompleter `
    -Command ('Add-LocalGroupMember','Get-LocalGroupMember','Remove-LocalGroupMember') `
    -Parameter 'SID' `
    -Description 'Complete local group names, for example: Get-LocalGroupMember -SID <TAB>' `
    -ScriptBlock $function:LocalAccounts_LocalGroupSIDArgumentCompletion
# LOCALGROUPMEMBER -MEMBER
Register-ArgumentCompleter `
    -Command ('Get-LocalGroupMember','Remove-LocalGroupMember') `
    -Parameter 'Member' `
    -Description 'Complete local group names, for example: Get-LocalGroupMember -Name <TAB>' `
    -ScriptBlock $function:LocalAccounts_LocalGroupMemberMemberArgumentCompletion    
