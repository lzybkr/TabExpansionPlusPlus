## CimCmdlets module Custom Completers ##

#
# .SYNOPSIS
#
#    Complete the -QueryDialect argument to CimCmdlets cmdlets
#
function CimInstance_QueryDialectCompleter
{
    [ArgumentCompleter(
        Parameter = 'QueryDialect',
        Command = {Get-CommandWithParameter -Module CimCmdlets -ParameterName QueryDialect},
        Description = 'Complete the -QueryDialect argument to CimInstance cmdlets:  Get-CimInstance -QueryDialect  -QueryDialect <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Write-Output CQL WQL | Where-Object {$_ -like "$wordToComplete*"} | ForEach-Object {
        New-CompletionResult $_ $_
    }
}


#
# .SYNOPSIS
#
#    Complete the -Property argument to Get-CimInstance
#
function CimInstance_PropertyParameterCompleter
{
    [ArgumentCompleter(
        Parameter = 'Property',
        Command = 'Get-CimInstance',
        Description = 'Complete the -Property argument to CimInstance cmdlets: Get-CimInstance -Class Win32_Process -Property <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $param = @{}
    $ns = $fakeBoundParameter['Namespace']
    $cn = $fakeBoundParameter['ComputerName']
    $cs = $fakeBoundParameter['CimSession']
    $cl = $fakeBoundParameter['ClassName']

    if($ns) {$param.Namespace = $ns}
    if($cn) {$param.ComputerName = $cn}
    if($cs) {$param.CimSession = $cs}
    if($cl) {$param.ClassName = $cl}

    (CimCmdlets\Get-CimClass @param).CimClassProperties.Name | Where-Object {$_ -like "$wordToComplete*"} | Sort-Object | Foreach-Object {
        New-CompletionResult $_ $_
    }
}


#
# .SYNOPSIS
#
#    Complete the -ResultClassName argument to Get-CimAssociatedInstance
#
function CimInstance_CimAssociatedInstanceResultClassNameParameterCompleter
{
    [ArgumentCompleter(
        Parameter = 'ResultClassName',
        Command = 'Get-CimAssociatedInstance',
        Description = 'Complete the -ResultClassName argument to Get-CimAssociatedInstance: $disk = Get-CimInstance -Class Win32_LogicalDisk -Filter ''DriveType=3''; Get-CimAssociatedInstance -CimInstance $disk -ResultClassName <TAB>'
    )]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $param = @{}
    $ns = $fakeBoundParameter['Namespace']
    $cn = $fakeBoundParameter['ComputerName']
    $ci = $fakeBoundParameter['CimInstance']
    $io = $fakeBoundParameter['InputObject']

    if($ns) {$param.Namespace = $ns}
    if($cn) {$param.ComputerName = $cn}
    if($ci) {$param.CimInstance = $ci}
    if($io) {$param.InputObject = $io}

    (CimCmdlets\Get-CimAssociatedInstance @param).CimClass.CimClassName | Where-Object {$_ -like "$wordToComplete*"} | Sort-Object | Foreach-Object {
        New-CompletionResult $_ $_
    }
}

