
param(
    [Parameter(ValueFromPipelineByPropertyName = $true, Mandatory, Position = 0)]
    [Alias("PSPath")]
    [string]$Path,
    
    [string]$OutputPath
)

process
{
$Path = (Resolve-Path $Path).ProviderPath
if ($null -eq $PSBoundParameters['OutputPath'])
{
    $OutputPath = ((Split-Path -Parent $Path) + "\\Transformed_" + (Split-Path -Leaf $Path))
}
$ast = [System.Management.Automation.Language.Parser]::ParseFile($Path, [ref]$null, [ref]$null)

$copyFrom = 0
$fullText = $ast.Extent.Text
$sb = New-Object System.Text.StringBuilder $fullText.Length

$registrations = @()

foreach ($fnDefn in $ast.FindAll({$args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst]}, $false))
{
    if (!$fnDefn.Body.ParamBlock) { continue }
    $attrs = $fnDefn.Body.ParamBlock.Attributes

    foreach ($attr in $attrs)
    {
        if ($attr.TypeName.Name -eq 'ArgumentCompleter')
        {
            $copyTo = $attr.Extent.StartOffset
            # Assume the attribute is indented, but we don't want that indentation
            while ($fullText[$copyTo - 1] -eq ' ' -or $fullText[$copyTo - 1] -eq "`t")
            {
                $copyTo--
            }
            $null = $sb.Append($fullText.Substring($copyFrom, $copyTo - $copyFrom))
            $copyFrom = $attr.Extent.EndOffset

            # We also want to skip the typical blank line after the attribute,
            # so first skip trailing whitespace.
            while ($fullText[$copyFrom] -eq ' ' -or $fullText[$copyFrom] -eq "`t")
            {
                $copyFrom++
            }
            # Then skip newline(s)
            while ($fullText[$copyFrom] -eq "`n" -or $fullText[$copyFrom] -eq "`r")
            {
                $copyFrom++
            }

            $registrations += [pscustomobject]@{
                    FunctionName = $fnDefn.Name
                    Attribute = $attr
            }
        }
    }

    $null = $sb.Append($fullText.Substring($copyFrom, $fnDefn.Extent.EndOffset - $copyFrom))
    $copyFrom = $fnDefn.Extent.EndOffset
}

foreach ($registration in $registrations)
{
    $functionName = $registration.FunctionName
    $isNative = $false
    $description = $null
    $parameter = $null
    $command = $null
    foreach ($namedArgument in $registration.Attribute.NamedArguments)
    {
        switch ($namedArgument.ArgumentName)
        {
        'Native'      { $isNative = $true; break }
        'Description' { $description = $namedArgument.Argument.Extent.Text; break }
        'Parameter'   { $parameter = $namedArgument.Argument.Extent.Text; break }
        'Command'
            {
            $argument = $namedArgument.Argument
            if ($argument -is [System.Management.Automation.Language.ScriptBlockExpressionAst])
            {
                $command = $argument.Extent.Text
                $command = '(' + $command.Substring(1, $command.Length - 2) + ')'
            }
            else
            {
                $command = $argument.Extent.Text
            }
            break
            }
        }
    }

$null = $sb.Append(@"



Register-ArgumentCompleter ``
    -Command $command ``
    $(if ($isNative) { "-Native" } else { "-Parameter $parameter" }) ``
    -Description $description ``
    -ScriptBlock `$function:$functionName
"@)
    }

$sb.ToString() | Out-File -Encoding utf8 $OutputPath
}
