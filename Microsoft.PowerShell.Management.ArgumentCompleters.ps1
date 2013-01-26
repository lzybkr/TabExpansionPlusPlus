
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

#
# .SYNOPSIS
#
#    Complete the -ItemType argument to New-Item
#
function NewItemItemTypeCompletion
{
    [ArgumentCompleter(
        Parameter = 'ItemType',
        Command = 'New-Item',
        Description = @'
Complete item types (in FileSystem/ ActiveDirectory), for example:

    New-Item -ItemType <TAB>
'@)]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $pathProvided = $fakeBoundParameter['Path']
    if($pathProvided)
    {
        $resolvedPath = Resolve-Path -Path $pathProvided
    }
    else
    {
        $resolvedPath = $PWD
    }
    $completionSet = switch ($resolvedPath.Provider.Name) {
        FileSystem {
            Write-Output File, Directory   
        }
        ActiveDirectory {
            Write-Output User, Group, OrganizationalUnit, Container, Computer
        }
        Default {
            # TODO - other providers, check if AD is complete (for useful stuff at least).
            $null
        }
    }
    
    $completionSet |
        Where-Object { $_ -like "$wordToComplete*" } |
        Sort-Object |
        ForEach-Object {
            New-CompletionResult $_ -ToolTip "Create $_"
        }
}
