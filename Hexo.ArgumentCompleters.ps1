function HexoArgumentCompletion{
    param($commandName, $wordToComplete, $commandAst, $fakeBoundParameter)

    $HexoCommandList = @('help', 'init', 'version', 'new', 'serve', `
                        '--debug', '--cwd', '--config', '--draft', '--safe', '--silent')
    $stringWord = [string]$wordToComplete
    $partialWord = $stringWord.Split(" ")[-1]
    
    $HexoCommandList|ForEach-Object {
        if("$_" -match "^$partialWord *") {
            New-CompletionResult -CompletionText $_
        }    
    }
}

Register-ArgumentCompleter `
    -Native `
    -CommandName ('hexo', 'hexo.cmd') `
    -ScriptBlock $function:HexoArgumentCompletion