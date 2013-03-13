TabExpansion++
==============
V3 of PowerShell has excellent support for tab expansion and Intellisense, but it is missing some useful features. This module addresses some of those shortcomings.

TabExpansion++ adds support for the following:

* Easily add custom argument completion.
* Complete attribute argument names, e.g.
        [CmdletBinding(Def<TAB>
        -or-
        [Parameter(<TAB>
* Exclude hidden files from results.
* Easily set options like 'IgnoreHiddenShares'.

In addition to making it simple to add custom argument completion, TabExpansion++ provides many useful custom argument completers that can also serve as good examples of how to add your own.

Say you wanted to support completing the argument to -Verb parameter of Get-Command, e.g.:

    Get-Command -Verb <TAB>

You could do so by adding the following function to your profile:

```powershell
function VerbCompletion
{
    [ArgumentCompleter(Parameter = 'Verb', Command = 'Get-Command')]
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-Verb "$wordToComplete*" |
        ForEach-Object {
            New-CompletionResult $_.Verb ("Group: " + $_.Group)
        }   
}
```

Usage
-----
Assuming you've installed the module somewhere in your module path, just import the module in your profile, e.g.:

```powershell
Import-Module TabExpansion++
```

Installing
----------
To install in your personal modules folder (e.g. ~\Documents\WindowsPowerShell\Modules), run:

```powershell
iex (new-object System.Net.WebClient).DownloadString('https://raw.github.com/lzybkr/TabExpansionPlusPlus/master/Install.ps1')
```

If you want to install elsewhere, you can download Install.ps1 (using the URL above) and run it, passing in the directory you want to install.

If you have PsGet, you can run:

```powershell
Install-Module -ModuleUrl https://github.com/lzybkr/TabExpansionPlusPlus/zipball/master/ -ModuleName TabExpansion++ -Type ZIP
```
