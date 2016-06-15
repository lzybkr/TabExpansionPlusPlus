# ARGUMENT COMPLETER FUNCTIONS #################################################

# INSTANCE ID
function PnpDevice_InstanceIdArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCimSession = @{}
    $CimSession = $fakeBoundParameter["CimSession"]
    if($CimSession)
    {
        $optionalCimSession.CimSession = $CimSession
    }

    PnpDevice\Get-PnpDevice -FriendlyName "$wordToComplete*" @optionalCimSession |
        Sort-Object -Property FriendlyName |
        ForEach-Object {
            $ToolTip = "Name: {0} - Status: {1} - Class: {2} `nID: {3}" -f $_.FriendlyName,$_.Status,$_.Class,$_.InstanceId 
            New-CompletionResult -CompletionText $_.InstanceId -ToolTip $ToolTip -ListItemText $_.FriendlyName
        }
}
# FRIENDLY NAME
function PnpDevice_FriendlyNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCimSession = @{}
    $CimSession = $fakeBoundParameter["CimSession"]
    if($CimSession)
    {
        $optionalCimSession.CimSession = $CimSession
    }

    PnpDevice\Get-PnpDevice -FriendlyName "$wordToComplete*" @optionalCimSession |
        Sort-Object -Property FriendlyName |
        ForEach-Object {
            $ToolTip = "Name: {0} - Status: {1} - Class: {2} `nID: {3}" -f $_.FriendlyName,$_.Status,$_.Class,$_.InstanceId 
            New-CompletionResult -CompletionText $_.FriendlyName -ToolTip $ToolTip
        }
}
# CLASS
function PnpDevice_ClassArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCimSession = @{}
    $CimSession = $fakeBoundParameter["CimSession"]
    if($CimSession)
    {
        $optionalCimSession.CimSession = $CimSession
    }

    PnpDevice\Get-PnpDevice @optionalCimSession |
        Select-Object -Property Class -Unique |
        Sort-Object -Property Class |
        Where-Object {$_.Class -ne $null} |
        Where-Object {$_.Class -like "$wordToComplete*"} |
        ForEach-Object {
            $ToolTip = "Class: {0} - GUID: {1}" -f $_.Class,$_.ClassGuid
            New-CompletionResult -CompletionText $_.Class -ToolTip $ToolTip
        }
}
# PNPDEVICE PROPERTY KEYNAME
function PnpDevice_KeyNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalParameters = @{}
    $CimSession = $fakeBoundParameter["CimSession"]
    if($CimSession) { $optionalParameters.CimSession = $CimSession }
    $InstanceId = $fakeBoundParameter["InstanceId"]
    if($InstanceId) { $optionalParameters.InstanceId = $InstanceId }

    PnpDevice\Get-PnpDeviceProperty @optionalParameters |
        Where-Object {$_.KeyName -like "$wordToComplete*"} |
        Sort-Object -Property KeyName |
        ForEach-Object {
            $ToolTip = "KeyName: {0} - Data: {1} - Type: {2} `nID: {3}" -f $_.KeyName,$_.Data,$_.Type,$_.InstanceId 
            New-CompletionResult -CompletionText $_.KeyName -ToolTip $ToolTip
        }
}

# ARGUMENT COMPLETER REGISTRATION ##############################################

# INSTANCEID
Register-ArgumentCompleter `
    -Command ('Disable-PnpDevice','Enable-PnpDevice','Get-PnpDevice','Get-PnpDeviceProperty') `
    -Parameter 'InstanceId' `
    -Description 'Complete Pnp Device names, for example: Get-PnpDevice -InstanceId <TAB>' `
    -ScriptBlock $function:PnpDevice_InstanceIdArgumentCompletion

# FRIENDLY NAME
Register-ArgumentCompleter `
    -Command ('Get-PnpDevice') `
    -Parameter 'FriendlyName' `
    -Description 'Complete Pnp Device names, for example: Get-PnpDevice -FriendlyName <TAB>' `
    -ScriptBlock $function:PnpDevice_FriendlyNameArgumentCompletion

# CLASS
Register-ArgumentCompleter `
    -Command ('Get-PnpDevice') `
    -Parameter 'Class' `
    -Description 'Complete Pnp Device names, for example: Get-PnpDevice -Class <TAB>' `
    -ScriptBlock $function:PnpDevice_ClassArgumentCompletion

# PNPDEVICE PROPERTY KEYNAME
Register-ArgumentCompleter `
    -Command ('Get-PnpDeviceProperty') `
    -Parameter 'KeyName' `
    -Description 'Complete Pnp Device keynames, for example: Get-PnpDeviceProperty -InstanceId <id> -KeyName <TAB>' `
    -ScriptBlock $function:PnpDevice_KeyNameArgumentCompletion
