#
# .SYNOPSIS
#
#     Complete parameters and arguments to Robocopy.exe
#

function RobocopyExeCompletion
{
    [ArgumentCompleter(
        Native,
        Command = 'Robocopy',
        Description = 'Complete parameters and arguments to robocopy.exe')]

    #Register-ArgumentCompleter -Native -CommandName Robocopy -ScriptBlock {
    
    param($wordToComplete, $commandAst)

    $key = "RoboCopyExeCompletionCommandTree"

    $commandTree = Get-CompletionPrivateData -Key $key
    
    if ($null -eq $commandTree)
    {
        $commandTree = & {
            New-CommandTree '/S' 'copy Subdirectories, but not empty ones'
            New-CommandTree '/E' 'copy subdirectories, including Empty ones'

            New-CommandTree '/Z' 'copy files in restartable mode'
            New-CommandTree '/B' 'copy files in Backup mode'
            New-CommandTree '/ZB' 'use restartable mode; if access denied use Backup mode'
            New-CommandTree '/J' 'copy using unbuffered I/O (recommended for large files)'
            New-CommandTree '/EFSRAW' 'copy all encrypted files in EFS RAW mode'

            New-CommandTree '/SEC' 'copy files with SECurity (equivalent to /COPY:DATS)'
            New-CommandTree '/COPYALL' 'COPY ALL file info (equivalent to /COPY:DATSOU)'
            New-CommandTree '/NOCOPY' 'COPY NO file info (useful with /PURGE)'
            New-CommandTree '/SECFIX' 'FIX file SECurity on all files, even skipped files'
            New-CommandTree '/TIMFIX' 'FIX file TIMes on all files, even skipped files'
            New-CommandTree '/PURGE' 'delete dest files/dirs that no longer exist in source'
            New-CommandTree '/MIR' 'MIRror a directory tree (equivalent to /E plus /PURGE)'
            New-CommandTree '/MOV' 'MOVe files (delete from source after copying)'
            New-CommandTree '/MOVE' 'MOVE files AND dirs (delete from source after copying)'

            New-CommandTree '/CREATE' 'CREATE directory tree and zero-length files only'
            New-CommandTree '/FAT' 'create destination files using 8.3 FAT file names only'
            New-CommandTree '/256' 'turn off very long path (> 256 characters) support'

            New-CommandTree '/MON:n' 'MONitor source; run again when more than n changes seen'
            New-CommandTree '/MOT:m' 'MOnitor source; run again in m minutes Time, if changed'

            New-CommandTree '/RH:hhmm-hhmm' 'Run Hours - times when new copies may be started'
            New-CommandTree '/PF' 'check run hours on a Per File (not per pass) basis'

            New-CommandTree '/IPG:n' 'Inter-Packet Gap (ms), to free bandwidth on slow lines'

            New-CommandTree '/SL' 'copy symbolic links versus the target'

            New-CommandTree '/MT[:n]' 'Do multi-threaded copies with n threads (default 8)
                n must be at least 1 and not greater than 128
                This option is incompatible with the /IPG and /EFSRAW options
                Redirect output using /LOG option for better performance.'

            New-CommandTree '/DCOPY:copyflag[s]' 'what to COPY for directories (default is /DCOPY:DA)
                                   (copyflags : D=Data, A=Attributes, T=Timestamps)'

            New-CommandTree '/NODCOPY' 'COPY NO directory info (by default /DCOPY:DA is done)'

            New-CommandTree '/NOOFFLOAD' 'copy files without using the Windows Copy Offload mechanism'

            New-CommandTree '/L' "List only - don't copy, timestamp or delete any files"
            New-CommandTree '/X' 'report all eXtra files, not just those selected'
            New-CommandTree '/V' 'produce Verbose output, showing skipped files'
            New-CommandTree '/TS' 'include source file Time Stamps in the output'
            New-CommandTree '/FP' 'include Full Pathname of files in the output'
            New-CommandTree '/BYTES' 'Print sizes as bytes'

            New-CommandTree '/NS' "No Size - don't log file sizes"
            New-CommandTree '/NC' "No Class - don't log file classes"
            New-CommandTree '/NFL' "No File List - don't log file names"
            New-CommandTree '/NDL' "No Directory List - don't log directory names"

            New-CommandTree '/NP' "No Progress - don't display percentage copied"
            New-CommandTree '/ETA' 'show Estimated Time of Arrival of copied files'

            New-CommandTree '/LOG:file' 'output status to LOG file (overwrite existing log)'
            New-CommandTree '/LOG+:file' 'output status to LOG file (append to existing log)'

            New-CommandTree '/UNILOG:file' 'output status to LOG file as UNICODE (overwrite existing log)'
            New-CommandTree '/UNILOG+:file' 'output status to LOG file as UNICODE (append to existing log)'

            New-CommandTree '/TEE' 'output to console window, as well as the log file'

            New-CommandTree '/NJH' 'No Job Header'
            New-CommandTree '/NJS' 'No Job Summary'

            New-CommandTree '/UNICODE' 'output status as UNICODE'

            New-CommandTree '/JOB:jobname' 'take parameters from the named JOB file'
            New-CommandTree '/SAVE:jobname' 'SAVE parameters to the named job file'
            New-CommandTree '/QUIT' 'QUIT after processing command line (to view parameters).'
            New-CommandTree '/NOSD' 'NO Source Directory is specified'
            New-CommandTree '/NODD' 'NO Destination Directory is specified'
            New-CommandTree '/IF' 'Include the following Files'

            New-CommandTree '/R:n' 'number of Retries on failed copies: default 1 million'
            New-CommandTree '/W:n' 'Wait time between retries: default is 30 seconds'

            New-CommandTree '/REG' 'Save /R:n and /W:n in the Registry as default settings'
            New-CommandTree '/TBD' 'wait for sharenames To Be Defined (retry error 67)'

            New-CommandTree '/A' 'copy only files with the Archive attribute set'
            New-CommandTree '/M' 'copy only files with the Archive attribute and reset it'
            New-CommandTree '/IA:[RASHCNETO]' 'Include only files with any of the given Attributes set'
            New-CommandTree '/XA:[RASHCNETO]' 'eXclude files with any of the given Attributes set'

            New-CommandTree '/XF file [file]...' 'eXclude Files matching given names/paths/wildcards'
            New-CommandTree '/XD dirs [dirs]...' 'eXclude Directories matching given names/paths'

            New-CommandTree '/XC' 'eXclude Changed files'
            New-CommandTree '/XN' 'eXclude Newer files'
            New-CommandTree '/XO' 'eXclude Older files'
            New-CommandTree '/XX' 'eXclude eXtra files and directories'
            New-CommandTree '/XL' 'eXclude Lonely files and directories'
            New-CommandTree '/IS' 'Include Same files'
            New-CommandTree '/IT' 'Include Tweaked files'

            New-CommandTree '/MAX:n' 'MAXimum file size - exclude files bigger than n bytes'
            New-CommandTree '/MIN:n' 'MINimum file size - exclude files smaller than n bytes'

            New-CommandTree '/MAXAGE:n' 'MAXimum file AGE - exclude files older than n days/date'
            New-CommandTree '/MINAGE:n' 'MINimum file AGE - exclude files newer than n days/date'
            New-CommandTree '/MAXLAD:n' 'MAXimum Last Access Date - exclude files unused since n'
            New-CommandTree '/MINLAD:n' 'MINimum Last Access Date - exclude files used since n
                                   (If n < 1900 then n = n days, else n = YYYYMMDD date)'  

            New-CommandTree '/XJ' 'eXclude Junction points. (normally included by default)'

            New-CommandTree '/FFT' 'assume FAT File Times (2-second granularity)'
            New-CommandTree '/DST' 'compensate for one-hour DST time differences'

            New-CommandTree '/XJD' 'eXclude Junction points for Directories'
            New-CommandTree '/XJF' 'eXclude Junction points for Files'

        }

        Set-CompletionPrivateData -Key $key -Value $commandTree
    }

    Get-CommandTreeCompletion $wordToComplete $commandAst $commandTree
}