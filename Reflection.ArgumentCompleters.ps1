## Completers for Reflection module by Jaykul   ##
## Using version 4.1 - http://poshcode.org/3174 ##

function Reflection_TypeParameterArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'Type',
        Command = { Get-CommandWithParameter -Module Reflection -ParameterName Type },
        Description = 'Complete type names, for example: Get-Constructor -Type <TAB>')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    [System.Management.Automation.CompletionCompleters]::CompleteType($wordToComplete)
}

function Reflection_AcceleratorNameArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'Accelerator',
        Command = ('Get-Accelerator', 'Remove-Accelerator'),
        Description = 'Complete accelerators, for example Get-Accelerator -Accelerator <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    Reflection\Get-Accelerator -Accelerator "$wordToComplete*" |
        ForEach-Object {
            $toolTip = "Points to type: $($_.Value)"
            New-CompletionResult $_.Key $toolTip
        }
}
