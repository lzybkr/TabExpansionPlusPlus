## Storage module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -FriendlyName argument to *-PhysicalDisk cmdlets
#
function Storage_PhysicalDiskFriendlyNameParameterCompletion
{
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


#
# .SYNOPSIS
#
#    Complete the -ImagePath argument to Mount-DiskImage
#
function ImagePathArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-CompletionWithExtension $lastWord ('.iso', '.vhd', 'vhdx')
}


Register-ArgumentCompleter `
    -Command ('Get-PhysicalDisk', 'Reset-PhysicalDisk', 'Set-PhysicalDisk') `
    -Parameter 'FriendlyName' `
    -Description 'Complete physical disk friendly names.' `
    -ScriptBlock $function:Storage_PhysicalDiskFriendlyNameParameterCompletion


Register-ArgumentCompleter `
    -Command 'Mount-DiskImage' `
    -Parameter 'ImagePath' `
    -Description 'Complete vhds and isos for Add-Type -LiteralPath' `
    -ScriptBlock $function:ImagePathArgumentCompletion
