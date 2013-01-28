
#
# .SYNOPSIS
#
#     Complete parameters and arguments to PowerShell.exe
#
function PowerShellExeCompletion
{
    [ArgumentCompleter(
        Native,
        Command = 'PowerShell',
        Description = 'Complete parameters and arguments to powershell.exe')]
    param($wordToComplete, $commandAst)

    $tryParameters = $true
    $last = if ($wordToComplete) { -2 } else { -1 }
    $parameterAst = $commandAst.CommandElements[$last] -as [System.Management.Automation.Language.CommandParameterAst]
    if ($parameterAst -ne $null)
    {
        if ("File".StartsWith($parameterAst.ParameterName, "OrdinalIgnoreCase"))
        {
            Get-CompletionWithExtension $wordToComplete '.ps1'
            return
        }

        $completions = $null

        if ("InputFormat".StartsWith($parameterAst.ParameterName, "OrdinalIgnoreCase") -or
            "OutputFormat".StartsWith($parameterAst.ParameterName, "OrdinalIgnoreCase"))
        {
            $completions = "Text", "XML"
        }
        elseif ("WindowsStyle".StartsWith($parameterAst.ParameterName, "OrdinalIgnoreCase"))
        {
            $completions = "Normal", "Minimized", "Maximized", "Hidden"
        }
        elseif ("ExecutionPolicy".StartsWith($parameterAst.ParameterName, "OrdinalIgnoreCase"))
        {
            $completions = ([Microsoft.PowerShell.ExecutionPolicy] | Get-Member -Static -MemberType Property).Name
        }

        foreach ($completion in $completions)
        {
            $tryParameters = $false
            New-CompletionResult $completion
        }
    }

    if ($tryParameters -and ($wordToComplete.StartsWith("-") -or "" -eq $wordToComplete))
    {
        echo -- -PSConsoleFile -Version -NoLogo -NoExit -Sta -NoProfile -NonInteractive `
            -InputFormat -OutputFormat -WindowStyle -EncodedCommand -File -ExecutionPolicy `
            -Command |
            Where-Object { $_ -like "$wordToComplete*" } |
            Sort-Object |
            ForEach-Object {
                New-CompletionResult $_
            }
    }
}


#
# .SYNOPSIS
#
#     Complete parameters and arguments to net.exe
#
function NetExeCompletion
{
    [ArgumentCompleter(
        Native,
        Command = 'Net',
        Description = 'Complete arguments to net.exe')]
    param($wordToComplete, $commandAst)

    echo ACCOUNTS COMPUTER CONFIG CONTINUE FILE GROUP HELP `
        HELPMSG LOCALGROUP PAUSE SESSION SHARE START `
        STATISTICS STOP TIME USE USER VIEW |
        Where-Object { $_ -like "$wordToComplete*" } |
        Sort-Object |
        ForEach-Object {
            New-CompletionResult $_
        }
}


#
# .SYNOPSIS
#
#     Complete parameters and arguments to bcedit.exe
#
function BCDEditExeCompletion
{
    [ArgumentCompleter(
        Native,
        Command = 'bcdedit',
        Description = 'Complete arguments to bcdedit.exe')]
    param($wordToComplete, $commandAst)

    $BCDEditSwitches = Get-CompletionPrivateData -Key BCDEdit
    if ($null -eq $BCDEditSwitches)
    {
        # This is a very naive implementation - parse the output of bcdedit
        # run a couple different ways to collect candidate completions.

        $switches = bcdedit /? 2>$null | ForEach-Object { [regex]::Matches($_, '/\w+').Value } | Sort-Object -Unique
        $switches += '/?'

        $nestedSwitches = @()
        foreach ($switch in $switches)
        {
            $nestedSwitches += bcdedit /? $switch 2>$null | ForEach-Object { [regex]::Matches($_, '/\w+').Value }
        }
    
        $BCDEditSwitches = ($switches += $nestedSwitches) | Sort-Object -Unique
        Set-CompletionPrivateData -Key BCDEdit -Value $BCDEditSwitches
    }

    $BCDEditSwitches |
        Where-Object { $_ -like "$wordToComplete*" } |
        ForEach-Object { New-CompletionResult $_ }

    # Also complete GUIDs and named configs - don't cache these, they might change
    # TODO: This can be smarter, I think it can suggest things that don't work.
    # TODO: THe following doesn't do anything useful if the process isn't elevated.
    bcdedit /ENUM 2>$null |
        ForEach-Object { [regex]::Matches($_, '\{[\w-]+\}').Value } |
        Sort-Object -Unique |
        Where-Object { $_ -like "$wordToComplete*" } |
        ForEach-Object { New-CompletionResult $_ }
}
