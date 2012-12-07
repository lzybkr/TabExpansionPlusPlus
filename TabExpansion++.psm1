#############################################################################
#
# TabExpansion++
#
#

# Save off the previous tab completion so it can be restored if this module
# is removed.
$oldTabExpansion = $function:TabExpansion
$oldTabExpansion2 = $function:TabExpansion2

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove =
{
    if ($null -ne $oldTabExpansion)
    {
        Set-Item function:\TabExpansion $oldTabExpansion
    }
    if ($null -ne $oldTabExpansion2)
    {
        Set-Item function:\TabExpansion2 $oldTabExpansion2
    }
}


#region Non-exported utility functions for completers

#############################################################################
#
# Helper function to create a new completion results
#
function New-CompletionResult
{
    param([Parameter(Position=0, ValueFromPipelineByPropertyName, Mandatory)]
          [ValidateNotNullOrEmpty()]
          [string]
          $CompletionText,

          [Parameter(Position=1, ValueFromPipelineByPropertyName)]
          [string]
          $ToolTip,

          [string]
          $ListItemText = $CompletionText,

          [System.Management.Automation.CompletionResultType]
          $CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue)
    
    if ($ToolTip -eq '')
    {
        $ToolTip = $CompletionText
    }

    if ($CompletionResultType -eq [System.Management.Automation.CompletionResultType]::ParameterValue)
    {
        # Add single quotes for the caller in case they are needed.
        # We use the parser to robustly determine how it will treat
        # the argument.  If we end up with too many tokens, or if
        # the parser found something expandable in the results, we
        # know quotes are needed.

        $tokens = $null
        $null = [System.Management.Automation.Language.Parser]::ParseInput("echo $CompletionText", [ref]$tokens, [ref]$null)
        if ($tokens.Length -ne 3 -or
            ($tokens[1] -is [System.Management.Automation.Language.StringExpandableToken] -and
             $tokens[1].Kind -eq [System.Management.Automation.Language.TokenKind]::Generic))
        {
            $CompletionText = "'$CompletionText'"
        }
    }
    return New-Object System.Management.Automation.CompletionResult `
        ($CompletionText,$ListItemText,$CompletionResultType,$ToolTip.Trim())
}

#############################################################################
#
# .SYNOPSIS
#
#     This is a simple wrapper of Get-Command gets commands with a given
#     parameter ignoring commands that use the parameter name as an alias.
#
function Get-CommandWithParameter
{
[CmdletBinding(DefaultParameterSetName='AllCommandSet')]
param(
    [Parameter(ParameterSetName='AllCommandSet', Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string[]]
    ${Name},

    [Parameter(ParameterSetName='CmdletSet', ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${Verb},

    [Parameter(ParameterSetName='CmdletSet', ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${Noun},

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string[]]
    ${Module},

    [ValidateNotNullOrEmpty()]
    [Parameter(Mandatory)]
    [string]
    ${ParameterName})

    begin
    {
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Get-Command', [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = { & $wrappedCmd @PSBoundParameters | Where-Object { $_.Parameters[$ParameterName] -ne $null } }
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    }
    process
    {
        $steppablePipeline.Process($_)
    }
    end
    {
        $steppablePipeline.End()
    }
}

#############################################################################
#
function Set-CompletionPrivateData
{
    param(
        [ValidateNotNullOrEmpty()]
        [string]
        $Key,

        [object]
        $Value)

    $completionPrivateData[$key] = $value
}

#############################################################################
#
function Get-CompletionPrivateData
{
    param(
        [ValidateNotNullOrEmpty()]
        [string]
        $Key)

    Flush-BackgroundResultsQueue
    return $completionPrivateData[$key]
}

#endregion Non-exported utility functions for completers

#region Exported functions

#############################################################################
#
# .SYNOPSIS
#     Register a ScriptBlock to perform argument completion for a
#     given command or parameter.
#
# .DESCRIPTION
#     Argument completion can be extended without needing to do any
#     parsing in many cases. By registering a handler for specific
#     commands and/or parameters, PowerShell will call the handler
#     when appropriate.
#
#     There are 2 kinds of extensions - native and PowerShell. Native
#     refers to commands external to PowerShell, e.g. net.exe. PowerShell
#     completion covers any functions, scripts, or cmdlets where PowerShell
#     can determine the correct parameter being completed.
#
#     When registering a native handler, you must specify the CommandName
#     parameter. The CommandName is typically specified without any path
#     or extension. If specifying a path and/or an extension, completion
#     will only work when the command is specified that way when requesting
#     completion.
#
#     When registering a PowerShell handler, you must specify the
#     ParameterName parameter. The CommandName is optional - PowerShell will
#     first try to find a handler based on the command and parameter, but
#     if none is found, then it will try just the parameter name. This way,
#     you could specify a handler for all commands that have a specific
#     parameter.
#
#     A handler needs to return instances of
#     System.Management.Automation.CompletionResult.
#
#     A native handler is passed 2 parameters:
#
#         param($wordToComplete, $commandAst)
#
#     $wordToComplete  - The argument being completed, possibly an empty string
#     $commandAst      - The ast of the command being completed.
#
#     A PowerShell handler is passed 5 parameters:
#
#         param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
#
#     $commandName        - The command name
#     $parameterName      - The parameter name
#     $wordToComplete     - The argument being completed, possibly an empty string
#     $commandAst         - The parsed representation of the command being completed.
#     $fakeBoundParameter - Like $PSBoundParameters, contains values for some of the parameters.
#                           Certain values are not included, this does not mean a parameter was
#                           not specified, just that getting the value could have had unintended
#                           side effects, so no value was computed.
#
# .PARAMETER ParameterName
#     The name of the parameter that the Completion parameter supports.
#     This parameter is not supported for native completion and is
#     mandatory for script completion.
#
# .PARAMETER CommandName
#     The name of the command that the Completion parameter supports.
#     This parameter is mandatory for native completion and is optional
#     for script completion.
#
# .PARAMETER Completion
#     A ScriptBlock that returns instances of CompletionResult. For
#     native completion, the script block parameters are
#
#         param($wordToComplete, $commandAst)
#
#     For script completion, the parameters are:
#
#         param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
#
# .PARAMETER Description
#     A description of how the completion can be used.
#
function Register-ArgumentCompleter
{
    [CmdletBinding(DefaultParameterSetName="PowerShellSet")]
    param(
        [Parameter(ParameterSetName="NativeSet", Mandatory)]
        [Parameter(ParameterSetName="PowerShellSet")]
        [string[]]$CommandName = "",

        [Parameter(ParameterSetName="PowerShellSet", Mandatory)]
        [string]$ParameterName = "",          

        [Parameter(Mandatory)]
        [scriptblock]$ScriptBlock,

        [string]$Description,

        [Parameter(ParameterSetName="NativeSet")]
        [switch]$Native)

    if (!$Description)
    {
        # See if the script block is really a function, if so, use the function name.
        $fnDefn = $ScriptBlock.Ast.Parent -as [System.Management.Automation.Language.FunctionDefinitionAst]
        $Description = if ($fnDefn -ne $null) { $fnDefn.Name } else { "" }
    }

    foreach ($command in $CommandName)
    {
        if ($command -and $ParameterName)
        {
            $command += ":"
        }

        $key = if ($Native) { 'NativeArgumentCompleters' } else { 'CustomArgumentCompleters' }
        $script:options[$key]["${command}${ParameterName}"] = $ScriptBlock

        $script:descriptions["${command}${ParameterName}$Native"] = $Description
    }
}

#############################################################################
#
# .SYNOPSIS
#     Load argument completers from all loaded modules and scripts in
#     $env:PSArgumentCompleterPath, and optionally searches unloaded
#     modules as well.
#
# .DESCRIPTION
#
#     This function automatically loads argument completers when the module
#     TabExpansion++ is loaded. This function can be used to update argument
#     completers that may have been updated after TabExpansion++ was loaded.
#
# .PARAMETER AsJob
#
#     Update should happen in the background.
#
function Update-ArgumentCompleter
{
    param([switch]$AsJob)

    $scriptBlock = {
        param([System.Collections.Concurrent.ConcurrentQueue[object]]$backgroundResultsQueue)

        $modulePaths = $env:PSModulePath -split ';'
        foreach ($dir in $modulePaths)
        {
            Get-ChildItem $dir\*\*.ps1,$dir\*\*.psm1 | LoadArgumentCompleters -backgroundResultsQueue $backgroundResultsQueue
        }

        foreach ($dir in ($env:PSArgumentCompleterPath -split ';'))
        {
            Get-ChildItem $dir\*.ps1,$dir\*.psm1 | LoadArgumentCompleters -backgroundResultsQueue $backgroundResultsQueue
        }
    }

    if (!$AsJob)
    {
        & $scriptBlock $backgroundResultsQueue
        Flush-BackgroundResultsQueue
    }
    else
    {
        $ps = [powershell]::Create()
        $null = $ps.AddScript($function:LoadArgumentCompleters.Ast.Extent.Text).Invoke()
        $ps.Commands.Clear()
        $null = $ps.AddScript(${function:Get-CommandWithParameter}.Ast.Extent.Text).Invoke()
        $ps.Commands.Clear()
        $null = $ps.AddScript($scriptBlock).
            AddParameter('backgroundResultsQueue', $backgroundResultsQueue).BeginInvoke()
        # We aren't expecting any results back, so we can ignore the IAsyncResult and
        # just let it get collected eventually.
    }
}

#############################################################################
#
# .SYNOPSIS
#
function Get-ArgumentCompleter
{
    function WriteCompleters
    {
        function WriteCompleter($command, $parameter, $native, $scriptblock)
        {
            $c = $command
            if ($command -and $parameter) { $c += ':' }
            $description = $descriptions["${c}${parameter}${native}"]
            $completer = [pscustomobject]@{
                Command = $command
                Parameter = $parameter
                Native = $native
                Description = $description
                ScriptBlock = $scriptblock
            }
            $completer.PSTypeNames.Add('TabExpansion++.ArgumentCompleter')
            Write-Output $completer
        }
    
        foreach ($pair in $options.CustomArgumentCompleters.GetEnumerator())
        {
            if ($pair.Key -match '^(.*):(.*)$')
            {
                $command = $matches[1]
                $parameter = $matches[2]
            }
            else
            {
                $parameter = $pair.Key
                $command = ""
            }

            WriteCompleter $command $parameter $false $pair.Value
        }

        foreach ($pair in $options.NativeArgumentCompleters.GetEnumerator())
        {
            WriteCompleter $pair.Key '' $true $pair.Value
        }
    }

    Flush-BackgroundResultsQueue
    WriteCompleters | Sort -Property Native,Parameter,Command
}

#############################################################################
#
# .SYNOPSIS
#     Register a ScriptBlock to perform argument completion for a
#     given command or parameter.
#
# .DESCRIPTION
#
# .PARAMETER Option
#
#     The name of the option.
#
# .PARAMETER Value
#
#     The value to set for Option. Typically this will be $true.
#
function Set-TabExpansionOption
{
    param(
        [ValidateSet('ExcludeHiddenFiles', 'RelativePaths', 'LiteralPaths', 'IgnoreHiddenShares')]
        [string]
        $Option,

        [object]
        $Value)
    
    $script:options[$option] = $value
}

#endregion Exported functions

#region Internal utility functions

#############################################################################
#
filter LoadArgumentCompleters
{
    param([Parameter(ValueFromPipeline=$true)]
          [System.IO.FileInfo]$file,

          [System.Collections.Concurrent.ConcurrentQueue[object]]          
          $backgroundResultsQueue)

    if (!(Test-Path $file.FullName))
    {
        return
    }

    $parseErrors = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$null, [ref]$parseErrors)
    if ($parseErrors.Length -gt 0)
    {
        return
    }

    $paramAsts = $ast.FindAll({
        param($ast)
        return $ast -is [System.Management.Automation.Language.ParamBlockAst]}, $true)

    function ForEach-FunctionWithAttribute
    {
        param($paramBlocks, [type]$type, [scriptblock]$scriptblock)

        foreach ($paramBlock in $paramBlocks)
        {
            foreach ($attributeAst in $paramBlock.Attributes)
            {
                if ($attributeAst.TypeName.GetReflectionAttributeType() -eq $type)
                {                    
                    & $scriptBlock $paramBlock.Parent.GetScriptBlock()
                    # There may be more than one matching attribute, but we don't care
                    # here - the called script block needs to handle it as appropriate.
                    break;
                }
            }
        }
    }

    ForEach-FunctionWithAttribute $paramAsts ([ArgumentCompleterAttribute]) {
        param($scriptBlock)

        $registerParams = @{
            ScriptBlock = $scriptBlock
        }

        # Multiple ArgumentCompleter attributes are supported
        $attrInsts = $scriptBlock.Attributes | Where-Object { $_ -is [ArgumentCompleterAttribute] }
        foreach ($attrInst in $attrInsts)
        {
            # Review - use the function name as the description if no description is provided?
            if ($attrInst.Description)
            {
                $registerParams.Description = $attrInst.Description
            }
            foreach ($c in $attrInst.Command)
            {                
                if ($c -is [ScriptBlock])
                {
                    $registerParams.CommandName = & $c | % { [string]$_ }
                }
                else
                {
                    $registerParams.CommandName = [string]$c
                }
                if ($attrInst.Native)
                {
                    $registerParams.Native = $true
                }
                elseif ($null -ne $registerParams.CommandName)
                {
                    $registerParams.ParameterName = $attrInst.Parameter
                }
                $backgroundResultsQueue.Enqueue([pscustomobject]@{
                    ArgumentCompleter = $true
                    Value = $registerParams})
            }            
        }
    }

    # Call any initialization functions that are defined in the script.
    ForEach-FunctionWithAttribute $paramAsts ([InitializeArgumentCompleterAttribute]) {
        param($scriptBlock)
        $attrInsts = $scriptBlock.Attributes | Where-Object { $_ -is [InitializeArgumentCompleterAttribute] }
        $result = & $scriptBlock
        foreach ($attrInst in $attrInsts)
        {
            $setCompletionPrivateDataParams = @{
                Key = $attrInst.Key
                Value = $result
            }
            $backgroundResultsQueue.Enqueue([pscustomobject]@{
                InitializationData = $true
                Value = $setCompletionPrivateDataParams})
        }
    }
}

#############################################################################
#
# Remove all items from the background results queue, applying the
# appropriate action.
#
function Flush-BackgroundResultsQueue
{
    $item = $null
    while ($backgroundResultsQueue.TryDequeue([ref]$item))
    {
        $parameters = $item.Value
        if ($item.ArgumentCompleter)
        {
            if ($null -eq $parameters.CommandName)
            {
                if ($global:foo -eq 'foo') { $global:foo = $null; $host.EnterNestedPrompt() }
            }
            Register-ArgumentCompleter @parameters 
        }
        elseif ($item.InitializationData)
        {
            Set-CompletionPrivateData @parameters
        }
    }
}

#############################################################################
#
# This function checks if an attribute argument's name can be completed.
# For example:
#     [Parameter(<TAB>
#     [Parameter(Po<TAB>
#     [CmdletBinding(DefaultPa<TAB>
#
function TryAttributeArgumentCompletion
{
    param(
        [System.Management.Automation.Language.Ast]$ast,
        [int]$offset
    )

    $results = @()
    $matchIndex = -1

    try
    {
        # We want to find any NamedAttributeArgumentAst objects where the Ast extent includes $offset
        $offsetInExtentPredicate = {
            param($ast)
            return $offset -gt $ast.Extent.StartOffset -and
                   $offset -le $ast.Extent.EndOffset
        }
        $asts = $ast.FindAll($offsetInExtentPredicate, $true)

        $attributeType = $null
        $attributeArgumentName = ""
        $replacementIndex = $offset
        $replacementLength = 0

        $attributeArg = $asts | Where-Object { $_ -is [System.Management.Automation.Language.NamedAttributeArgumentAst] } | Select-Object -First 1
        if ($null -ne $attributeArg)
        {
            $attributeAst = [System.Management.Automation.Language.AttributeAst]$attributeArg.Parent
            $attributeType = $attributeAst.TypeName.GetReflectionAttributeType()
            $attributeArgumentName = $attributeArg.ArgumentName
            $replacementIndex = $attributeArg.Extent.StartOffset
            $replacementLength = $attributeArg.ArgumentName.Length
        }
        else
        {
            $attributeAst = $asts | Where-Object { $_ -is [System.Management.Automation.Language.AttributeAst] } | Select-Object -First 1
            if ($null -ne $attributeAst)
            {
                $attributeType = $attributeAst.TypeName.GetReflectionAttributeType()
            }
        }

        if ($null -ne $attributeType)
        {
            $results = $attributeType.GetProperties('Public,Instance') |
                Where-Object {
                    # Ignore TypeId (all attributes inherit it)
                    $_.Name -like "$attributeArgumentName*" -and $_.Name -ne 'TypeId' } |
                Sort-Object -Property Name |
                ForEach-Object {
                    $propType = [Microsoft.PowerShell.ToStringCodeMethods]::Type($_.PropertyType)
                    $propName = $_.Name
                    New-CompletionResult $propName -ToolTip "$propType $propName" -CompletionResultType Property
                }

            return [PSCustomObject]@{
                Results = $results
                ReplacementIndex = $replacementIndex
                ReplacementLength = $replacementLength
            }
        }
    }
    catch {}
}

#endregion Internal utility functions

#############################################################################
#
# This function is partly a copy of the V3 TabExpansion2, adding a few
# capabilities such as completing attribute arguments and excluding hidden
# files from results.
# 
function global:TabExpansion2
{
    [CmdletBinding(DefaultParameterSetName = 'ScriptInputSet')]
    Param(
        [Parameter(ParameterSetName = 'ScriptInputSet', Mandatory = $true, Position = 0)]
        [string] $inputScript,
    
        [Parameter(ParameterSetName = 'ScriptInputSet', Mandatory = $true, Position = 1)]
        [int] $cursorColumn,

        [Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 0)]
        [System.Management.Automation.Language.Ast] $ast,

        [Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 1)]
        [System.Management.Automation.Language.Token[]] $tokens,

        [Parameter(ParameterSetName = 'AstInputSet', Mandatory = $true, Position = 2)]
        [System.Management.Automation.Language.IScriptPosition] $positionOfCursor,
    
        [Parameter(ParameterSetName = 'ScriptInputSet', Position = 2)]
        [Parameter(ParameterSetName = 'AstInputSet', Position = 3)]
        [Hashtable] $options = $null
    )

    if ($null -ne $options)
    {
        $options += $script:options
    }
    else
    {
        $options = $script:options
    }

    Flush-BackgroundResultsQueue

    if ($psCmdlet.ParameterSetName -eq 'ScriptInputSet')
    {
        $results = [System.Management.Automation.CommandCompletion]::CompleteInput(
            <#inputScript#>  $inputScript,
            <#cursorColumn#> $cursorColumn,
            <#options#>      $options)
    }
    else
    {
        $results = [System.Management.Automation.CommandCompletion]::CompleteInput(
            <#ast#>              $ast,
            <#tokens#>           $tokens,
            <#positionOfCursor#> $positionOfCursor,
            <#options#>          $options)
    }

    if ($results.CompletionMatches.Count -eq 0)
    {
        # Built-in didn't succeed, try our own completions here.
        if ($psCmdlet.ParameterSetName -eq 'ScriptInputSet')
        {
            $ast = [System.Management.Automation.Language.Parser]::ParseInput($inputScript, [ref]$tokens, [ref]$null)
        }
        else
        {
            $cursorColumn = $positionOfCursor.Offset
        }

        $attributeResults = TryAttributeArgumentCompletion $ast $cursorColumn
        if ($null -ne $attributeResults)
        {
            $results.ReplacementIndex = $attributeResults.ReplacementIndex
            $results.ReplacementLength = $attributeResults.ReplacementLength
            if ($results.CompletionMatches.IsReadOnly)
            {
                # Workaround where PowerShell returns a readonly collection that we need to add to.
                $collection = new-object System.Collections.ObjectModel.Collection[System.Management.Automation.CompletionResult]
                $results.GetType().GetProperty('CompletionMatches').SetValue($results, $collection)
            }
            $attributeResults.Results | ForEach-Object {
                $results.CompletionMatches.Add($_) }
        }
    }

    if ($options.ExcludeHiddenFiles)
    {
        foreach ($result in @($results.CompletionMatches))
        {
            if ($result.ResultType -eq [System.Management.Automation.CompletionResultType]::ProviderItem -or
                $result.ResultType -eq [System.Management.Automation.CompletionResultType]::ProviderContainer)
            {
                try
                {
                    $item = Get-Item -LiteralPath $result.CompletionText -ErrorAction Stop
                }
                catch
                {
                    # If Get-Item w/o -Force fails, it is probably hidden, so exclude the result
                    $null = $results.CompletionMatches.Remove($result)
                }
            }
        }
    }

    return $results
}


#############################################################################
#
# Main
#

Add-Type @"
using System;

[AttributeUsage(AttributeTargets.Method)]
public class ArgumentCompleterAttribute : Attribute
{
    // Command can be:
    //   * a string
    //   * a script block that generates strings or CommandInfo
    //   * an array of strings and/or script blocks
    public object Command { get; set; }

    // The command is a native command, in which case Parameter is ignored.
    public bool Native { get; set; }

    // The parameter(s) this method completes
    public string Parameter { get; set; }

    // An optional string displayed when querying what completers
    // are registered.
    public string Description { get; set; }
}

[AttributeUsage(AttributeTargets.Method)]
public class InitializeArgumentCompleterAttribute : Attribute
{
    public InitializeArgumentCompleterAttribute(string Key)
    {
        this.Key = Key;
    }

    public string Key { get; set; }
}
"@

# Custom completions are saved in this hashtable
$options = @{
    CustomArgumentCompleters = @{}
    NativeArgumentCompleters = @{}
}
# Descriptions for the above completions saved in this hashtable
$descriptions = @{}
# And private data for the above completions cached in this hashtable
$completionPrivateData = @{}

# Define the default display properties for the objects returned by Get-ArgumentCompleter
$typeData = new-object System.Management.Automation.Runspaces.TypeData "TabExpansion++.ArgumentCompleter"
[string[]]$properties = echo Command Parameter Native Description
$propertySetData = new-object System.Management.Automation.Runspaces.PropertySetData -ArgumentList (,$properties)
$typeData.DefaultDisplayPropertySet = $propertySetData
Update-TypeData -TypeData $typeData -Force

# Load completers for loaded modules now.  This is done in the background
# because searching all modules is slow and we don't want to block startup.
$backgroundResultsQueue = new-object System.Collections.Concurrent.ConcurrentQueue[object]
Update-ArgumentCompleter -AsJob

Export-ModuleMember Get-ArgumentCompleter, Register-ArgumentCompleter,
                    Set-TabExpansionOption, Update-ArgumentCompleter
