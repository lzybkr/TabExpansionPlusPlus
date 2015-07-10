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
    -Command ( Get-CommandWithParameter -Module ScheduledTasks -ParameterName TaskName ) `
    -Parameter 'TaskName' `
    -Description 'Complete task names' `
    -ScriptBlock $function:ScheduledTaskTaskNameArgumentCompletion


Register-ArgumentCompleter `
    -Command (
            # REVIEW: should Set-ScheduledTask be excluded?
            Get-CommandWithParameter -Module ScheduledTasks -ParameterName TaskPath ) `
    -Parameter 'TaskPath' `
    -Description 'Complete task path arguments for scheduled task cmdlets' `
    -ScriptBlock $function:ScheduledTaskTaskPathArgumentCompletion
