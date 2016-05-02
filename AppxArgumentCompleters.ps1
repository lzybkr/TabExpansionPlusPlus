# ARGUMENT COMPLETER FUNCTIONS #################################################

# APPX Package
function Appx_PackageNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Appx\Get-AppxPackage -Name "$wordToComplete*" |
        Sort-Object -Property Name |
        ForEach-Object {
            $ToolTip = "Name: {0} - Version: {1}" -f $_.Name,$_.Version
            New-CompletionResult -CompletionText $_.Name -ToolTip $ToolTip
        }
}

function Appx_PackagePublisherArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Appx\Get-AppxPackage -Publisher "$wordToComplete*" |
        Select-Object -Property Publisher -Unique |
        Sort-Object -Property Publisher |
        ForEach-Object {
            $ToolTip = "Publisher: {0}" -f $_.Publisher
            New-CompletionResult -CompletionText $_.Publisher -ToolTip $ToolTip
        }
}

function Appx_PathArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-CompletionWithExtension $lastWord ('.appx')
}

# APPX Package Manifest
function Appx_PackageManifestNameArgumentCompletion
{
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Appx\Get-AppxPackage |
        Where-Object {$_.PackageFullName -like "$wordToComplete*"} |
        Sort-Object -Property PackageFullName |
        ForEach-Object {
            $ToolTip = "Name: {0} - Version: {1} - Full Name: {2}" -f $_.Name,$_.Version,$_.PackageFullName
            New-CompletionResult -CompletionText $_.PackageFullName -ToolTip $ToolTip
        }
}

################################################################################

# APPX Package

Register-ArgumentCompleter `
    -Command ('Get-AppxPackage') `
    -Parameter 'Name' `
    -Description 'Complete Appx names, for example: Get-AppxPackage -Name <TAB>' `
    -ScriptBlock $function:Appx_PackageNameArgumentCompletion

Register-ArgumentCompleter `
    -Command ('Get-AppxPackage') `
    -Parameter 'Publisher' `
    -Description 'Complete Appx names, for example: Get-AppxPackage -Publisher <TAB>' `
    -ScriptBlock $function:Appx_PackagePublisherArgumentCompletion

Register-ArgumentCompleter `
    -Command ('Add-AppxPackage') `
    -Parameter 'Path' `
    -Description 'Complete Appx path names, for example: Add-AppxPackage -Path <TAB>' `
    -ScriptBlock $function:Appx_PathArgumentCompletion

# APPX Package Manifest

Register-ArgumentCompleter `
    -Command ('Get-AppxPackageManifest','Remove-AppxPackage') `
    -Parameter 'Package' `
    -Description 'Complete Appx Package names, for example: Get-AppxPackageManifest -Package <TAB>' `
    -ScriptBlock $function:Appx_PackageManifestNameArgumentCompletion

