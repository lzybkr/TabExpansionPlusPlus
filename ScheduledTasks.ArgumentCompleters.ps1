#
# .SYNOPSIS
#
#    Complete the -TaskName argument to ScheduledTask module cmdlets
#
function ScheduledTaskTaskNameArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'TaskName',
        Command = { Get-Command -Module ScheduledTasks -ParameterName TaskName },
        Description = 'Complete task names')]
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
    [ArgumentCompleter(
        Parameter = 'TaskPath',
        Command = {
            # REVIEW: should Set-ScheduledTask be excluded?
            Get-Command -Module ScheduledTasks -ParameterName TaskPath },
        Description = 'Complete task path arguments for scheduled task cmdlets')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-ScheduledTask -TaskPath "*$wordToComplete*" |
        Sort-Object TaskPath |
        ForEach-Object {
            New-CompletionResult $_.TaskPath $_.Description
        } 
}
