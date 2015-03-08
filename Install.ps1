
param([string]$InstallDirectory)

$fileList = @(
    'about_TabExpansion++.help.txt',
    'CimCmdlets.ArgumentCompleters.ps1',
    'Dism.ArgumentCompleters.ps1',
    'DnsClient.ArgumentCompleters.ps1',
    'Hyper-V.ArgumentCompleters.ps1',
    'License.txt',
    'Microsoft.PowerShell.Core.ArgumentCompleters.ps1',
    'Microsoft.PowerShell.Diagnostics.ArgumentCompleters.ps1',
    'Microsoft.PowerShell.Management.ArgumentCompleters.ps1',
    'Microsoft.PowerShell.Utility.ArgumentCompleters.ps1',
    'NetSecurity.ArgumentCompleters.ps1',
    'NetTCPIP.ArgumentCompleters.ps1',
    'NetAdapter.ArgumentCompleters.ps1',
    'PowerShellWebAccess.ArgumentCompleters.ps1',
    'PrintManagement.ArgumentCompleters.ps1',
    'ScheduledTasks.ArgumentCompleters.ps1',
    'SmbShare.ArgumentCompleters.ps1',
    'Storage.ArgumentCompleters.ps1',
    'TabExpansion++.ArgumentCompleters.ps1',
    'TabExpansion++.psd1',
    'TabExpansion++.psm1',
    'Wdac.ArgumentCompleters.ps1',
    'WindowsExe.ArgumentCompleters.ps1',
    'WindowsExe.Messages.psd1',
    'Snippets/ArgumentCompleterFunction.snippets.ps1xml'
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

    $InstallDirectory = Join-Path -Path $personalModules -ChildPath TabExpansion++
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

