## Completers for Reflection module by Jaykul   ##
## Using version 4.1 - http://poshcode.org/3174 ##

function Reflection_GetContstructorArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'Type',
        Command = 'Get-Constructor',
        Description = 'Complete type names, for example: Get-Constructor -Type <TAB>')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    [System.Management.Automation.CompletionCompleters]::CompleteType($wordToComplete)
}
