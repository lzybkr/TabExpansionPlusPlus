#
# .SYNOPSIS
#
#    Complete the -TaskName argument to ScheduledTask module cmdlets
#
function ScheduledTaskTaskNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-ScheduledTask -TaskName "$wordToComplete*" |
        Sort-Object TaskName |
        ForEach-Object {
            New-CompletionResult $_.TaskName $_.Description
        }
}


#
# .SYNOPSIS
#
#    Complete the -TaskPath argument to ScheduledTask module cmdlets
#
function ScheduledTaskTaskPathArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-ScheduledTask -TaskPath "*$wordToComplete*" |
        Sort-Object TaskPath |
        ForEach-Object {
            New-CompletionResult $_.TaskPath $_.Description
        }
}


Register-ArgumentCompleter `
    -Command ('Disable-ScheduledTask','Enable-ScheduledTask','Export-ScheduledTask','Get-ClusteredScheduledTask','Get-ScheduledTask','Get-ScheduledTaskInfo','Register-ClusteredScheduledTask','Register-ScheduledTask','Set-ClusteredScheduledTask','Set-ScheduledTask','Start-ScheduledTask','Stop-ScheduledTask','Unregister-ClusteredScheduledTask','Unregister-ScheduledTask') `
    -Parameter 'TaskName' `
    -Description 'Complete task names' `
    -ScriptBlock $function:ScheduledTaskTaskNameArgumentCompletion


Register-ArgumentCompleter `
    -Command ('Disable-ScheduledTask','Enable-ScheduledTask','Export-ScheduledTask','Get-ScheduledTask','Get-ScheduledTaskInfo','Register-ScheduledTask','Set-ScheduledTask','Start-ScheduledTask','Stop-ScheduledTask','Unregister-ScheduledTask') `
    -Parameter 'TaskPath' `
    -Description 'Complete task path arguments for scheduled task cmdlets' `
    -ScriptBlock $function:ScheduledTaskTaskPathArgumentCompletion
