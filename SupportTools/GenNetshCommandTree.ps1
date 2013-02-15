#
# This script generates the command tree used in the function
#
#   NetshExeCompletion
#
# It's a little awkward to use, I did something like:
#
# PS> $x = GenNetshCommandTree
# PS> $x.SubCommands | clip
# PS> # Now paste the clipboard into the appropriate place in the ps1 file
# PS> $x.Psd1Entries | clip
# PS> # Now paste the clipboard into the appropriate place in the corresponding psd1 file
#

function get_command_tree
{
    param(
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]
        $Commands = @())

    $script:depth += 1

    $help = netsh @Commands /?
    for ($i = 0; $i -lt $help.Count; $i++)
    {
        if ($help[$i] -match '^Commands in this context:')
        {
            $i++
            break
        }
    }

    $subCommands = @()
    $psd1Entries = @()
    for (; $i -lt $help.Count; $i++)
    {
        # match lines like:
        #    add         - Adds a configuration entry to a list of entries
        #    add helper  - Installs a helper DLL
        # In the second case, we ignore the first word ('add') when netsh
        # redundantly includes the last command in the help.
        if ($help[$i] -match "^($($Commands[-1]) )?([a-z]+)\s+- (.*)`$")
        {
            $command = $matches[2]
            $help_text = $matches[3]

            $new_commands = $Commands + $command
            $psd1EntryName = 'netsh_' + ($new_commands -join '_')

            $psd1Entries += "{0} = @'`n{1}`n'@" -f $psd1EntryName,$help_text

            $subResult = get_command_tree -Commands $new_commands

            $subResult.Psd1Entries | % { $psd1Entries += $_ }

            $indent = ' ' * (4 * $depth)
            $line = '{0}nct {1} $msgTable.{2}' -f $indent, $command, $psd1EntryName
            if ($subResult.SubCommands.Count)
            {
                $line += " {`n"
                foreach ($subNct in $subResult.SubCommands)
                {
                    $line += $subNct
                }
                $line += "$indent}"
            }
            $subCommands += $line + "`n"
        }
    }

    [pscustomobject]@{ SubCommands = $subCommands; Psd1Entries = $psd1Entries }

    $script:depth -= 1
}

$depth = 0
get_command_tree
