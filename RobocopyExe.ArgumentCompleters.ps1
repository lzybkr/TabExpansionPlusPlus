

function RobocopyExeCompletion
{
    [ArgumentCompleter(
        Native,
        Command = 'Robocopy',
        Description = 'Complete parameters and arguments to robocopy.exe')]
            
    param($wordToComplete, $commandAst) 

    #
    # .SYNOPSIS
    #
    #     Complete parameters and arguments to Robocopy.exe
    #
    function Get-RoboCopyArguments { 
        [PSCustomObject]@{Argument='/S'; ToolTip='copy Subdirectories, but not empty ones'}
        [PSCustomObject]@{Argument='/E'; ToolTip='copy subdirectories, including Empty ones'}
        [PSCustomObject]@{Argument='/Z'; ToolTip='copy files in restartable mode'}
        [PSCustomObject]@{Argument='/B'; ToolTip='copy files in Backup mode'}
        [PSCustomObject]@{Argument='/ZB'; ToolTip='use restartable mode; if access denied use Backup mode'}
        [PSCustomObject]@{Argument='/J'; ToolTip='copy using unbuffered I/O (recommended for large files)'}
        [PSCustomObject]@{Argument='/EFSRAW'; ToolTip='copy all encrypted files in EFS RAW mode'}
        [PSCustomObject]@{Argument='/SEC'; ToolTip='copy files with SECurity (equivalent to /COPY:DATS)'}
        [PSCustomObject]@{Argument='/COPYALL'; ToolTip='COPY ALL file info (equivalent to /COPY:DATSOU)'}
        [PSCustomObject]@{Argument='/NOCOPY'; ToolTip='COPY NO file info (useful with /PURGE)'}
        [PSCustomObject]@{Argument='/SECFIX'; ToolTip='FIX file SECurity on all files, even skipped files'}
        [PSCustomObject]@{Argument='/TIMFIX'; ToolTip='FIX file TIMes on all files, even skipped files'}
        [PSCustomObject]@{Argument='/PURGE'; ToolTip='delete dest files/dirs that no longer exist in source'}
        [PSCustomObject]@{Argument='/MIR'; ToolTip='MIRror a directory tree (equivalent to /E plus /PURGE)'}
        [PSCustomObject]@{Argument='/MOV'; ToolTip='MOVe files (delete from source after copying)'}
        [PSCustomObject]@{Argument='/MOVE'; ToolTip='MOVE files AND dirs (delete from source after copying)'}
        [PSCustomObject]@{Argument='/CREATE'; ToolTip='CREATE directory tree and zero-length files only'}
        [PSCustomObject]@{Argument='/FAT'; ToolTip='create destination files using 8.3 FAT file names only'}
        [PSCustomObject]@{Argument='/256'; ToolTip='turn off very long path (> 256 characters) support'}
        [PSCustomObject]@{Argument='/MON:'; ToolTip='MONitor source; run again when more than n changes seen'}
        [PSCustomObject]@{Argument='/MOT:'; ToolTip='MOnitor source; run again in m minutes Time, if changed'}
        [PSCustomObject]@{Argument='/RH:'; ToolTip='Run Hours - times when new copies may be started'}
        [PSCustomObject]@{Argument='/PF'; ToolTip='check run hours on a Per File (not per pass) basis'}
        [PSCustomObject]@{Argument='/IPG:'; ToolTip='Inter-Packet Gap (ms), to free bandwidth on slow lines'}
        [PSCustomObject]@{Argument='/SL'; ToolTip='copy symbolic links versus the target'}
        [PSCustomObject]@{Argument='/MT:'; ToolTip='Do multi-threaded copies with n threads (default 8)
            n must be at least 1 and not greater than 128
            This option is incompatible with the /IPG and /EFSRAW options
            Redirect output using /LOG option for better performance.'}
        [PSCustomObject]@{Argument='/DCOPY:'; ToolTip='what to COPY for directories (default is /DCOPY:DA)
			        (copyflags : D=Data, A=Attributes, T=Timestamps)'}
        [PSCustomObject]@{Argument='/NODCOPY'; ToolTip='COPY NO directory info (by default /DCOPY:DA is done)'}
        [PSCustomObject]@{Argument='/NOOFFLOAD'; ToolTip='copy files without using the Windows Copy Offload mechanism'}
        [PSCustomObject]@{Argument='/L'; ToolTip="List only - don't copy, timestamp or delete any files"}
        [PSCustomObject]@{Argument='/X'; ToolTip='report all eXtra files, not just those selected'}
        [PSCustomObject]@{Argument='/V'; ToolTip='produce Verbose output, showing skipped files'}
        [PSCustomObject]@{Argument='/TS'; ToolTip='include source file Time Stamps in the output'}
        [PSCustomObject]@{Argument='/FP'; ToolTip='include Full Pathname of files in the output'}
        [PSCustomObject]@{Argument='/BYTES'; ToolTip='Print sizes as bytes'}
        [PSCustomObject]@{Argument='/NS'; ToolTip="No Size - don't log file sizes"}
        [PSCustomObject]@{Argument='/NC'; ToolTip="No Class - don't log file classes"}
        [PSCustomObject]@{Argument='/NFL'; ToolTip="No File List - don't log file names"}
        [PSCustomObject]@{Argument='/NDL'; ToolTip="No Directory List - don't log directory names"}
        [PSCustomObject]@{Argument='/NP'; ToolTip="No Progress - don't display percentage copied"}
        [PSCustomObject]@{Argument='/ETA'; ToolTip='show Estimated Time of Arrival of copied files'}
        [PSCustomObject]@{Argument='/LOG:'; ToolTip='output status to LOG file (overwrite existing log)'}
        [PSCustomObject]@{Argument='/LOG+:'; ToolTip='output status to LOG file (append to existing log)'}
        [PSCustomObject]@{Argument='/UNILOG:'; ToolTip='output status to LOG file as UNICODE (overwrite existing log)'}
        [PSCustomObject]@{Argument='/UNILOG+:'; ToolTip='output status to LOG file as UNICODE (append to existing log)'}
        [PSCustomObject]@{Argument='/TEE'; ToolTip='output to console window, as well as the log file'}
        [PSCustomObject]@{Argument='/NJH'; ToolTip='No Job Header'}
        [PSCustomObject]@{Argument='/NJS'; ToolTip='No Job Summary'}
        [PSCustomObject]@{Argument='/UNICODE'; ToolTip='output status as UNICODE'}
        [PSCustomObject]@{Argument='/JOB:'; ToolTip='take parameters from the named JOB file'}
        [PSCustomObject]@{Argument='/SAVE:'; ToolTip='SAVE parameters to the named job file'}
        [PSCustomObject]@{Argument='/QUIT'; ToolTip='QUIT after processing command line (to view parameters).'}
        [PSCustomObject]@{Argument='/NOSD'; ToolTip='NO Source Directory is specified'}
        [PSCustomObject]@{Argument='/NODD'; ToolTip='NO Destination Directory is specified'}
        [PSCustomObject]@{Argument='/IF'; ToolTip='Include the following Files'}
        [PSCustomObject]@{Argument='/R:'; ToolTip='number of Retries on failed copies: default 1 million'}
        [PSCustomObject]@{Argument='/W:'; ToolTip='Wait time between retries: default is 30 seconds'}
        [PSCustomObject]@{Argument='/REG'; ToolTip='Save /R:n and /W:n in the Registry as default settings'}
        [PSCustomObject]@{Argument='/TBD'; ToolTip='wait for sharenames To Be Defined (retry error 67)'}
        [PSCustomObject]@{Argument='/A'; ToolTip='copy only files with the Archive attribute set'}
        [PSCustomObject]@{Argument='/M'; ToolTip='copy only files with the Archive attribute and reset it'}
        [PSCustomObject]@{Argument='/IA:'; ToolTip='Include only files with any of the given Attributes set'}
        [PSCustomObject]@{Argument='/XA:'; ToolTip='eXclude files with any of the given Attributes set'}
        [PSCustomObject]@{Argument='/XF file [file]...'; ToolTip='eXclude Files matching given names/paths/wildcards'}
        [PSCustomObject]@{Argument='/XD dirs [dirs]...'; ToolTip='eXclude Directories matching given names/paths'}
        [PSCustomObject]@{Argument='/XC'; ToolTip='eXclude Changed files'}
        [PSCustomObject]@{Argument='/XN'; ToolTip='eXclude Newer files'}
        [PSCustomObject]@{Argument='/XO'; ToolTip='eXclude Older files'}
        [PSCustomObject]@{Argument='/XX'; ToolTip='eXclude eXtra files and directories'}
        [PSCustomObject]@{Argument='/XL'; ToolTip='eXclude Lonely files and directories'}
        [PSCustomObject]@{Argument='/IS'; ToolTip='Include Same files'}
        [PSCustomObject]@{Argument='/IT'; ToolTip='Include Tweaked files'}
        [PSCustomObject]@{Argument='/MAX:'; ToolTip='MAXimum file size - exclude files bigger than n bytes'}
        [PSCustomObject]@{Argument='/MIN:'; ToolTip='MINimum file size - exclude files smaller than n bytes'}
        [PSCustomObject]@{Argument='/MAXAGE:'; ToolTip='MAXimum file AGE - exclude files older than n days/date'}
        [PSCustomObject]@{Argument='/MINAGE:'; ToolTip='MINimum file AGE - exclude files newer than n days/date'}
        [PSCustomObject]@{Argument='/MAXLAD:'; ToolTip='MAXimum Last Access Date - exclude files unused since n'}
        [PSCustomObject]@{Argument='/MINLAD:'; ToolTip='MINimum Last Access Date - exclude files used since n
			        (If n < 1900 then n = n days, else n = YYYYMMDD date)'}
        [PSCustomObject]@{Argument='/XJ'; ToolTip='eXclude Junction points. (normally included by default)'}
        [PSCustomObject]@{Argument='/FFT'; ToolTip='assume FAT File Times (2-second granularity)'}
        [PSCustomObject]@{Argument='/DST'; ToolTip='compensate for one-hour DST time differences'}
        [PSCustomObject]@{Argument='/XJD'; ToolTip='eXclude Junction points for Directories'}
        [PSCustomObject]@{Argument='/XJF'; ToolTip='eXclude Junction points for Files'}    
    }

    Get-RoboCopyArguments | 
        Where-Object {$_.argument -like "$wordToComplete*"} |
        Sort-Object Argument |
        ForEach-Object {
            New-CompletionResult $_.Argument $_.ToolTip
        }
}