# ARGUMENT COMPLETER FUNCTIONS #################################################

# DFSR REPLICATION GROUP
function DFSR_GroupNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    DFSR\Get-DfsReplicationGroup -GroupName "$wordToComplete*" |
        Sort-Object -Property GroupName |
        ForEach-Object {
            $Tooltip = "Id: {0} - State: {1} `nDescription: {2}" -f $_.Identifier,$_.State,$_.Description
            New-CompletionResult -CompletionText $_.GroupName -ToolTip $Tooltip
        }
}

# ARGUMENT COMPLETER REGISTRATION ##############################################

# DFSR REPLICATION GROUP
Register-ArgumentCompleter `
    -Command ('Add-DfsrConnection','Add-DfsrMember','ConvertFrom-DfsrGuid','Get-DfsrBacklog','Get-DfsrConnection','Get-DfsrConnectionSchedule','Get-DfsReplicatedFolder','Get-DfsReplicationGroup','Get-DfsrGroupSchedule','Get-DfsrMember','Get-DfsrMembership','New-DfsReplicatedFolder','New-DfsReplicationGroup','Remove-DfsrConnection','Remove-DfsReplicatedFolder','Remove-DfsReplicationGroup','Remove-DfsrMember','Remove-DfsrPropagationTestFile','Set-DfsrConnection','Set-DfsrConnectionSchedule','Set-DfsReplicatedFolder','Set-DfsReplicationGroup','Set-DfsrGroupSchedule','Set-DfsrMember','Set-DfsrMembership','Start-DfsrPropagationTest','Suspend-DfsReplicationGroup','Sync-DfsReplicationGroup','Write-DfsrHealthReport','Write-DfsrPropagationReport') `
    -Parameter 'GroupName' `
    -Description 'Complete DFRS Replicaion Group names, for example: Get-DfsReplicationGroup -GroupName <TAB>' `
    -ScriptBlock $function:DFSR_GroupNameArgumentCompletion
