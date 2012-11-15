
#
# .SYNOPSIS
#
#    Complete the -Attributes argument to Get-ChildItem
#
function DirAttributesParameterNameCompletion
{
    [ArgumentCompleter(
        Parameter = "Attributes",
        Command = "Get-ChildItem",
        Description = @"
Complete file attributes like Hidden or ReadOnly, for example:

    Get-ChildItem -Attributes <TAB>
"@)]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    [System.IO.FileAttributes].GetFields('Public,Static').Name |
        Where-Object { $_ -like "$wordToComplete*" } |
        Sort-Object |
        ForEach-Object {
            # TODO - use xml docs for tooltip
            New-CompletionResult $_
        }
}
