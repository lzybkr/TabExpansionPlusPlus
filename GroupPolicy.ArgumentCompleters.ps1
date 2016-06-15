# ARGUMENT COMPLETER FUNCTIONS #################################################

# GPO
function GroupPolicy_GPONameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalDomain = @{}
    $Domain = $fakeBoundParameter["Domain"]
    if($Domain)
    {
        $optionalDomain.Domain = $Domain
    }

    GroupPolicy\Get-GPO -All @optionalDomain |
        Where-Object {$_.DisplayName -like "$wordToComplete*"} |
        Sort-Object -Property DisplayName |
        ForEach-Object {
            $ToolTip = "Name: {0} - GUID: {1}" -f $_.DisplayName,$_.Id 
            New-CompletionResult -CompletionText $_.DisplayName -ToolTip $ToolTip
        }
}
function GroupPolicy_GPOGUIDArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalDomain = @{}
    $Domain = $fakeBoundParameter["Domain"]
    if($Domain)
    {
        $optionalDomain.Domain = $Domain
    }

    GroupPolicy\Get-GPO -All @optionalDomain |
        Where-Object {$_.DisplayName -like "$wordToComplete*"} |
        Sort-Object -Property DisplayName |
        ForEach-Object {
            $ToolTip = "Name: {0} - GUID: {1}" -f $_.DisplayName,$_.Id 
            New-CompletionResult -CompletionText $_.Id -ToolTip $ToolTip -ListItemText $_.DisplayName
        }
}

# StarterGPO
function GroupPolicy_StarterGPONameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalDomain = @{}
    $Domain = $fakeBoundParameter["Domain"]
    if($Domain)
    {
        $optionalDomain.Domain = $Domain
    }

    GroupPolicy\Get-GPStarterGPO -All @optionalDomain | 
        Where-Object {$_.DisplayName -like "$wordToComplete*"} |
        Sort-Object -Property DisplayName |
        ForEach-Object {
            $ToolTip = "Name: {0} - GUID: {1}" -f $_.DisplayName,$_.Id 
            New-CompletionResult -CompletionText $_.DisplayName -ToolTip $ToolTip
        }
}
function GroupPolicy_StarterGPOGUIDArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalDomain = @{}
    $Domain = $fakeBoundParameter["Domain"]
    if($Domain)
    {
        $optionalDomain.Domain = $Domain
    }

    GroupPolicy\Get-GPStarterGPO -All @optionalDomain | 
        Where-Object {$_.DisplayName -like "$wordToComplete*"} |
        Sort-Object -Property DisplayName |
        ForEach-Object {
            $ToolTip = "Name: {0} - GUID: {1}" -f $_.DisplayName,$_.Id 
            New-CompletionResult -CompletionText $_.Id -ToolTip $ToolTip -ListItemText $_.DisplayName
        }
}

# ARGUMENT COMPLETER REGISTRATION ##############################################

# GPO
Register-ArgumentCompleter `
    -Command ('Get-GPO','Get-GPOReport','Get-GPPermission','Get-GPPrefRegistryValue','Get-GPRegistryValue','Backup-GPO','New-GPLink','Remove-GPLink','Remove-GPO','Remove-GPPrefRegistryValue','Remove-GPRegistryValue','Rename-GPO','Set-GPLink','Get-GPPermission','Set-GPPrefRegistryValue','Set-GPRegistryValue') `
    -Parameter 'Name' `
    -Description 'Complete GPO names, for example: Get-GPO -Name <TAB>' `
    -ScriptBlock $function:GroupPolicy_GPONameArgumentCompletion

Register-ArgumentCompleter `
    -Command ('Get-GPO','Get-GPOReport','Get-GPPermission','Get-GPPrefRegistryValue','Get-GPRegistryValue','Backup-GPO','New-GPLink','Remove-GPLink','Remove-GPO','Remove-GPPrefRegistryValue','Remove-GPRegistryValue','Rename-GPO','Set-GPLink',,'Get-GPPermission','Set-GPPrefRegistryValue','Set-GPRegistryValue') `
    -Parameter 'GUID' `
    -Description 'Complete GPO names, for example: Get-GPO -GUID <TAB>' `
    -ScriptBlock $function:GroupPolicy_GPOGUIDArgumentCompletion

# Starter GPO
Register-ArgumentCompleter `
    -Command ('Get-GPStarterGPO') `
    -Parameter 'Name' `
    -Description 'Complete Starter GPO names, for example: Get-GPStarterGPO -Name <TAB>' `
    -ScriptBlock $function:GroupPolicy_StarterGPONameArgumentCompletion

Register-ArgumentCompleter `
    -Command ('Get-GPStarterGPO') `
    -Parameter 'GUID' `
    -Description 'Complete Starter GPO names, for example: Get-GPStarterGPO -GUID <TAB>' `
    -ScriptBlock $function:GroupPolicy_StarterGPOGUIDArgumentCompletion
