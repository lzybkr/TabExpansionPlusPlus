
#
# .SYNOPSIS
#
#    Complete the -Parameter argument to Get-Help
#
function HelpParameterNameCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $helpCommandName = $fakeBoundParameter['Name']

    if ($helpCommandName)
    {
        $parameters = (Get-Command -Name $helpCommandName).Parameters
        $parameters.Keys |
            Where-Object { $_ -like "$wordToComplete*" } |
            Sort-Object |
            ForEach-Object {
                # The tooltip will look similar to what shows up
                # in the syntax, e.g. [[-Name <string>]
                $md = $parameters.$_
                $positional = $false
                $mandatory = $true
                $isSwitch = $md.SwitchParameter
                foreach ($attr in $md.Attributes)
                {
                    if ($attr -is [Parameter])
                    {
                        if ($attr.Position -ge 0) { $positional = $true }
                        if (!$attr.Mandatory) { $mandatory = $false }
                    }
                }
                $tooltip = "-$_"
                if ($positional) { $tooltip = "[$tooltip]" }
                if (!$isSwitch) { $tooltip += " <$($md.ParameterType)>" }
                if (!$mandatory) { $tooltip = "[$tooltip]" }

                New-CompletionResult $_ $tooltip
            }
    }
}


#
# .SYNOPSIS
#
#     Complete snapin name arguments
#
function GetSnapinCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-PSSnapin $wordToComplete* |
        Sort-Object -Property Name |
        ForEach-Object {
            New-CompletionResult $_.Name $_.Description
        }
}


#
# .SYNOPSIS
#
#     Complete snapin name arguments
#
function AddSnapinCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-PSSnapin -Registered -Name "$wordToComplete*" |
        Sort-Object -Property Name |
        ForEach-Object {
            New-CompletionResult $_.Name $_.Description }
}


#
# .SYNOPSIS
#
#     Complete verb arguments
#
function VerbCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-Verb "$wordToComplete*" |
        ForEach-Object {
            New-CompletionResult $_.Verb ("Group: " + $_.Group)
        }
}


#
# .SYNOPSIS
#
#     Complete Noun argument to Get-Command
#
function NounCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalParam = @{}
    $module = $fakeBoundParameter['Module']
    if ($module)
    {
        $optionalParam.Module = $module
    }

    Get-Command -Noun $wordToComplete* @optionalParam |
        ForEach-Object {($_.Name -split '-',2)[1] } | Sort-Object -Unique | ForEach-Object {
            # TODO - is a decent tooltip possible?
            New-CompletionResult $_
    }
}


#
# .SYNOPSIS
#
#     Complete session configuration name arguments
#
function PSSessionConfigurationNameCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    # These completions are pretty slow because they go through remoting to get the
    # remote configuration names.
    if ($fakeBoundParameter['ComputerName'])
    {
        Invoke-Command -ComputerName $fakeBoundParameter['ComputerName'] `
            { Get-PSSessionConfiguration -Name $using:wordToComplete* } |
            Sort-Object -Property Name |
            ForEach-Object {
                New-CompletionResult $_.Name ($_ | Out-String)
            }
    }
}


#
# .SYNOPSIS
#
#     Completes -Version for Set-StrictMode
#
function SetStrictMode_VersionCompleter
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    '1.0', '2.0', '3.0', 'latest' | where { $_ -like "$wordToComplete*" } |
    ForEach-Object {
        New-CompletionResult $_ "Version $_"
    }
}


# .SYNOPSIS
#
#    Complete the -Module argument to Save/Update-Help cmdlets
#
function HelpModuleCompleter
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Microsoft.PowerShell.Core\Get-Module -ListAvailable -Name "$wordToComplete*" | Sort-Object Name | ForEach-Object {
        $tooltip = "Description: {0}`nModuleType: {1}`nPath: {2}" -f $_.Description, $_.ModuleType, $_.Path
        New-CompletionResult $_.Name $tooltip
    }
}


#
# .SYNOPSIS
#
#    Completes the -Scope argument to the *-Variable, *-Alias, *-PSDrive
#
function ScopeParameterCompleter
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    echo Global Local Script Private | Where-Object {$_ -like "$wordToComplete*"} | ForEach-Object {
        New-CompletionResult $_ "Scope '$_'"
    }
}


#
# .SYNOPSIS
#
#     Tab-completes names of help topics, also conceptual (about_*).
#
function HelpNameCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    # First - commands... but we need to leave All and Application out...
    $commands = @([System.Management.Automation.CompletionCompleters]::CompleteCommand(
        $wordToComplete,
        '*', # Any module
        $([enum]::GetNames(
            [System.Management.Automation.CommandTypes]
        ) | where { $_ -notin 'All', 'Application' })
    ))

    # Then - about_*.
    # About for main PS first...
    $psHomeHelpFiles = @(Get-ChildItem -Path $PSHOME\*\*.help.txt)

    # And for any other modules...
    $modulesHelpFiles = @(Get-Module | where ModuleBase -ne $PSHOME) |
        Get-ChildItem -Path { $_.ModuleBase } -Filter *.help.txt -Recurse

    $abouts = $psHomeHelpFiles + $modulesHelpFiles |
        Where-Object { $_.Name -like "$wordToComplete*" } |
        Sort-Object -Property Name |
        ForEach-Object {
            $text = $_.Name -replace '\.help\.txt'
            if ((Get-Content -Raw -Path $_.FullName) -replace '\s+', ' ' -match
                'SHORT DESCRIPTION ([\s\S]*?) LONG') {
                $toolTip = $Matches[1]
            } else {
                $toolTip = $text
            }
            New-CompletionResult $text $toolTip
        }

    # And last but not least - providers
    $providers = Get-PSProvider |
        Where-Object {
            $_.Name -like "$wordToComplete*" -and
            $_.HelpFile } |
        Sort-Object -Property Name |
        ForEach-Object {
            $toolTip = "Name: {0} Drives: {1}" -f $_.Name, $($_.Drives -join ", ")
            New-CompletionResult $_.Name $toolTip
        }

    # combine all to get mix of different types rather than FIFO with providers/ abouts at the end...
    $commands + $abouts + $providers | Sort-Object -Property ListItemText
}


# .SYNOPSIS
#
#    Complete the -Name argument to Import-Module
#
function ImportModuleNameCompleter
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Microsoft.PowerShell.Core\Get-Module -ListAvailable -Name "$wordToComplete*" | Sort-Object Name | ForEach-Object {
        $tooltip = "Description: {0}`nModuleType: {1}`nPath: {2}" -f $_.Description,$_.ModuleType,$_.Path
        New-CompletionResult $_.Name $tooltip
    }
}


Register-ArgumentCompleter `
    -Command ('help','Get-Help') `
    -Parameter 'Parameter' `
    -Description 'Complete parameter names for get-help, for example: Get-Help -Name Get-ChildItem -Parameter <TAB>' `
    -ScriptBlock $function:HelpParameterNameCompletion


Register-ArgumentCompleter `
    -Command 'Get-PSSnapin' `
    -Parameter 'Name' `
    -Description 'Complete loaded snapins for: Get-PSSnapin -Name <TAB>' `
    -ScriptBlock $function:GetSnapinCompletion


Register-ArgumentCompleter `
    -Command 'Add-PSSnapin' `
    -Parameter 'Name' `
    -Description 'Complete registered snapins for: Add-PSSnapin -Name <TAB>' `
    -ScriptBlock $function:AddSnapinCompletion


Register-ArgumentCompleter `
    -Command 'Get-Command' `
    -Parameter 'Verb' `
    -Description 'Complete valid verbs for: Get-Command -Verb <TAB>' `
    -ScriptBlock $function:VerbCompletion


Register-ArgumentCompleter `
    -Command 'Get-Command' `
    -Parameter 'Noun' `
    -Description 'Complete nouns for: Get-Command -Noun <TAB>' `
    -ScriptBlock $function:NounCompletion


Register-ArgumentCompleter `
    -Command ('Connect-PSSession', 'Enter-PSSession',
                   'Get-PSSession', 'Invoke-Command',
                   'New-PSSession', 'Receive-PSSession') `
    -Parameter 'ConfigurationName' `
    -Description @'
Complete session configuration names for various remoting commands if possible.
Completion will fail if -ComputerName is not specified or if credentials are required to connect.
Examples:
    Invoke-Command localhost -ConfigurationName <TAB>
    New-PSSession -cn 127.0.0.1 -ConfigurationName <TAB>
'@ `
    -ScriptBlock $function:PSSessionConfigurationNameCompletion


Register-ArgumentCompleter `
    -Command 'Set-Strictmode' `
    -Parameter 'Version' `
    -Description 'Completes Version parameter for Set-StrictMode, for example:  Set-StrictMode -Version <TAB>' `
    -ScriptBlock $function:SetStrictMode_VersionCompleter


Register-ArgumentCompleter `
    -Command ('Save-Help','Update-Help') `
    -Parameter 'Module' `
    -Description 'Completes Module parameter for Save/Update-Help commands, for example:  Save-Help -Module <TAB>' `
    -ScriptBlock $function:HelpModuleCompleter


Register-ArgumentCompleter `
    -Command ('Clear-Variable','Export-Alias','Get-Alias','Get-PSDrive','Get-Variable','Import-Alias','Import-Module','New-Alias','New-PSDrive','New-Variable','Remove-PSDrive','Remove-Variable','Set-Alias','Set-Variable') `
    -Parameter 'Scope' `
    -Description 'Completes the Scope argument for *-Variable, *-Alias, *-PSDrive. For example:  Get-Variable -Scope <TAB>' `
    -ScriptBlock $function:ScopeParameterCompleter


Register-ArgumentCompleter `
    -Command ('help','Get-Help') `
    -Parameter 'Name' `
    -Description 'Tab completes names of help articles, for example:  Get-Help -Name <TAB>' `
    -ScriptBlock $function:HelpNameCompletion


Register-ArgumentCompleter `
    -Command 'Import-Module' `
    -Parameter 'Name' `
    -Description 'Complete the -Name argument to Import-Module, for example:  Import-Module -Name <TAB>' `
    -ScriptBlock $function:ImportModuleNameCompleter
