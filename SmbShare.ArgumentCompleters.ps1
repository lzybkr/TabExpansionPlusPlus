#
# .SYNOPSIS
#
#    Complete the -Name argument to *SmbShare cmdlets
#
function SmbShareNameParameterCompletion
{
    [ArgumentCompleter(
        Parameter = 'Name',
        Command = ('Get-SmbShare', 'Remove-SmbShare', 'Set-SmbShare'),
        Description = 'Complete share names.')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCimSession = @{}
    $cimSession = $fakeBoundParameter['CimSession']
    if ($cimSession)
    {
        $optionalCimSession['CimSession'] = $cimSession
    }

    Get-SmbShare -Name "$wordToComplete*" @optionalCimSession |
        Sort-Object Name |
        ForEach-Object {
            New-CompletionResult $_.Name $_.Description
        }
} 
