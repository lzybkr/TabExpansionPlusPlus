
param([string]$InstallDirectory)

$fileList = @(
### Base module files
    'TabExpansionPlus.psm1'
    'TabExpansionPlusPlus.psd1'
    'about_TabExpansionPlusPlus.help.txt'
    'License.txt'
    'Convert-ArgumentCompleterRegistrationScript.ps1'

### Completers
    'Appx.ArgumentCompleters.ps1'
    'BitsTransfer.ArgumentCompleters.ps1'
    'CimCmdlets.ArgumentCompleters.ps1'
    'DhcpServer.ArgumentCompleters.ps1'
    'Dism.ArgumentCompleters.ps1'
    'DFSR.ArgumentCompleters.ps1'
    'DnsClient.ArgumentCompleters.ps1'
    'DnsServer.ArgumentCompleters.ps1'
    'FailoverClusters.ArgumentCompleters.ps1'
    'GroupPolicy.ArgumentCompleters.ps1'
    'Hexo.ArgumentCompleters.ps1'
    'Hyper-V.ArgumentCompleters.ps1'
    'ISE.ArgumentCompleters.ps1'
    'Microsoft.Azure.ArgumentCompleters.ps1'
    'Microsoft.AzureRm.ArgumentCompleters.ps1'
    'Microsoft.PowerShell.Core.ArgumentCompleters.ps1'
    'Microsoft.PowerShell.Diagnostics.ArgumentCompleters.ps1'
    'Microsoft.PowerShell.LocalAccounts.ArgumentCompleters.ps1'    
    'Microsoft.PowerShell.Management.ArgumentCompleters.ps1'
    'Microsoft.PowerShell.Utility.ArgumentCompleters.ps1'
    'NetAdapter.ArgumentCompleters.ps1'
    'NetLbfo.ArgumentCompleters.ps1'
    'NetQos.ArgumentCompleters.ps1'
    'NetSecurity.ArgumentCompleters.ps1'
    'NetTCPIP.ArgumentCompleters.ps1'
    'Pnpdevice.ArgumentCompleters.ps1'
    'PowerShellDirect.ArgumentCompleters.ps1'
    'PowerShellWebAccess.ArgumentCompleters.ps1'
    'PrintManagement.ArgumentCompleters.ps1'
    'RobocopyExe.ArgumentCompleters.ps1'
    'ScheduledTasks.ArgumentCompleters.ps1'
    'SmbShare.ArgumentCompleters.ps1'
    'Storage.ArgumentCompleters.ps1'
    'TabExpansionPlusPlus.ArgumentCompleters.ps1'
    'Wdac.ArgumentCompleters.ps1'
    'WindowsExe.ArgumentCompleters.ps1'
    'WindowsExe.Messages.psd1'
)


if ('' -eq $InstallDirectory)
{
    $personalModules = Join-Path -Path ([Environment]::GetFolderPath('MyDocuments')) -ChildPath WindowsPowerShell\Modules
    if (($env:PSModulePath -split ';') -notcontains $personalModules)
    {
        Write-Warning "$personalModules is not in `$env:PSModulePath"
    }

    if (!(Test-Path $personalModules))
    {
        Write-Error "$personalModules does not exist"
    }

    $InstallDirectory = Join-Path -Path $personalModules -ChildPath TabExpansionPlusPlus
}

if (!(Test-Path $InstallDirectory))
{
    $null = mkdir $InstallDirectory
    $null = mkdir $InstallDirectory\Snippets
}

$wc = new-object System.Net.WebClient
$fileList | ForEach-Object {
    $wc.DownloadFile("https://raw.github.com/lzybkr/TabExpansionPlusPlus/master/$_",
                     "$installDirectory\$_")
    }

