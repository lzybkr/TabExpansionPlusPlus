## Storage module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -FriendlyName argument to *-PhysicalDisk cmdlets
#
function Storage_PhysicalDiskFriendlyNameParameterCompletion
{
    [ArgumentCompleterAttribute(
        Parameter = 'FriendlyName',
        Command = ('Get-PhysicalDisk', 'Reset-PhysicalDisk', 'Set-PhysicalDisk'),
        Description = 'Complete physical disk friendly names.')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Storage\Get-PhysicalDisk -FriendlyName "$wordToComplete*" |
        Sort-Object FriendlyName |
        ForEach-Object {
            $name = $_.FriendlyName
            $tooltip = $_.Description
            if (!$tooltip)
            {
                # Review - maybe just use Manufacter + Model?
                $tooltip = $_.UniqueId
            }
            New-CompletionResult $name $tooltip
        }
} 
