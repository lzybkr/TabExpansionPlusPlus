function HexoArgumentCompletion{
    param($wordToComplete, $commandAst, $cursor)

    $HexoCommandList = @('help', 'init', 'version', 'new', 'serve', `
                        '--debug', '--cwd', '--config', '--draft', '--safe', '--silent')
    
    $HexoCommandList|ForEach-Object {
        if("$_" -match "^$wordToComplete*") {
            New-CompletionResult -CompletionText $_
        }    
    }
}

Register-ArgumentCompleter `
    -Native `
    -CommandName ('hexo', 'hexo.cmd') `
    -ScriptBlock $function:HexoArgumentCompletion