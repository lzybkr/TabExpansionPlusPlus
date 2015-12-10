#
# .SYNOPSIS
#
#    Auto-complete the -Location parameter value for Azure PowerShell cmdlets. (version 1.0)
#
# .NOTES
#    
#    Created by Stuart Leeks
#    http://blogs.msdn.com/stuartleeks
#    http://twitter.com/stuartleeks
#
function AzureGeneral_LocationCompleter
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)


    ### Attempt to read Azure location details from the cache
    $CacheKey = 'AzureGeneral_LocationCache'
    $LocationCache = Get-CompletionPrivateData -Key $CacheKey

    ### If there is a valid cache for the Azure locations, then go ahead and return them immediately
    if ($LocationCache -and (Get-Date) -gt $LocationCache.ExpirationTime) {
        $ItemList = $LocationCache
    } else {
        ### Create fresh completion results for Azure locations
        $ItemList = Get-AzureRmResourceProvider | Select-Object -ExpandProperty ResourceTypes | Select-Object -ExpandProperty Locations -Unique | Sort-Object | Foreach-Object {
            if($PSItem -ne $null -and $PSItem -ne ""){
                $CompletionResult = @{
                    CompletionText = $PSItem
                    ToolTip = $PSItem
                    ListItemText = $PSItem
                    CompletionResultType = [System.Management.Automation.CompletionResultType]::ParameterValue
                    }
                New-CompletionResult @CompletionResult
            }
        }
        
        # Update the cache for Azure locations
        Set-CompletionPrivateData -Key $CacheKey -Value $ItemList
    }
    
    ### Return the fresh completion results
    $wordToCompleteWildcard = $wordToComplete + "*"

    return $ItemList | Where-Object { ($PSItem.CompletionText -like $wordToCompleteWildcard) -or ($PSItem.ListItemText -like $wordToCompleteWildcard)}
}

Register-ArgumentCompleter `
    -Command ( 'Add-AlertRule', 'Add-AutoscaleSetting', 'Add-AzureRmApiManagementRegion', 'Get-AzureRMAppServicePlan', 'Get-AzureRmBatchSubscriptionQuotas', 'Get-AzureRmHDInsightProperties', 'Get-AzureRmResourceGroup', 'Get-AzureRmResourceProvider', 'Get-AzureRmStreamAnalyticsQuota', 'Get-AzureRmVmExtensionImage', 'Get-AzureRmVMExtensionImageType', 'Get-AzureRmVMImage', 'Get-AzureRmVMImageOffer', 'Get-AzureRmVMImagePublisher', 'Get-AzureRmVMImageSku', 'Get-AzureRmVMSize', 'Get-AzureRmVMUsage', 'Get-AzureRMWebApp', 'New-AzureRmApiManagement', 'New-AzureRmApiManagementVirtualNetwork', 'New-AzureRmApplicationGateway', 'New-AzureRMAppServicePlan', 'New-AzureRmAutomationAccount', 'New-AzureRmAvailabilitySet', 'New-AzureRmBatchAccount', 'New-AzureRmDataFactory', 'New-AzureRmDataLakeAnalyticsAccount', 'New-AzureRmDataLakeStoreAccount', 'New-AzureRmExpressRouteCircuit', 'New-AzureRmHDInsightCluster', 'New-AzureRmKeyVault', 'New-AzureRmLoadBalancer', 'New-AzureRmLocalNetworkGateway', 'New-AzureRmNetworkInterface', 'New-AzureRmNetworkSecurityGroup', 'New-AzureRmOperationalInsightsWorkspace', 'New-AzureRmPublicIpAddress', 'New-AzureRmRedisCache', 'New-AzureRmResource', 'New-AzureRmResourceGroup', 'New-AzureRmRouteTable', 'New-AzureRmSiteRecoveryVault', 'New-AzureRmSqlServer', 'New-AzureRmStorageAccount', 'New-AzureRmVirtualNetwork', 'New-AzureRmVirtualNetworkGateway', 'New-AzureRmVirtualNetworkGatewayConnection', 'New-AzureRmVM', 'New-AzureRmWebApp', 'Remove-AzureRmApiManagementRegion', 'Set-AzureRmVMAccessExtension', 'Set-AzureRmVMCustomScriptExtension', 'Set-AzureRmVMDiagnosticsExtension', 'Set-AzureRmVMDscExtension', 'Set-AzureRmVMExtension', 'Set-AzureRmVMSqlServerExtension', 'Test-AzureRmDnsAvailability', 'Update-AzureRmApiManagementDeployment', 'Update-AzureRmApiManagementRegion') `
    -Parameter 'Location' `
    -Description 'Complete the -Location parameter value for Azure cmdlets: New-AzureRmResourceGroup -Location <TAB>' `
    -ScriptBlock $function:AzureGeneral_LocationCompleter
    

