
#
# .SYNOPSIS
#
#    Complete the -Counter argument to Get-Counter cmdlet
#
function CounterParameterCompletion
{
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


#
# .SYNOPSIS
#
#     Completes names of the logs for Get-WinEvent cmdlet.
#
function GetWinEvent_ListLogCompleter
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.GetLogNames() | Where-Object {$_ -like "*$wordToComplete*"} | Sort-Object | ForEach-Object {
        New-CompletionResult $_ $_
    }
}


#
# .SYNOPSIS
#
#     Completes providers names for Get-WinEvent cmdlet.
#
function GetWinEvent_ListProviderCompleter
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession.GetProviderNames() | Where-Object {$_ -like "*$wordToComplete*"} | Sort-Object | ForEach-Object {
        New-CompletionResult $_ $_
    }
}


Register-ArgumentCompleter `
    -Command 'Get-Counter' `
    -Parameter 'Counter' `
    -Description @'
Complete counter for the Get-Counter cmdlet, optionally on a remote machine. For example:
    Get-Counter -Counter <TAB>
    Get-Counter -cn 127.0.0.1 -Counter <TAB>
'@ `
    -ScriptBlock $function:CounterParameterCompletion


Register-ArgumentCompleter `
    -Command 'Get-Counter' `
    -Parameter 'ListSet' `
    -Description @'
Complete counter sets for the Get-Counter cmdlet, optionally on a remote machine. For example:
    Get-Counter -ListSet <TAB>
    Get-Counter -cn 127.0.0.1 -ListSet <TAB>
'@ `
    -ScriptBlock $function:ListSetParameterCompletion


Register-ArgumentCompleter `
    -Command 'Get-WinEvent' `
    -Parameter 'LogName' `
    -Description 'Completes names for the logs, for example:  Get-WinEvent -LogName <TAB>' `
    -ScriptBlock $function:GetWinEvent_LogNameCompleter


Register-ArgumentCompleter `
    -Command 'Get-WinEvent' `
    -Parameter 'ListLog' `
    -Description 'Completes names for the logs, for example:  Get-WinEvent -ListLog <TAB>' `
    -ScriptBlock $function:GetWinEvent_ListLogCompleter


Register-ArgumentCompleter `
    -Command 'Get-WinEvent' `
    -Parameter 'ListProvider' `
    -Description 'Completes names of the providers, for example:  Get-WinEvent -ListProvider <TAB>' `
    -ScriptBlock $function:GetWinEvent_ListProviderCompleter
