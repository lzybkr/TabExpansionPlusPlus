
#
# .SYNOPSIS
#
#    Complete the -Counter argument to Get-Counter cmdlet
#
function CounterParameterCompletion
{
    [ArgumentCompleter(
        Parameter = 'Counter',
        Command = 'Get-Counter',
        Description = @'
Complete counter for the Get-Counter cmdlet, optionally on a remote machine. For example:
    Get-Counter -Counter <TAB>
    Get-Counter -cn 127.0.0.1 -Counter <TAB>
'@)]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCn = @{}
    $cn = $fakeBoundParameter["ComputerName"]
    if($cn)
    {
        $optionalCn.ComputerName = $cn
    }

    (Get-Counter -ListSet * @optionalCn).Counter |
        Where-Object { $_ -like "$wordToComplete*" } |
        Sort-Object |
        ForEach-Object {
            # TODO: need a tooltip
            New-CompletionResult $_
        }
} 


#
# .SYNOPSIS
#
#    Complete the -ListSet argument to Get-Counter cmdlet
#
function ListSetParameterCompletion
{
    [ArgumentCompleter(
        Parameter = 'ListSet',
        Command = 'Get-Counter',
        Description = @'
Complete counter sets for the Get-Counter cmdlet, optionally on a remote machine. For example:
    Get-Counter -ListSet <TAB>
    Get-Counter -cn 127.0.0.1 -ListSet <TAB>
'@)]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCn = @{}
    $cn = $fakeBoundParameter["ComputerName"]
    if($cn)
    {
        $optionalCn.ComputerName = $cn
    }

    Get-Counter -ListSet "$wordToComplete*" @optionalCn |
        Sort-Object CounterSetName |
        ForEach-Object {
            $tooltip = $_.Description
            New-CompletionResult $_.CounterSetName $tooltip
        }
} 


#
# .SYNOPSIS
#
#     Completes names of the logs for Get-WinEvent cmdlet.
#
function GetWinEvent_LogNameCompleter
{
    [ArgumentCompleter(
        Parameter = 'LogName',
        Command = 'Get-WinEvent',
        Description = 'Completes names for the logs, for example:  Get-WinEvent -LogName <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCn = @{}
    $cn = $fakeBoundParameter['ComputerName']
    if ($cn) 
    {
        $optionalCn.ComputerName = $cn
    }
    
    Get-WinEvent -ListLog "$wordToComplete*" -Force @optionalCn |
        where { $_.IsEnabled } |
        Sort-Object -Property LogName |
        ForEach-Object {
            $toolTip = "Log $($_.LogName): $($_.RecordCount) entries"
            New-CompletionResult $_.LogName $toolTip
        }
}
