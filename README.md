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
1. Make sure the execution policy (Get-ExecutionPolicy) allows scripts to run.
2. Make a directory for the module, e.g.:
```powershell
mkdir ~\Documents\WindowsPowerShell\Modules\TabExpansion++
```
3. Copy the files from this module to the directory you just created, e.g:
```powershell
cp *.ps*1,*.txt ~\Documents\WindowsPowerShell\Modules\TabExpansion++
```
