
#
# .SYNOPSIS
#
#    Complete the -Parameter argument to Get-Help
#
function HelpParameterNameCompletion
{
    [ArgumentCompleterAttribute(
        Parameter = 'Parameter',
        Command = ('help','Get-Help'),
        Description = 'Complete parameter names for get-help, for example: Get-Help -Name Get-ChildItem -Parameter <TAB>')]
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
    [ArgumentCompleterAttribute(
        Parameter = 'Name',
        Command = 'Get-PSSnapin',
        Description = 'Complete loaded snapins for: Get-PSSnapin -Name <TAB>')]
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
    [ArgumentCompleterAttribute(
        Parameter = 'Name',
        Command = 'Add-PSSnapin',
        Description = 'Complete registered snapins for: Add-PSSnapin -Name <TAB>')]
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
    [ArgumentCompleterAttribute(
        Parameter = 'Verb',
        Command = 'Get-Command',
        Description = 'Complete valid verbs for: Get-Command -Verb <TAB>')]
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
    [ArgumentCompleterAttribute(
        Parameter = 'Noun',
        Command = 'Get-Command',
        Description = 'Complete nouns for: Get-Command -Noun <TAB>')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-Command -Noun $wordToComplete* |
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
    [ArgumentCompleterAttribute(
        Parameter = 'ConfigurationName',
        Command = ('Connect-PSSession', 'Enter-PSSession',
                   'Get-PSSession', 'Invoke-Command',
                   'New-PSSession', 'Receive-PSSession'),
        Description = @'
Complete session configuration names for various remoting commands if possible.
Completion will fail if -ComputerName is not specified or if credentials are required to connect.
Examples:
    Invoke-Command localhost -ConfigurationName <TAB>
    New-PSSession -cn 127.0.0.1 -ConfigurationName <TAB>
'@)]
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
