#
# .SYNOPSIS
#
#    Complete the -Name argument to *SmbShare cmdlets
#
function SmbShareNameParameterCompletion
{
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


Register-ArgumentCompleter `
    -Command ('Get-SmbShare', 'Remove-SmbShare', 'Set-SmbShare','Block-SmbShareAccess','Get-SmbShareAccess','Grant-SmbShareAccess','Revoke-SmbShareAccess','Unblock-SmbShareAccess') `
    -Parameter 'Name' `
    -Description 'Complete share names.' `
    -ScriptBlock $function:SmbShareNameParameterCompletion
