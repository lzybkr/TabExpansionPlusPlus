# Argument completer by Kurt Roggen [BE] - kurtroggen.be
# PowerShell Direct (Windows 10/Windows Server 2016 HOST running Windows 10/Windows Server 2016 VM)
# Supports cmdlets
# - PSSession cmdlets ('Enter-PSSession','Get-PSSession','New-PSSession','Remove-PSSession','Invoke-Command') for -VMName and -VMId parameters
# - Copy-Item cmdlet (-ToSession, -FromSession)

# ARGUMENT COMPLETER FUNCTIONS #################################################

# PSSESSION using VMName
function PowerShellDirect_VMNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCn = @{}
    $cn = $fakeBoundParameter["ComputerName"]
    if($cn)  { $optionalCn.ComputerName = $cn }

    Hyper-V\Get-VM -Name "$wordToComplete*" @optionalCn |
    Sort-Object |
    ForEach-Object {
        $ToolTip = "Name: {0} - State: {1} - Status: {2} `nID: {3} `nVersion: {4} - Generation: {5} `nvCPU: {6} - vRAM: {7:N0}GB-{8:N0}GB" -f $_.Name,$_.State,$_.Status,$_.Id,$_.Version,$_.Generation,$_.ProcessorCount,($_.MemoryMinimum/1GB),($_.MemoryMaximum/1GB)
        New-CompletionResult -CompletionText $_.Name -ToolTip $ToolTip
    }
}
# PSSESSION using VMId
function PowerShellDirect_VMIdArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $optionalCn = @{}
    $cn = $fakeBoundParameter["ComputerName"]
    if($cn) { $optionalCn.ComputerName = $cn }

    Hyper-V\Get-VM -Name "$wordToComplete*" @optionalCn |
    Sort-Object |
    ForEach-Object {
        $ToolTip = "Name: {0} - State: {1} - Status: {2} `nID: {3} `nVersion: {4} - Generation: {5} `nvCPU: {6} - vRAM: {7:N0}GB-{8:N0}GB" -f $_.Name,$_.State,$_.Status,$_.Id,$_.Version,$_.Generation,$_.ProcessorCount,($_.MemoryMinimum/1GB),($_.MemoryMaximum/1GB)
        New-CompletionResult -CompletionText $_.Id -ToolTip $ToolTip -ListItemText $_.Name
    }
}
# PSSESSION using ConfigurationName
function PowerShellDirect_ConfigurationArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    if (-not $fakeBoundParameter['ComputerName'])
    {
        Get-PSSessionConfiguration -Name "$wordToComplete*" |
        Sort-Object -Property Name |
        ForEach-Object {
            New-CompletionResult -CompletionText $_.Name -ToolTip $_.Name
        }
    }
}

# COPY-ITEM using PSSESSION
function PowerShellDirect_SessionArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-PSSession -Name "$wordToComplete*" |
    Sort-Object -Property Name |
    ForEach-Object {
        $ToolTip = "Name: {0} - State: {1} - ID: {2}" -f $_.Name,$_.State,$_.Id
        New-CompletionResult -CompletionText $_.Name -ToolTip $ToolTip
    }
}

# ARGUMENT COMPLETER REGISTRATION ##############################################

# PSSESSION VMNAME
Register-ArgumentCompleter `
    -Command ('Enter-PSSession','Get-PSSession','New-PSSession','Remove-PSSession','Invoke-Command') `
    -Parameter 'VMName' `
    -Description 'Complete VM names, for example: Enter-PSSession -VMName <TAB>' `
    -ScriptBlock $function:PowerShellDirect_VMNameArgumentCompletion
# PSSESSION VMID
Register-ArgumentCompleter `
    -Command ('Enter-PSSession','Get-PSSession','New-PSSession','Remove-PSSession','Invoke-Command') `
    -Parameter 'VMId' `
    -Description 'Complete VM names, for example: Enter-PSSession -VMId <TAB>' `
    -ScriptBlock $function:PowerShellDirect_VMIdArgumentCompletion
# PSSESSION CONFIGURATIONAME
Register-ArgumentCompleter `
    -Command ('Enter-PSSession','Get-PSSession','New-PSSession','Remove-PSSession','Invoke-Command') `
    -Parameter 'ConfigurationName' `
    -Description 'Complete PS Session Configuration names, for example: Enter-PSSession -VMName <VM> -ConfiguratioName <TAB>' `
    -ScriptBlock $function:PowerShellDirect_ConfigurationArgumentCompletion
# COPY-ITEM using PSSESSION TOSESSION
Register-ArgumentCompleter `
    -Command ('Copy-Item') `
    -Parameter 'ToSession' `
    -Description 'Complete PSSession names, for example: Copy-Item -ToSession <TAB>' `
    -ScriptBlock $function:PowerShellDirect_SessionArgumentCompletion
# COPY-ITEM using PSSESSION FROMSESSION
Register-ArgumentCompleter `
    -Command ('Copy-Item') `
    -Parameter 'FromSession' `
    -Description 'Complete PSSession names, for example: Copy-Item -FromSession <TAB>' `
    -ScriptBlock $function:PowerShellDirect_SessionArgumentCompletion
