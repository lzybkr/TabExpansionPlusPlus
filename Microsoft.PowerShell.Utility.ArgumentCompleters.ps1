
#
# Reading the registry for progids takes > 500ms, so we do it at module load time.
#
function InitClassIdTable
{
    [InitializeArgumentCompleter('New-Object_ComObject')]
    param()

    $progIds = [Microsoft.Win32.Registry]::ClassesRoot.GetSubKeyNames()
    $versionedProgIds = new-object System.Collections.Generic.List[string]

    function AddProgId($progId)
    {
        $subKey = [Microsoft.Win32.Registry]::ClassesRoot.OpenSubKey($progId)
        foreach ($clsidSubkey in $subKey.GetSubKeyNames())
        {
            if ($clsidSubkey -eq 'CLSID')
            {
                $description = $subKey.GetValue('')
                $result[$progId] = $description
                break
            }
        }
    }

    $result = [ordered]@{}
    foreach ($progId in $progIds)
    {
        # Skip versioned progIds (ends in digits) for now - we'll make a second pass
        # and add those if there is no version indepent progId.
        if ($progId -match '^(\w+\.\w+)\.[\d]+(\.\d+)?$')
        {
            $versionedProgIds.Add($progId)
            continue
        }

        # Check if it really is a progId - does it have a CLSID underneath
        AddProgId $progId
    }

    foreach ($progId in $versionedProgIds)
    {
        $null = $progId -match '^(\w+\.\w+)\.[\d]+(\.\d+)?$'
        if (!$result[$matches[1]])
        {
            AddProgId $progId
        }
    }

    return $result
}

#
# .SYNOPSIS
#
#     Complete -ComObject arguments
#
function NewComObjectCompletion
{
    [ArgumentCompleter(
        Parameter = 'ComObject',
        Command = 'New-Object',
        Description = 'Complete com object class ids for New-Object -ComObject <TAB>')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $allProgIds = Get-CompletionPrivateData -Key New-Object_ComObject
    # TODO - is sorting from intialization good enough?  This completion is pretty slow
    # as is if $wordToComplete is empty.
    $allProgIds.GetEnumerator() |
        Where-Object Key -like "$wordToComplete*" |
        ForEach-Object {
            $progId = $_.Key
            $tooltip = $_.Value
            New-CompletionResult $progId $tooltip }
}


#
# .SYNOPSIS
#
#     Complete event name arguments
#
function EventNameCompletion
{
    [ArgumentCompleter(
        Parameter = 'EventName',
        Command = 'Register-ObjectEvent',
        Description = @'
Complete the -EventName argument for Register-ObjectEvent, for example:

    $timer = new-object System.Timers.Timer
    Register-ObjectEvent -InputObject $timer -EventName <TAB>
'@
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $inputObject = $fakeBoundParameter["InputObject"]
    if ($null -ne $inputObject)
    {
        $inputObject.GetType().GetEvents("Public,Instance").Name |
            Where-Object { $_ -like "$wordToComplete*" } |
            Sort-Object |
            ForEach-Object {
                New-CompletionResult $_ "Event $_"
            }
    }
}


#
# .SYNOPSIS
#
#    Complete the -Name argument to Out-Printer 
#
function OutPrinterNameArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'Name',
        Command = 'Out-Printer',
        Description = 'Complete printer names for Out-Printer')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-WmiObject -Class Win32_Printer |
        Where-Object Name -like "$wordToComplete*" |
        Sort-Object Name |
        ForEach-Object {
            New-CompletionResult $_.Name $_.Location
        }
}


#
# .SYNOPSIS
#
#     Complete arguments that take ps1xml files for the Update-[Type|Format]Data commands.
#
function AddTypePathArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'Path',
        Command = 'Add-Type',
        Description = 'Complete source code and dlls for Add-Type -Path')]
    [ArgumentCompleter(
        Parameter = 'LiteralPath',
        Command = 'Add-Type',
        Description = 'Complete source code and dlls for Add-Type -LiteralPath')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-CompletionWithExtension $lastWord ('.dll', '.cs', '.vb', '.js')
}


#
# .SYNOPSIS
#
#     Complete arguments that take ps1xml files for the Update-[Type|Format]Data commands.
#
function Ps1xmlPathArgumentCompletion
{
    [ArgumentCompleter(
        Parameter = 'AppendPath',
        Command = ('Update-TypeData', 'Update-FormatData'),
        Description = 'Complete ps1xml files for -AppendPath')]
    [ArgumentCompleter(
        Parameter = 'PrependPath',
        Command = ('Update-TypeData', 'Update-FormatData'),
        Description = 'Complete ps1xml files for -PrependPath')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-CompletionWithExtension $lastWord '.ps1xml'
}
