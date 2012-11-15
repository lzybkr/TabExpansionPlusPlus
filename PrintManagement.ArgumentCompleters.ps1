#
# .SYNOPSIS
#
#    Complete the -Name argument to Printer cmdlets
#
function PrinterNameArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'Name',
        Command = ('Get-Printer', 'Remove-Printer', 'Set-Printer'),
        Description = 'Complete printer names')]
    [ArgumentCompleter(
        Parameter = 'PrinterName',
        Command = { Get-Command -Module PrintManagement -ParameterName PrinterName },
        Description = 'Complete printer names')]

    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCn = @{}
    $cn = $fakeBoundParameter["ComputerName"]
    if($cn)
    {
        $optionalCn.ComputerName = $cn
    }

    Get-Printer -Name "$wordToComplete*" @optionalCn |
        Sort-Object Name |
        ForEach-Object {
            $tooltip = $_.Description
            if ($tooltip -eq '') { $tooltip = $_.Location }
            if ($tooltip -eq '') { $tooltip = $_.Caption }
            New-CompletionResult $_.Name $tooltip
    }
} 


# .SYNOPSIS
#
#    Complete the -Name argument to *-PrinterDriver cmdlets
#
function PrinterDriverNameArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'Name',
        Command = ('Get-PrinterDriver', 'Remove-PrinterDriver'),
        Description = 'Complete printer driver names.')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCn = @{}
    $cn = $fakeBoundParameter["ComputerName"]
    if($cn)
    {
        $optionalCn.ComputerName = $cn
    }

    Get-PrinterDriver -Name "$wordToComplete*" @optionalCn |
        Sort-Object Name |
        ForEach-Object {
            $tooltip = $_.Description
            if (!$tooltip) { $tooltip = $_.Status }
            if (!$tooltip) { $tooltip = $_.Manufacturer }
            New-CompletionResult $_.Name $tooltip
        }
} 

#
# .SYNOPSIS
#
#    Complete the -Name argument to *-PrinterPort cmdlets
#
function PrinterPortArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'Name',
        Command = ('Get-PrinterPort', 'Remove-PrinterPort'),
        Description = 'Complete printer port names.')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCn = @{}
    $cn = $fakeBoundParameter["ComputerName"]
    if($cn)
    {
        $optionalCn.ComputerName = $cn
    }

    Get-PrinterPort -Name "$wordToComplete*" @optionalCn |
        Sort-Object Name |
        ForEach-Object {
            New-CompletionResult $_.Name $_.Description
        }
} 
