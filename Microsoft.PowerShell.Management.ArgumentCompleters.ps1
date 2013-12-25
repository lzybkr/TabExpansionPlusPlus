#
# .SYNOPSIS
#
#    Complete the -Namespace argument to Wmi cmdlets (similiar to buil-in cim cmdlets namespace completion support)
#
function WmiNamespaceCompleter
{
    [ArgumentCompleter(
        Parameter = 'Namespace',
        Command = {Get-CommandWithParameter -Noun wmi* -ParameterName Namespace},
        Description = 'Complete the -Namespace argument to Wmi cmdlets. For example: Get-WmiObject -Namespace <TAB>'
    )]
   param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $nsParent='root'

    if ($wordToComplete)
    {
        [int]$delimiter = $wordToComplete.LastIndexOfAny([char[]]('\','/'))
        if($delimiter -ne -1)
        {
                $nsParent = $wordToComplete.Substring(0,$delimiter)
                $nsLeaf = $wordToComplete.Substring($delimiter+1)
        }
    }

   Microsoft.PowerShell.Management\Get-WmiObject -Class __NAMESPACE -Namespace $nsParent | Where-Object Name -like $nsLeaf* | Sort-Object Name | ForEach-Object {
         $namespace = '{0}/{1}' -f $nsParent.Replace('\','/'),$_.Name
         New-CompletionResult $namespace $namespace
   }
}


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


#
# .SYNOPSIS
#
#     Completer for *-ControlPanelItem -Name parameter
#
function ControlPanelItemNameCompleter
{
    [ArgumentCompleter(
        Parameter = 'Name',
        Command = {Get-CommandWithParameter -Noun ControlPanelItem -ParameterName Name},
        Description = 'Complete the -Name argument to ControlPanelItem cmdlets. For example: Show-ControlPanelItem -Name <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-ControlPanelItem -Name "*$wordToComplete*" | ForEach-Object {
        New-CompletionResult $_.Name $_.Description
    }
}


#
# .SYNOPSIS
#
#     Completer for *-ControlPanelItem -CanonicalName parameter
#
function ControlPanelItemCanonicalNameCompleter
{
    [ArgumentCompleter(
        Parameter = 'CanonicalName',
        Command = {Get-CommandWithParameter -Noun ControlPanelItem -ParameterName CanonicalName},
        Description = 'Complete the -CanonicalName argument to ControlPanelItem cmdlets. For example: Show-ControlPanelItem -Name <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-ControlPanelItem -CanonicalName "*$wordToComplete*" | ForEach-Object {
        New-CompletionResult $_.CanonicalName $_.Description
    }
}
