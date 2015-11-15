TabExpansionPlusPlus
====================
Starting with PowerShell version 3.0, there is excellent support for tab expansion and Intellisense, but it is missing some useful features. This module addresses some of those shortcomings.

TabExpansionPlusPlus adds support for the following:

* Easily add custom argument completion.
* Complete attribute argument names, e.g.
        [CmdletBinding(Def<TAB>
        -or-
        [Parameter(<TAB>
* Exclude hidden files from results.
* Easily set options like 'IgnoreHiddenShares'.

In addition to making it simple to add custom argument completion, TabExpansionPlusPlus provides many useful custom argument completers "out of box" that can also serve as good examples of how to add your own.

Usage
-----
Assuming you've installed the module somewhere in your module path, just import the module in your profile, e.g.:

```powershell
Import-Module TabExpansionPlusPlus
```

When you import the TabExpansionPlusPlus module, all of the default argument completer functions will be available to you. However, you can create your own argument completer functions to auto-complete parameter values for your own functions.

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

# Custom Argument Completers

## Create Argument Completer Functions

To create your own, custom argument completer functions inside a custom module, follow this process:

1. Include a new script file with your module called `<ModuleName>.ArgumentCompleters.ps1`
2. Declare a function inside the script file. This function will be invoked every time that auto-completion is invoked.
3. The `param()` block must *accept* the following parameters. You do not have to specify the input parameter values, however.
    - `$commandName` = The name of the PowerShell command that the auto-completer applies to.
    - `$parameterName` = The name of the PowerShell command parameter that will be auto-completed.
    - `$wordToComplete` = The partial text that will be auto-completed.
    - `$commandAst`
    - `$fakeBoundParameter`
4. The function **must** return one or more instances of `System.Management.Automation.CompletionResult`. The `New-CompletionResult` command aids with constructing these objects.

```powershell
function VerbCompletion {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Get-Verb "$wordToComplete*" |
        ForEach-Object {
            New-CompletionResult -CompletionText $_.Verb -ToolTip ("Group: " + $_.Group)
        }   
}
```

## Import Your Argument Completer

After you have created a custom argument completer function, the `Register-ArgumentCompleter` command must be used to register your custom argument completer function with the appropriate PowerShell commands/parameters.

The following parameters should be specified in the call to `Register-ArgumentCompleter`:

- `-Command` = An array of PowerShell command names that share a parameter. You can pass in a static array of command values or dynamically obtain them using `Get-Command` (PowerShell Core) or `Get-CommandWithParameter` (TabExpansionPlusPlus)
- `-Parameter` = The name of the parameter that the auto-completer function will auto-complete values for.
- `-Description` = A description of the registered argument completer.
- `-ScriptBlock` = The PowerShell `ScriptBlock` that will be executed when the argument completer is invoked.

```
Register-ArgumentCompleter -CommandName Get-Verb -Parameter Verb -ScriptBlock $function:VerbCompletion -Description 'This argument completer handles the -Verb parameter of the Get-Verb command.'
```

## Testing Your Argument Completer

After you have created your custom argument completer function, and registered it, you should test auto-completion to ensure that the function is working as expected. The TabExpansionPlusPlus module includes a command to aid in this testing called `Test-ArgumentCompleter`.

At a minimum, you must specify the following parameters to `Test-ArgumentCompleter`:

- `-CommandName` = The name of the command whose argument completer will be tested.
- `-ParameterName` = The name of the parameter, on the command specified in the `-CommandName` parameter, whose argument completer will be tested.

```powershell
### Test the argument completer with no input
Test-ArgumentCompleter -CommandName Get-Verb -ParameterName Verb

### Test the argument completer with input
Test-ArgumentCompleter -CommandName Get-Verb -ParameterName Verb
```

# Issues / Feedback

For any issues or feedback related to this module, please register for GitHub, and post your inquiry to this project's issue tracker.
