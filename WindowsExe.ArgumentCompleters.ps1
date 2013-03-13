
#
# .SYNOPSIS
#
#     Complete parameters and arguments to PowerShell.exe
#
function PowerShellExeCompletion
{
    [ArgumentCompleter(
        Native,
        Command = 'PowerShell',
        Description = 'Complete parameters and arguments to powershell.exe')]
    param($wordToComplete, $commandAst)

    $tryParameters = $true
    $last = if ($wordToComplete) { -2 } else { -1 }
    $parameterAst = $commandAst.CommandElements[$last] -as [System.Management.Automation.Language.CommandParameterAst]
    if ($parameterAst -ne $null)
    {
        if ("File".StartsWith($parameterAst.ParameterName, "OrdinalIgnoreCase"))
        {
            Get-CompletionWithExtension $wordToComplete '.ps1'
            return
        }

        $completions = $null

        if ("InputFormat".StartsWith($parameterAst.ParameterName, "OrdinalIgnoreCase") -or
            "OutputFormat".StartsWith($parameterAst.ParameterName, "OrdinalIgnoreCase"))
        {
            $completions = "Text", "XML"
        }
        elseif ("WindowsStyle".StartsWith($parameterAst.ParameterName, "OrdinalIgnoreCase"))
        {
            $completions = "Normal", "Minimized", "Maximized", "Hidden"
        }
        elseif ("ExecutionPolicy".StartsWith($parameterAst.ParameterName, "OrdinalIgnoreCase"))
        {
            $completions = ([Microsoft.PowerShell.ExecutionPolicy] | Get-Member -Static -MemberType Property).Name
        }

        foreach ($completion in $completions)
        {
            $tryParameters = $false
            New-CompletionResult $completion
        }
    }

    if ($tryParameters -and ($wordToComplete.StartsWith("-") -or "" -eq $wordToComplete))
    {
        echo -- -PSConsoleFile -Version -NoLogo -NoExit -Sta -NoProfile -NonInteractive `
            -InputFormat -OutputFormat -WindowStyle -EncodedCommand -File -ExecutionPolicy `
            -Command |
            Where-Object { $_ -like "$wordToComplete*" } |
            Sort-Object |
            ForEach-Object {
                New-CompletionResult $_
            }
    }
}


#
# .SYNOPSIS
#
#     Complete parameters and arguments to net.exe
#
function NetExeCompletion
{
    [ArgumentCompleter(
        Native,
        Command = 'Net',
        Description = 'Complete arguments to net.exe')]
    param($wordToComplete, $commandAst)

    $commandTree = Get-CompletionPrivateData -Key NetExeCompletionCommandTree
    if ($null -eq $commandTree)
    {
        Set-Alias -Name nct -Value New-CommandTree

        Import-LocalizedData -BindingVariable msgTable -FileName WindowsExe.Messages.psd1

        $commandTree = & {
            nct ACCOUNTS $msgTable.net_ACCOUNTS {
                nct -Argument '/FORCELOGOFF:' $msgTable.net_ACCOUNTS_FORCELOGOFF
                nct -Argument '/MINPWLEN:' $msgTable.net_ACCOUNTS_MINPWLEN
                nct -Argument '/MAXPWAGE:' $msgTable.net_ACCOUNTS_MAXPWAGE
                nct -Argument '/MINPWAGE:' $msgTable.net_ACCOUNTS_MINPWAGE
                nct -Argument '/DOMAIN' $msgTable.net_ACCOUNTS_DOMAIN
            }

            nct COMPUTER $msgTable.net_COMPUTER {
                nct '/ADD' $msgTable.net_COMPUTER_ADD
                nct '/DEL' $msgTable.net_COMPUTER_DEL
            }

            nct CONFIG $msgTable.net_CONFIG {
                nct SERVER $msgTable.net_CONFIG_SERVER
                nct WORKSTATION $msgTable.net_CONFIG_WORKSTATION
            }

            nct CONTINUE $msgTable.Net_CONTINUE {
                nct {
                    param($wordToComplete, $commandAst)

                    Get-Service |
                        Where-Object {
                            $_.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Paused -and
                            ($_.Name -like "$wordToComplete*" -or $_.DisplayName -like "$wordToComplete*") } |
                        Sort-Object DisplayName |
                        ForEach-Object {
                            New-CompletionResult $_.DisplayName -ToolTip "Name: $($_.Name)"
                        }
                }
            }

            nct FILE $msgTable.net_FILE {
                nct {
                    param($wordToComplete, $commandAst)
                    net file |
                        ForEach-Object {
                            # It'd be better to parse the header and use the columns
                            # in tooltips but nobody will probably ever notice this
                            # completion anyway.
                            if ($_ -match '\s*(\d+)\s+(.*)')
                            {
                                if ($matches[1] -like "$wordToComplete*")
                                {
                                    New-CompletionResult $_ -ToolTip $matches[2]
                                }
                            }
                        }
                }
                nct -Argument '/CLOSE' $msgTable.net_FILE_CLOSE
            }

            nct GROUP $msgTable.net_GROUP {
                nct -Argument '/COMMENT:' $msgTable.net_GROUP_COMMENT
                nct -Argument '/DOMAIN' $msgTable.net_GROUP_DOMAIN
                nct -Argument '/ADD' $msgTable.net_GROUP_ADD
                nct -Argument '/DELETE' $msgTable.net_GROUP_DELETE
            }

            nct HELP $msgTable.net_HELP {
                echo ACCOUNTS COMPUTER CONFIG CONTINUE FILE GROUP HELP `
                     HELPMSG LOCALGROUP PAUSE SESSION SHARE START `
                     STATISTICS STOP TIME USE USER VIEW |
                     ForEach-Object {
                        nct $_ ($msgTable.net_HELP_COMMAND + $_)
                     }

                nct NAMES $msgTable.net_HELP_NAMES
                nct SERVICES $msgTable.net_HELP_SERVICES
                nct SYNTAX $msgTable.net_HELP_SYNTAX
            }

            nct HELPMSG $msgTable.net_HELPMSG

            nct LOCALGROUP $msgTable.net_LOCALGROUP {
                nct -Argument '/COMMENT:' $msgTable.net_LOCALGROUP_COMMENT
                nct -Argument '/DOMAIN' $msgTable.net_LOCALGROUP_DOMAIN
                nct -Argument '/ADD' $msgTable.net_LOCALGROUP_ADD
                nct -Argument '/DELETE' $msgTable.net_LOCALGROUP_DELETE
            }

            nct PAUSE $msgTable.net_PAUSE {
                nct {
                    param($wordToComplete, $commandAst)

                    Get-Service |
                        Where-Object {
                            $_.CanPauseAndContinue -and
                            ($_.Name -like "$wordToComplete*" -or $_.DisplayName -like "$wordToComplete*") } |
                        Sort-Object DisplayName |
                        ForEach-Object {
                            New-CompletionResult $_.DisplayName -ToolTip "Name: $($_.Name)"
                        }
                }
            }

            nct SESSION $msgTable.net_SESSION {
                nct -Argument '/DELETE' $msgTable.net_SESSION_DELETE
                nct -Argument '/LIST' $msgTable.net_SESSION_LIST
            }

            nct SHARE $msgTable.net_SHARE {
                nct -Argument '/GRANT:' $msgTable.net_SHARE_GRANT
                nct -Argument '/USERS:' $msgTable.net_SHARE_USERS
                nct -Argument '/UNLIMITED' $msgTable.net_SHARE_UNLIMITED
                nct -Argument '/REMARK:' $msgTable.net_SHARE_REMARK
                nct -Argument '/DELETE' $msgTable.net_SHARE_DELETE
                nct -Argument '/CACHE:Manual' $msgTable.net_SHARE_CACHE_Manual
                nct -Argument '/CACHE:Documents' $msgTable.net_SHARE_CACHE_Documents
                nct -Argument '/CACHE:Programs' $msgTable.net_SHARE_CACHE_Programs
                nct -Argument '/CACHE:BranchCache' $msgTable.net_SHARE_CACHE_BranchCache
                nct -Argument '/CACHE:None' $msgTable.net_SHARE_CACHE_None
            }

            nct START $msgTable.net_START {
                nct {
                    param($wordToComplete, $commandAst)

                    Get-Service |
                        Where-Object {
                            $_.Status -eq [System.ServiceProcess.ServiceControllerStatus]::Stopped -and
                            ($_.Name -like "$wordToComplete*" -or $_.DisplayName -like "$wordToComplete*") } |
                        Sort-Object DisplayName |
                        ForEach-Object {
                            New-CompletionResult $_.DisplayName -ToolTip "Name: $($_.Name)"
                        }
                }
            }

            nct STATISTICS $msgTable.net_STATISTICS {
                nct SERVER $msgTable.net_STATISTICS_SERVER
                nct WORKSTATION $msgTable.net_STATISTICS_WORKSTATION
            }

            nct STOP $msgTable.net_STOP {
                nct {
                    param($wordToComplete, $commandAst)

                    Get-Service |
                        Where-Object {
                            $_.CanStop -and
                            ($_.Name -like "$wordToComplete*" -or $_.DisplayName -like "$wordToComplete*") } |
                        Sort-Object DisplayName |
                        ForEach-Object {
                            New-CompletionResult $_.DisplayName -ToolTip "Name: $($_.Name)"
                        }
                }
            }

            nct TIME $msgTable.net_TIME {
                nct -Argument '/DOMAIN' $msgTable.net_TIME_DOMAIN
                nct -Argument '/RTSDOMAIN' $msgTable.net_TIME_RTSDOMAIN
                nct -Argument '/SET' $msgTable.net_TIME_SET 
            }

            nct USE $msgTable.net_USE {
                nct -Argument '/USER:' $msgTable.net_USE_USER 
                nct -Argument '/SMARTCARD' $msgTable.net_USE_SMARTCARD
                nct -Argument '/SAVECRED' $msgTable.net_USE_SAVECRED
                nct -Argument '/DELETE' $msgTable.net_USE_DELETE
                nct -Argument '/PERSISTENT:YES' $msgTable.net_USE_PERSISTENT
                nct -Argument '/PERSISTENT:NO' $msgTable.net_USE_PERSISTENT
            }

            nct USER $msgTable.net_USER {
                # We could be much smarter here - many of the options
                # aren't valid if /ADD or /DELETE is specified.
                nct -Argument '/DOMAIN' $msgTable.net_USER_DOMAIN
                nct -Argument '/ADD' $msgTable.net_USER_ADD
                nct -Argument '/DELETE' $msgTable.net_USER_DELETE
                nct -Argument '/ACTIVE:YES' $msgTable.net_USER_ACTIVE
                nct -Argument '/ACTIVE:NO' $msgTable.net_USER_ACTIVE
                nct -Argument '/COMMENT:' $msgTable.net_USER_COMMENT
                nct -Argument '/COUNTRYCODE:' $msgTable.net_USER_COUNTRYCODE
                nct -Argument '/EXPIRES:' $msgTable.net_USER_EXPIRES
                nct -Argument '/EXPIRES:NEVER' $msgTable.net_USER_EXPIRES
                nct -Argument '/FULLNAME:' $msgTable.net_USER_FULLNAME
                nct -Argument '/HOMEDIR:' $msgTable.net_USER_HOMEDIR
                nct -Argument '/PASSWORDCHG:YES' $msgTable.net_USER_PASSWORDCHG
                nct -Argument '/PASSWORDCHG:NO' $msgTable.net_USER_PASSWORDCHG
                nct -Argument '/PASSWORDREQ:YES' $msgTable.net_USER_PASSWORDREQ
                nct -Argument '/PASSWORDREQ:NO' $msgTable.net_USER_PASSWORDREQ
                nct -Argument '/LOGONPASSWORDCHG:YES' $msgTable.net_USER_LOGONPASSWORDCHG
                nct -Argument '/LOGONPASSWORDCHG:NO' $msgTable.net_USER_LOGONPASSWORDCHG
                nct -Argument '/PROFILEPATH:' $msgTable.net_USER_PROFILEPATH
                nct -Argument '/SCRIPTPATH:' $msgTable.net_USER_SCRIPTPATH
                nct -Argument '/TIMES:' $msgTable.net_USER_TIMES
                nct -Argument '/TIMES:ALL' $msgTable.net_USER_TIMES
                nct -Argument '/USERCOMMENT:' $msgTable.net_USER_USERCOMMENT
                nct -Argument '/WORKSTATIONS:' $msgTable.net_USER_WORKSTATIONS
            }

            nct VIEW $msgTable.net_VIEW {
                nct -Argument '/DOMAIN:' $msgTable.net_VIEW_DOMAIN
                nct -Argument '/CACHE' $msgTable.net_VIEW_CACHE
                nct -Argument '/ALL' $msgTable.net_VIEW_ALL
            }
        }

        Set-CompletionPrivateData -Key NetExeCompletionCommandTree -Value $commandTree
    }

    Get-CommandTreeCompletion $wordToComplete $commandAst $commandTree
}


#
# .SYNOPSIS
#
#     Complete parameters and arguments to netsh.exe
#
function NetshExeCompletion
{
    [ArgumentCompleter(
        Native,
        Command = 'Netsh',
        Description = 'Complete arguments to netsh.exe')]
    param($wordToComplete, $commandAst)

    $commandTree = Get-CompletionPrivateData -Key NetshExeCompletionCommandTree
    if ($null -eq $commandTree)
    {
        Set-Alias -Name nct -Value New-CommandTree

        Import-LocalizedData -BindingVariable msgTable -FileName WindowsExe.Messages.psd1

        $commandTree = & {
            # Generated by:
            #    $x = GenNetshCommandTree
            #    $x.SubCommands | clip

            nct add $msgTable.netsh_add {
                nct helper $msgTable.netsh_add_helper
            }

            nct advfirewall $msgTable.netsh_advfirewall {
                nct consec $msgTable.netsh_advfirewall_consec {
                    nct add $msgTable.netsh_advfirewall_consec_add {
                        nct rule $msgTable.netsh_advfirewall_consec_add_rule
                    }
                    nct delete $msgTable.netsh_advfirewall_consec_delete {
                        nct rule $msgTable.netsh_advfirewall_consec_delete_rule
                    }
                    nct dump $msgTable.netsh_advfirewall_consec_dump
                    nct help $msgTable.netsh_advfirewall_consec_help
                    nct set $msgTable.netsh_advfirewall_consec_set {
                        nct rule $msgTable.netsh_advfirewall_consec_set_rule
                    }
                    nct show $msgTable.netsh_advfirewall_consec_show {
                        nct rule $msgTable.netsh_advfirewall_consec_show_rule
                    }
                }
                nct dump $msgTable.netsh_advfirewall_dump
                nct export $msgTable.netsh_advfirewall_export
                nct firewall $msgTable.netsh_advfirewall_firewall {
                    nct add $msgTable.netsh_advfirewall_firewall_add {
                        nct rule $msgTable.netsh_advfirewall_firewall_add_rule
                    }
                    nct delete $msgTable.netsh_advfirewall_firewall_delete {
                        nct rule $msgTable.netsh_advfirewall_firewall_delete_rule
                    }
                    nct dump $msgTable.netsh_advfirewall_firewall_dump
                    nct help $msgTable.netsh_advfirewall_firewall_help
                    nct set $msgTable.netsh_advfirewall_firewall_set {
                        nct rule $msgTable.netsh_advfirewall_firewall_set_rule
                    }
                    nct show $msgTable.netsh_advfirewall_firewall_show {
                        nct rule $msgTable.netsh_advfirewall_firewall_show_rule
                    }
                }
                nct help $msgTable.netsh_advfirewall_help
                nct import $msgTable.netsh_advfirewall_import
                nct mainmode $msgTable.netsh_advfirewall_mainmode {
                    nct add $msgTable.netsh_advfirewall_mainmode_add {
                        nct rule $msgTable.netsh_advfirewall_mainmode_add_rule
                    }
                    nct delete $msgTable.netsh_advfirewall_mainmode_delete {
                        nct rule $msgTable.netsh_advfirewall_mainmode_delete_rule
                    }
                    nct dump $msgTable.netsh_advfirewall_mainmode_dump
                    nct help $msgTable.netsh_advfirewall_mainmode_help
                    nct set $msgTable.netsh_advfirewall_mainmode_set {
                        nct rule $msgTable.netsh_advfirewall_mainmode_set_rule
                    }
                    nct show $msgTable.netsh_advfirewall_mainmode_show {
                        nct rule $msgTable.netsh_advfirewall_mainmode_show_rule
                    }
                }
                nct monitor $msgTable.netsh_advfirewall_monitor {
                    nct delete $msgTable.netsh_advfirewall_monitor_delete
                    nct dump $msgTable.netsh_advfirewall_monitor_dump
                    nct help $msgTable.netsh_advfirewall_monitor_help
                    nct show $msgTable.netsh_advfirewall_monitor_show {
                        nct consec $msgTable.netsh_advfirewall_monitor_show_consec
                        nct currentprofile $msgTable.netsh_advfirewall_monitor_show_currentprofile
                        nct firewall $msgTable.netsh_advfirewall_monitor_show_firewall
                        nct mainmode $msgTable.netsh_advfirewall_monitor_show_mainmode
                        nct mmsa $msgTable.netsh_advfirewall_monitor_show_mmsa
                        nct qmsa $msgTable.netsh_advfirewall_monitor_show_qmsa
                    }
                }
                nct reset $msgTable.netsh_advfirewall_reset
                nct set $msgTable.netsh_advfirewall_set {
                    nct allprofiles $msgTable.netsh_advfirewall_set_allprofiles
                    nct currentprofile $msgTable.netsh_advfirewall_set_currentprofile
                    nct domainprofile $msgTable.netsh_advfirewall_set_domainprofile
                    nct global $msgTable.netsh_advfirewall_set_global
                    nct privateprofile $msgTable.netsh_advfirewall_set_privateprofile
                    nct publicprofile $msgTable.netsh_advfirewall_set_publicprofile
                }
                nct show $msgTable.netsh_advfirewall_show {
                    nct allprofiles $msgTable.netsh_advfirewall_show_allprofiles
                    nct currentprofile $msgTable.netsh_advfirewall_show_currentprofile
                    nct domainprofile $msgTable.netsh_advfirewall_show_domainprofile
                    nct global $msgTable.netsh_advfirewall_show_global
                    nct privateprofile $msgTable.netsh_advfirewall_show_privateprofile
                    nct publicprofile $msgTable.netsh_advfirewall_show_publicprofile
                    nct store $msgTable.netsh_advfirewall_show_store
                }
            }

            nct branchcache $msgTable.netsh_branchcache {
                nct dump $msgTable.netsh_branchcache_dump
                nct exportkey $msgTable.netsh_branchcache_exportkey
                nct flush $msgTable.netsh_branchcache_flush
                nct help $msgTable.netsh_branchcache_help
                nct importkey $msgTable.netsh_branchcache_importkey
                nct reset $msgTable.netsh_branchcache_reset
                nct set $msgTable.netsh_branchcache_set {
                    nct cachesize $msgTable.netsh_branchcache_set_cachesize
                    nct key $msgTable.netsh_branchcache_set_key
                    nct localcache $msgTable.netsh_branchcache_set_localcache
                    nct publicationcache $msgTable.netsh_branchcache_set_publicationcache
                    nct publicationcachesize $msgTable.netsh_branchcache_set_publicationcachesize
                    nct service $msgTable.netsh_branchcache_set_service
                }
                nct show $msgTable.netsh_branchcache_show {
                    nct hostedcache $msgTable.netsh_branchcache_show_hostedcache
                    nct localcache $msgTable.netsh_branchcache_show_localcache
                    nct publicationcache $msgTable.netsh_branchcache_show_publicationcache
                    nct status $msgTable.netsh_branchcache_show_status
                }
                nct smb $msgTable.netsh_branchcache_smb {
                    nct dump $msgTable.netsh_branchcache_smb_dump
                    nct help $msgTable.netsh_branchcache_smb_help
                    nct set $msgTable.netsh_branchcache_smb_set {
                        nct latency $msgTable.netsh_branchcache_smb_set_latency
                    }
                    nct show $msgTable.netsh_branchcache_smb_show {
                        nct latency $msgTable.netsh_branchcache_smb_show_latency
                    }
                }
            }

            nct bridge $msgTable.netsh_bridge {
                nct dump $msgTable.netsh_bridge_dump
                nct help $msgTable.netsh_bridge_help
                nct install $msgTable.netsh_bridge_install
                nct set $msgTable.netsh_bridge_set {
                    nct adapter $msgTable.netsh_bridge_set_adapter
                }
                nct show $msgTable.netsh_bridge_show {
                    nct adapter $msgTable.netsh_bridge_show_adapter
                }
                nct uninstall $msgTable.netsh_bridge_uninstall
            }

            nct delete $msgTable.netsh_delete {
                nct helper $msgTable.netsh_delete_helper
            }

            nct dhcpclient $msgTable.netsh_dhcpclient

            nct dnsclient $msgTable.netsh_dnsclient {
                nct add $msgTable.netsh_dnsclient_add {
                    nct dnsservers $msgTable.netsh_dnsclient_add_dnsservers
                }
                nct delete $msgTable.netsh_dnsclient_delete {
                    nct dnsservers $msgTable.netsh_dnsclient_delete_dnsservers
                }
                nct dump $msgTable.netsh_dnsclient_dump
                nct help $msgTable.netsh_dnsclient_help
                nct set $msgTable.netsh_dnsclient_set {
                    nct dnsservers $msgTable.netsh_dnsclient_set_dnsservers
                }
                nct show $msgTable.netsh_dnsclient_show {
                    nct state $msgTable.netsh_dnsclient_show_state
                }
            }

            nct dump $msgTable.netsh_dump

            nct exec $msgTable.netsh_exec

            nct firewall $msgTable.netsh_firewall {
                nct add $msgTable.netsh_firewall_add
                nct delete $msgTable.netsh_firewall_delete
                nct dump $msgTable.netsh_firewall_dump
                nct help $msgTable.netsh_firewall_help
                nct set $msgTable.netsh_firewall_set
                nct show $msgTable.netsh_firewall_show
            }

            nct help $msgTable.netsh_help

            nct http $msgTable.netsh_http {
                nct add $msgTable.netsh_http_add {
                    nct cacheparam $msgTable.netsh_http_add_cacheparam
                    nct iplisten $msgTable.netsh_http_add_iplisten
                    nct sslcert $msgTable.netsh_http_add_sslcert
                    nct timeout $msgTable.netsh_http_add_timeout
                    nct urlacl $msgTable.netsh_http_add_urlacl
                }
                nct delete $msgTable.netsh_http_delete {
                    nct cache $msgTable.netsh_http_delete_cache
                    nct iplisten $msgTable.netsh_http_delete_iplisten
                    nct sslcert $msgTable.netsh_http_delete_sslcert
                    nct timeout $msgTable.netsh_http_delete_timeout
                    nct urlacl $msgTable.netsh_http_delete_urlacl
                }
                nct dump $msgTable.netsh_http_dump
                nct flush $msgTable.netsh_http_flush {
                    nct logbuffer $msgTable.netsh_http_flush_logbuffer
                }
                nct help $msgTable.netsh_http_help
                nct show $msgTable.netsh_http_show {
                    nct cacheparam $msgTable.netsh_http_show_cacheparam
                    nct cachestate $msgTable.netsh_http_show_cachestate
                    nct iplisten $msgTable.netsh_http_show_iplisten
                    nct servicestate $msgTable.netsh_http_show_servicestate
                    nct sslcert $msgTable.netsh_http_show_sslcert
                    nct timeout $msgTable.netsh_http_show_timeout
                    nct urlacl $msgTable.netsh_http_show_urlacl
                }
            }

            nct interface $msgTable.netsh_interface {
                nct dump $msgTable.netsh_interface_dump
                nct help $msgTable.netsh_interface_help
                nct httpstunnel $msgTable.netsh_interface_httpstunnel {
                    nct add $msgTable.netsh_interface_httpstunnel_add {
                        nct interface $msgTable.netsh_interface_httpstunnel_add_interface
                    }
                    nct delete $msgTable.netsh_interface_httpstunnel_delete {
                        nct interface $msgTable.netsh_interface_httpstunnel_delete_interface
                    }
                    nct dump $msgTable.netsh_interface_httpstunnel_dump
                    nct help $msgTable.netsh_interface_httpstunnel_help
                    nct reset $msgTable.netsh_interface_httpstunnel_reset
                    nct set $msgTable.netsh_interface_httpstunnel_set {
                        nct interface $msgTable.netsh_interface_httpstunnel_set_interface
                    }
                    nct show $msgTable.netsh_interface_httpstunnel_show {
                        nct interfaces $msgTable.netsh_interface_httpstunnel_show_interfaces
                        nct statistics $msgTable.netsh_interface_httpstunnel_show_statistics
                    }
                }
                nct isatap $msgTable.netsh_interface_isatap {
                    nct dump $msgTable.netsh_interface_isatap_dump
                    nct help $msgTable.netsh_interface_isatap_help
                    nct set $msgTable.netsh_interface_isatap_set {
                        nct router $msgTable.netsh_interface_isatap_set_router
                        nct state $msgTable.netsh_interface_isatap_set_state
                    }
                    nct show $msgTable.netsh_interface_isatap_show {
                        nct router $msgTable.netsh_interface_isatap_show_router
                        nct state $msgTable.netsh_interface_isatap_show_state
                    }
                }
                nct portproxy $msgTable.netsh_interface_portproxy {
                    nct add $msgTable.netsh_interface_portproxy_add
                    nct delete $msgTable.netsh_interface_portproxy_delete
                    nct dump $msgTable.netsh_interface_portproxy_dump
                    nct help $msgTable.netsh_interface_portproxy_help
                    nct reset $msgTable.netsh_interface_portproxy_reset
                    nct set $msgTable.netsh_interface_portproxy_set
                    nct show $msgTable.netsh_interface_portproxy_show {
                        nct all $msgTable.netsh_interface_portproxy_show_all
                    }
                }
                nct set $msgTable.netsh_interface_set {
                    nct interface $msgTable.netsh_interface_set_interface
                }
                nct show $msgTable.netsh_interface_show {
                    nct interface $msgTable.netsh_interface_show_interface
                }
                nct tcp $msgTable.netsh_interface_tcp {
                    nct add $msgTable.netsh_interface_tcp_add {
                        nct chimneyapplication $msgTable.netsh_interface_tcp_add_chimneyapplication
                        nct chimneyport $msgTable.netsh_interface_tcp_add_chimneyport
                        nct supplementalport $msgTable.netsh_interface_tcp_add_supplementalport
                        nct supplementalsubnet $msgTable.netsh_interface_tcp_add_supplementalsubnet
                    }
                    nct delete $msgTable.netsh_interface_tcp_delete {
                        nct chimneyapplication $msgTable.netsh_interface_tcp_delete_chimneyapplication
                        nct chimneyport $msgTable.netsh_interface_tcp_delete_chimneyport
                        nct supplementalport $msgTable.netsh_interface_tcp_delete_supplementalport
                        nct supplementalsubnet $msgTable.netsh_interface_tcp_delete_supplementalsubnet
                    }
                    nct dump $msgTable.netsh_interface_tcp_dump
                    nct help $msgTable.netsh_interface_tcp_help
                    nct reset $msgTable.netsh_interface_tcp_reset
                    nct set $msgTable.netsh_interface_tcp_set {
                        nct global $msgTable.netsh_interface_tcp_set_global
                        nct heuristics $msgTable.netsh_interface_tcp_set_heuristics
                        nct security $msgTable.netsh_interface_tcp_set_security
                        nct supplemental $msgTable.netsh_interface_tcp_set_supplemental
                    }
                    nct show $msgTable.netsh_interface_tcp_show {
                        nct chimneyapplications $msgTable.netsh_interface_tcp_show_chimneyapplications
                        nct chimneyports $msgTable.netsh_interface_tcp_show_chimneyports
                        nct chimneystats $msgTable.netsh_interface_tcp_show_chimneystats
                        nct global $msgTable.netsh_interface_tcp_show_global
                        nct heuristics $msgTable.netsh_interface_tcp_show_heuristics
                        nct netdmastats $msgTable.netsh_interface_tcp_show_netdmastats
                        nct rscstats $msgTable.netsh_interface_tcp_show_rscstats
                        nct security $msgTable.netsh_interface_tcp_show_security
                        nct supplemental $msgTable.netsh_interface_tcp_show_supplemental
                        nct supplementalports $msgTable.netsh_interface_tcp_show_supplementalports
                        nct supplementalsubnets $msgTable.netsh_interface_tcp_show_supplementalsubnets
                    }
                }
                nct teredo $msgTable.netsh_interface_teredo {
                    nct dump $msgTable.netsh_interface_teredo_dump
                    nct help $msgTable.netsh_interface_teredo_help
                    nct set $msgTable.netsh_interface_teredo_set {
                        nct state $msgTable.netsh_interface_teredo_set_state
                    }
                    nct show $msgTable.netsh_interface_teredo_show {
                        nct state $msgTable.netsh_interface_teredo_show_state
                    }
                }
            }

            nct ipsec $msgTable.netsh_ipsec {
                nct dump $msgTable.netsh_ipsec_dump
                nct dynamic $msgTable.netsh_ipsec_dynamic {
                    nct add $msgTable.netsh_ipsec_dynamic_add {
                        nct mmpolicy $msgTable.netsh_ipsec_dynamic_add_mmpolicy
                        nct qmpolicy $msgTable.netsh_ipsec_dynamic_add_qmpolicy
                        nct rule $msgTable.netsh_ipsec_dynamic_add_rule
                    }
                    nct delete $msgTable.netsh_ipsec_dynamic_delete {
                        nct all $msgTable.netsh_ipsec_dynamic_delete_all
                        nct mmpolicy $msgTable.netsh_ipsec_dynamic_delete_mmpolicy
                        nct qmpolicy $msgTable.netsh_ipsec_dynamic_delete_qmpolicy
                        nct rule $msgTable.netsh_ipsec_dynamic_delete_rule
                        nct sa $msgTable.netsh_ipsec_dynamic_delete_sa
                    }
                    nct dump $msgTable.netsh_ipsec_dynamic_dump
                    nct help $msgTable.netsh_ipsec_dynamic_help
                    nct set $msgTable.netsh_ipsec_dynamic_set {
                        nct config $msgTable.netsh_ipsec_dynamic_set_config
                        nct mmpolicy $msgTable.netsh_ipsec_dynamic_set_mmpolicy
                        nct qmpolicy $msgTable.netsh_ipsec_dynamic_set_qmpolicy
                        nct rule $msgTable.netsh_ipsec_dynamic_set_rule
                    }
                    nct show $msgTable.netsh_ipsec_dynamic_show {
                        nct all $msgTable.netsh_ipsec_dynamic_show_all
                        nct config $msgTable.netsh_ipsec_dynamic_show_config
                        nct mmfilter $msgTable.netsh_ipsec_dynamic_show_mmfilter
                        nct mmpolicy $msgTable.netsh_ipsec_dynamic_show_mmpolicy
                        nct mmsas $msgTable.netsh_ipsec_dynamic_show_mmsas
                        nct qmfilter $msgTable.netsh_ipsec_dynamic_show_qmfilter
                        nct qmpolicy $msgTable.netsh_ipsec_dynamic_show_qmpolicy
                        nct qmsas $msgTable.netsh_ipsec_dynamic_show_qmsas
                        nct rule $msgTable.netsh_ipsec_dynamic_show_rule
                    }
                }
                nct help $msgTable.netsh_ipsec_help
                nct static $msgTable.netsh_ipsec_static {
                    nct add $msgTable.netsh_ipsec_static_add {
                        nct filter $msgTable.netsh_ipsec_static_add_filter
                        nct filteraction $msgTable.netsh_ipsec_static_add_filteraction
                        nct filterlist $msgTable.netsh_ipsec_static_add_filterlist
                        nct policy $msgTable.netsh_ipsec_static_add_policy
                        nct rule $msgTable.netsh_ipsec_static_add_rule
                    }
                    nct delete $msgTable.netsh_ipsec_static_delete {
                        nct all $msgTable.netsh_ipsec_static_delete_all
                        nct filter $msgTable.netsh_ipsec_static_delete_filter
                        nct filteraction $msgTable.netsh_ipsec_static_delete_filteraction
                        nct filterlist $msgTable.netsh_ipsec_static_delete_filterlist
                        nct policy $msgTable.netsh_ipsec_static_delete_policy
                        nct rule $msgTable.netsh_ipsec_static_delete_rule
                    }
                    nct dump $msgTable.netsh_ipsec_static_dump
                    nct exportpolicy $msgTable.netsh_ipsec_static_exportpolicy
                    nct help $msgTable.netsh_ipsec_static_help
                    nct importpolicy $msgTable.netsh_ipsec_static_importpolicy
                    nct set $msgTable.netsh_ipsec_static_set {
                        nct batch $msgTable.netsh_ipsec_static_set_batch
                        nct defaultrule $msgTable.netsh_ipsec_static_set_defaultrule
                        nct filteraction $msgTable.netsh_ipsec_static_set_filteraction
                        nct filterlist $msgTable.netsh_ipsec_static_set_filterlist
                        nct policy $msgTable.netsh_ipsec_static_set_policy
                        nct rule $msgTable.netsh_ipsec_static_set_rule
                        nct store $msgTable.netsh_ipsec_static_set_store
                    }
                    nct show $msgTable.netsh_ipsec_static_show {
                        nct all $msgTable.netsh_ipsec_static_show_all
                        nct filteraction $msgTable.netsh_ipsec_static_show_filteraction
                        nct filterlist $msgTable.netsh_ipsec_static_show_filterlist
                        nct gpoassignedpolicy $msgTable.netsh_ipsec_static_show_gpoassignedpolicy
                        nct policy $msgTable.netsh_ipsec_static_show_policy
                        nct rule $msgTable.netsh_ipsec_static_show_rule
                        nct store $msgTable.netsh_ipsec_static_show_store
                    }
                }
            }

            nct lan $msgTable.netsh_lan {
                nct add $msgTable.netsh_lan_add {
                    nct profile $msgTable.netsh_lan_add_profile
                }
                nct delete $msgTable.netsh_lan_delete {
                    nct profile $msgTable.netsh_lan_delete_profile
                }
                nct dump $msgTable.netsh_lan_dump
                nct export $msgTable.netsh_lan_export {
                    nct profile $msgTable.netsh_lan_export_profile
                }
                nct help $msgTable.netsh_lan_help
                nct reconnect $msgTable.netsh_lan_reconnect
                nct set $msgTable.netsh_lan_set {
                    nct allowexplicitcreds $msgTable.netsh_lan_set_allowexplicitcreds
                    nct autoconfig $msgTable.netsh_lan_set_autoconfig
                    nct blockperiod $msgTable.netsh_lan_set_blockperiod
                    nct eapuserdata $msgTable.netsh_lan_set_eapuserdata
                    nct profileparameter $msgTable.netsh_lan_set_profileparameter
                    nct tracing $msgTable.netsh_lan_set_tracing
                }
                nct show $msgTable.netsh_lan_show {
                    nct interfaces $msgTable.netsh_lan_show_interfaces
                    nct profiles $msgTable.netsh_lan_show_profiles
                    nct settings $msgTable.netsh_lan_show_settings
                    nct tracing $msgTable.netsh_lan_show_tracing
                }
            }

            nct mbn $msgTable.netsh_mbn {
                nct add $msgTable.netsh_mbn_add {
                    nct profile $msgTable.netsh_mbn_add_profile
                }
                nct connect $msgTable.netsh_mbn_connect
                nct delete $msgTable.netsh_mbn_delete {
                    nct profile $msgTable.netsh_mbn_delete_profile
                }
                nct disconnect $msgTable.netsh_mbn_disconnect
                nct dump $msgTable.netsh_mbn_dump
                nct help $msgTable.netsh_mbn_help
                nct set $msgTable.netsh_mbn_set {
                    nct profileparameter $msgTable.netsh_mbn_set_profileparameter
                    nct tracing $msgTable.netsh_mbn_set_tracing
                }
                nct show $msgTable.netsh_mbn_show {
                    nct capability $msgTable.netsh_mbn_show_capability
                    nct connection $msgTable.netsh_mbn_show_connection
                    nct homeprovider $msgTable.netsh_mbn_show_homeprovider
                    nct interfaces $msgTable.netsh_mbn_show_interfaces
                    nct pin $msgTable.netsh_mbn_show_pin
                    nct pinlist $msgTable.netsh_mbn_show_pinlist
                    nct preferredproviders $msgTable.netsh_mbn_show_preferredproviders
                    nct profiles $msgTable.netsh_mbn_show_profiles
                    nct provisionedcontexts $msgTable.netsh_mbn_show_provisionedcontexts
                    nct radio $msgTable.netsh_mbn_show_radio
                    nct readyinfo $msgTable.netsh_mbn_show_readyinfo
                    nct signal $msgTable.netsh_mbn_show_signal
                    nct smsconfig $msgTable.netsh_mbn_show_smsconfig
                    nct tracing $msgTable.netsh_mbn_show_tracing
                    nct visibleproviders $msgTable.netsh_mbn_show_visibleproviders
                }
            }

            nct namespace $msgTable.netsh_namespace {
                nct dump $msgTable.netsh_namespace_dump
                nct help $msgTable.netsh_namespace_help
                nct show $msgTable.netsh_namespace_show {
                    nct effectivepolicy $msgTable.netsh_namespace_show_effectivepolicy
                    nct policy $msgTable.netsh_namespace_show_policy
                }
            }

            nct nap $msgTable.netsh_nap {
                nct client $msgTable.netsh_nap_client {
                    nct add $msgTable.netsh_nap_client_add {
                        nct server $msgTable.netsh_nap_client_add_server
                        nct trustedservergroup $msgTable.netsh_nap_client_add_trustedservergroup
                    }
                    nct delete $msgTable.netsh_nap_client_delete {
                        nct server $msgTable.netsh_nap_client_delete_server
                        nct trustedservergroup $msgTable.netsh_nap_client_delete_trustedservergroup
                    }
                    nct dump $msgTable.netsh_nap_client_dump
                    nct export $msgTable.netsh_nap_client_export
                    nct help $msgTable.netsh_nap_client_help
                    nct import $msgTable.netsh_nap_client_import
                    nct rename $msgTable.netsh_nap_client_rename {
                        nct server $msgTable.netsh_nap_client_rename_server
                        nct trustedservergroup $msgTable.netsh_nap_client_rename_trustedservergroup
                    }
                    nct reset $msgTable.netsh_nap_client_reset {
                        nct configuration $msgTable.netsh_nap_client_reset_configuration
                        nct csp $msgTable.netsh_nap_client_reset_csp
                        nct enforcement $msgTable.netsh_nap_client_reset_enforcement
                        nct hash $msgTable.netsh_nap_client_reset_hash
                        nct server $msgTable.netsh_nap_client_reset_server
                        nct tracing $msgTable.netsh_nap_client_reset_tracing
                        nct trustedservergroup $msgTable.netsh_nap_client_reset_trustedservergroup
                        nct userinterface $msgTable.netsh_nap_client_reset_userinterface
                    }
                    nct set $msgTable.netsh_nap_client_set {
                        nct csp $msgTable.netsh_nap_client_set_csp
                        nct enforcement $msgTable.netsh_nap_client_set_enforcement
                        nct hash $msgTable.netsh_nap_client_set_hash
                        nct server $msgTable.netsh_nap_client_set_server
                        nct tracing $msgTable.netsh_nap_client_set_tracing
                        nct userinterface $msgTable.netsh_nap_client_set_userinterface
                    }
                    nct show $msgTable.netsh_nap_client_show {
                        nct configuration $msgTable.netsh_nap_client_show_configuration
                        nct csps $msgTable.netsh_nap_client_show_csps
                        nct grouppolicy $msgTable.netsh_nap_client_show_grouppolicy
                        nct hashes $msgTable.netsh_nap_client_show_hashes
                        nct state $msgTable.netsh_nap_client_show_state
                        nct trustedservergroup $msgTable.netsh_nap_client_show_trustedservergroup
                    }
                }
                nct dump $msgTable.netsh_nap_dump
                nct help $msgTable.netsh_nap_help
                nct hra $msgTable.netsh_nap_hra
                nct reset $msgTable.netsh_nap_reset {
                    nct configuration $msgTable.netsh_nap_reset_configuration
                }
                nct show $msgTable.netsh_nap_show {
                    nct configuration $msgTable.netsh_nap_show_configuration
                }
            }

            nct netio $msgTable.netsh_netio {
                nct add $msgTable.netsh_netio_add {
                    nct bindingfilter $msgTable.netsh_netio_add_bindingfilter
                }
                nct delete $msgTable.netsh_netio_delete {
                    nct bindingfilter $msgTable.netsh_netio_delete_bindingfilter
                }
                nct dump $msgTable.netsh_netio_dump
                nct help $msgTable.netsh_netio_help
                nct show $msgTable.netsh_netio_show {
                    nct bindingfilters $msgTable.netsh_netio_show_bindingfilters
                }
            }

            nct ras $msgTable.netsh_ras {
                nct aaaa $msgTable.netsh_ras_aaaa {
                    nct add $msgTable.netsh_ras_aaaa_add {
                        nct acctserver $msgTable.netsh_ras_aaaa_add_acctserver
                        nct authserver $msgTable.netsh_ras_aaaa_add_authserver
                    }
                    nct delete $msgTable.netsh_ras_aaaa_delete {
                        nct acctserver $msgTable.netsh_ras_aaaa_delete_acctserver
                        nct authserver $msgTable.netsh_ras_aaaa_delete_authserver
                    }
                    nct dump $msgTable.netsh_ras_aaaa_dump
                    nct help $msgTable.netsh_ras_aaaa_help
                    nct set $msgTable.netsh_ras_aaaa_set {
                        nct accounting $msgTable.netsh_ras_aaaa_set_accounting
                        nct acctserver $msgTable.netsh_ras_aaaa_set_acctserver
                        nct authentication $msgTable.netsh_ras_aaaa_set_authentication
                        nct authserver $msgTable.netsh_ras_aaaa_set_authserver
                        nct ipsecpolicy $msgTable.netsh_ras_aaaa_set_ipsecpolicy
                    }
                    nct show $msgTable.netsh_ras_aaaa_show {
                        nct accounting $msgTable.netsh_ras_aaaa_show_accounting
                        nct acctserver $msgTable.netsh_ras_aaaa_show_acctserver
                        nct authentication $msgTable.netsh_ras_aaaa_show_authentication
                        nct authserver $msgTable.netsh_ras_aaaa_show_authserver
                        nct ipsecpolicy $msgTable.netsh_ras_aaaa_show_ipsecpolicy
                    }
                }
                nct add $msgTable.netsh_ras_add {
                    nct authtype $msgTable.netsh_ras_add_authtype
                    nct link $msgTable.netsh_ras_add_link
                    nct multilink $msgTable.netsh_ras_add_multilink
                    nct registeredserver $msgTable.netsh_ras_add_registeredserver
                }
                nct delete $msgTable.netsh_ras_delete {
                    nct authtype $msgTable.netsh_ras_delete_authtype
                    nct link $msgTable.netsh_ras_delete_link
                    nct multilink $msgTable.netsh_ras_delete_multilink
                    nct registeredserver $msgTable.netsh_ras_delete_registeredserver
                }
                nct diagnostics $msgTable.netsh_ras_diagnostics {
                    nct dump $msgTable.netsh_ras_diagnostics_dump
                    nct help $msgTable.netsh_ras_diagnostics_help
                    nct set $msgTable.netsh_ras_diagnostics_set {
                        nct cmtracing $msgTable.netsh_ras_diagnostics_set_cmtracing
                        nct loglevel $msgTable.netsh_ras_diagnostics_set_loglevel
                        nct modemtracing $msgTable.netsh_ras_diagnostics_set_modemtracing
                        nct rastracing $msgTable.netsh_ras_diagnostics_set_rastracing
                        nct securityeventlog $msgTable.netsh_ras_diagnostics_set_securityeventlog
                        nct tracefacilities $msgTable.netsh_ras_diagnostics_set_tracefacilities
                    }
                    nct show $msgTable.netsh_ras_diagnostics_show {
                        nct all $msgTable.netsh_ras_diagnostics_show_all
                        nct cmtracing $msgTable.netsh_ras_diagnostics_show_cmtracing
                        nct configuration $msgTable.netsh_ras_diagnostics_show_configuration
                        nct installation $msgTable.netsh_ras_diagnostics_show_installation
                        nct loglevel $msgTable.netsh_ras_diagnostics_show_loglevel
                        nct logs $msgTable.netsh_ras_diagnostics_show_logs
                        nct modemtracing $msgTable.netsh_ras_diagnostics_show_modemtracing
                        nct rastracing $msgTable.netsh_ras_diagnostics_show_rastracing
                        nct securityeventlog $msgTable.netsh_ras_diagnostics_show_securityeventlog
                        nct tracefacilities $msgTable.netsh_ras_diagnostics_show_tracefacilities
                    }
                }
                nct dump $msgTable.netsh_ras_dump
                nct help $msgTable.netsh_ras_help
                nct ip $msgTable.netsh_ras_ip {
                    nct add $msgTable.netsh_ras_ip_add {
                        nct range $msgTable.netsh_ras_ip_add_range
                    }
                    nct delete $msgTable.netsh_ras_ip_delete {
                        nct pool $msgTable.netsh_ras_ip_delete_pool
                        nct range $msgTable.netsh_ras_ip_delete_range
                    }
                    nct dump $msgTable.netsh_ras_ip_dump
                    nct help $msgTable.netsh_ras_ip_help
                    nct set $msgTable.netsh_ras_ip_set {
                        nct access $msgTable.netsh_ras_ip_set_access
                        nct addrassign $msgTable.netsh_ras_ip_set_addrassign
                        nct addrreq $msgTable.netsh_ras_ip_set_addrreq
                        nct broadcastnameresolution $msgTable.netsh_ras_ip_set_broadcastnameresolution
                        nct negotiation $msgTable.netsh_ras_ip_set_negotiation
                        nct preferredadapter $msgTable.netsh_ras_ip_set_preferredadapter
                    }
                    nct show $msgTable.netsh_ras_ip_show {
                        nct config $msgTable.netsh_ras_ip_show_config
                        nct preferredadapter $msgTable.netsh_ras_ip_show_preferredadapter
                    }
                }
                nct set $msgTable.netsh_ras_set {
                    nct authmode $msgTable.netsh_ras_set_authmode
                    nct client $msgTable.netsh_ras_set_client
                    nct conf $msgTable.netsh_ras_set_conf
                    nct portstatus $msgTable.netsh_ras_set_portstatus
                    nct type $msgTable.netsh_ras_set_type
                    nct user $msgTable.netsh_ras_set_user
                    nct wanports $msgTable.netsh_ras_set_wanports
                }
                nct show $msgTable.netsh_ras_show {
                    nct activeservers $msgTable.netsh_ras_show_activeservers
                    nct authmode $msgTable.netsh_ras_show_authmode
                    nct authtype $msgTable.netsh_ras_show_authtype
                    nct client $msgTable.netsh_ras_show_client
                    nct conf $msgTable.netsh_ras_show_conf
                    nct link $msgTable.netsh_ras_show_link
                    nct multilink $msgTable.netsh_ras_show_multilink
                    nct portstatus $msgTable.netsh_ras_show_portstatus
                    nct registeredserver $msgTable.netsh_ras_show_registeredserver
                    nct status $msgTable.netsh_ras_show_status
                    nct type $msgTable.netsh_ras_show_type
                    nct user $msgTable.netsh_ras_show_user
                    nct wanports $msgTable.netsh_ras_show_wanports
                }
            }

            nct rpc $msgTable.netsh_rpc {
                nct add $msgTable.netsh_rpc_add
                nct delete $msgTable.netsh_rpc_delete
                nct dump $msgTable.netsh_rpc_dump
                nct filter $msgTable.netsh_rpc_filter {
                    nct add $msgTable.netsh_rpc_filter_add {
                        nct condition $msgTable.netsh_rpc_filter_add_condition
                        nct filter $msgTable.netsh_rpc_filter_add_filter
                        nct rule $msgTable.netsh_rpc_filter_add_rule
                    }
                    nct delete $msgTable.netsh_rpc_filter_delete {
                        nct filter $msgTable.netsh_rpc_filter_delete_filter
                        nct rule $msgTable.netsh_rpc_filter_delete_rule
                    }
                    nct dump $msgTable.netsh_rpc_filter_dump
                    nct help $msgTable.netsh_rpc_filter_help
                    nct show $msgTable.netsh_rpc_filter_show {
                        nct filter $msgTable.netsh_rpc_filter_show_filter
                    }
                }
                nct help $msgTable.netsh_rpc_help
                nct reset $msgTable.netsh_rpc_reset
                nct show $msgTable.netsh_rpc_show
            }

            nct set $msgTable.netsh_set {
                nct machine $msgTable.netsh_set_machine
            }

            nct show $msgTable.netsh_show {
                nct alias $msgTable.netsh_show_alias
                nct helper $msgTable.netsh_show_helper
            }

            nct trace $msgTable.netsh_trace {
                nct convert $msgTable.netsh_trace_convert
                nct correlate $msgTable.netsh_trace_correlate
                nct diagnose $msgTable.netsh_trace_diagnose
                nct dump $msgTable.netsh_trace_dump
                nct help $msgTable.netsh_trace_help
                nct show $msgTable.netsh_trace_show {
                    nct CaptureFilterHelp $msgTable.netsh_trace_show_CaptureFilterHelp
                    nct globalKeywordsAndLevels $msgTable.netsh_trace_show_globalKeywordsAndLevels
                    nct helperclass $msgTable.netsh_trace_show_helperclass
                    nct interfaces $msgTable.netsh_trace_show_interfaces
                    nct provider $msgTable.netsh_trace_show_provider
                    nct providers $msgTable.netsh_trace_show_providers
                    nct scenario $msgTable.netsh_trace_show_scenario
                    nct scenarios $msgTable.netsh_trace_show_scenarios
                    nct status $msgTable.netsh_trace_show_status
                }
                nct start $msgTable.netsh_trace_start
                nct stop $msgTable.netsh_trace_stop
            }

            nct wcn $msgTable.netsh_wcn {
                nct dump $msgTable.netsh_wcn_dump
                nct enroll $msgTable.netsh_wcn_enroll
                nct help $msgTable.netsh_wcn_help
                nct query $msgTable.netsh_wcn_query
            }

            nct wfp $msgTable.netsh_wfp {
                nct capture $msgTable.netsh_wfp_capture {
                    nct start $msgTable.netsh_wfp_capture_start
                    nct status $msgTable.netsh_wfp_capture_status
                    nct stop $msgTable.netsh_wfp_capture_stop
                }
                nct dump $msgTable.netsh_wfp_dump
                nct help $msgTable.netsh_wfp_help
                nct set $msgTable.netsh_wfp_set {
                    nct options $msgTable.netsh_wfp_set_options
                }
                nct show $msgTable.netsh_wfp_show {
                    nct appid $msgTable.netsh_wfp_show_appid
                    nct boottimepolicy $msgTable.netsh_wfp_show_boottimepolicy
                    nct filters $msgTable.netsh_wfp_show_filters
                    nct netevents $msgTable.netsh_wfp_show_netevents
                    nct options $msgTable.netsh_wfp_show_options
                    nct security $msgTable.netsh_wfp_show_security
                    nct state $msgTable.netsh_wfp_show_state
                    nct sysports $msgTable.netsh_wfp_show_sysports
                }
            }

            nct winhttp $msgTable.netsh_winhttp {
                nct dump $msgTable.netsh_winhttp_dump
                nct help $msgTable.netsh_winhttp_help
                nct import $msgTable.netsh_winhttp_import {
                    nct proxy $msgTable.netsh_winhttp_import_proxy
                }
                nct reset $msgTable.netsh_winhttp_reset {
                    nct proxy $msgTable.netsh_winhttp_reset_proxy
                    nct tracing $msgTable.netsh_winhttp_reset_tracing
                }
                nct set $msgTable.netsh_winhttp_set {
                    nct proxy $msgTable.netsh_winhttp_set_proxy
                    nct tracing $msgTable.netsh_winhttp_set_tracing
                }
                nct show $msgTable.netsh_winhttp_show {
                    nct proxy $msgTable.netsh_winhttp_show_proxy
                    nct tracing $msgTable.netsh_winhttp_show_tracing
                }
            }

            nct winsock $msgTable.netsh_winsock {
                nct audit $msgTable.netsh_winsock_audit {
                    nct trail $msgTable.netsh_winsock_audit_trail
                }
                nct dump $msgTable.netsh_winsock_dump
                nct help $msgTable.netsh_winsock_help
                nct remove $msgTable.netsh_winsock_remove {
                    nct provider $msgTable.netsh_winsock_remove_provider
                }
                nct reset $msgTable.netsh_winsock_reset
                nct set $msgTable.netsh_winsock_set {
                    nct autotuning $msgTable.netsh_winsock_set_autotuning
                }
                nct show $msgTable.netsh_winsock_show {
                    nct autotuning $msgTable.netsh_winsock_show_autotuning
                    nct catalog $msgTable.netsh_winsock_show_catalog
                }
            }

            nct wlan $msgTable.netsh_wlan {
                nct add $msgTable.netsh_wlan_add {
                    nct filter $msgTable.netsh_wlan_add_filter
                    nct profile $msgTable.netsh_wlan_add_profile
                }
                nct connect $msgTable.netsh_wlan_connect
                nct delete $msgTable.netsh_wlan_delete {
                    nct filter $msgTable.netsh_wlan_delete_filter
                    nct profile $msgTable.netsh_wlan_delete_profile
                }
                nct disconnect $msgTable.netsh_wlan_disconnect
                nct dump $msgTable.netsh_wlan_dump
                nct export $msgTable.netsh_wlan_export {
                    nct hostednetworkprofile $msgTable.netsh_wlan_export_hostednetworkprofile
                    nct profile $msgTable.netsh_wlan_export_profile
                }
                nct help $msgTable.netsh_wlan_help
                nct refresh $msgTable.netsh_wlan_refresh {
                    nct hostednetwork $msgTable.netsh_wlan_refresh_hostednetwork
                }
                nct reportissues $msgTable.netsh_wlan_reportissues
                nct set $msgTable.netsh_wlan_set {
                    nct allowexplicitcreds $msgTable.netsh_wlan_set_allowexplicitcreds
                    nct autoconfig $msgTable.netsh_wlan_set_autoconfig
                    nct blockednetworks $msgTable.netsh_wlan_set_blockednetworks
                    nct blockperiod $msgTable.netsh_wlan_set_blockperiod
                    nct createalluserprofile $msgTable.netsh_wlan_set_createalluserprofile
                    nct hostednetwork $msgTable.netsh_wlan_set_hostednetwork
                    nct profileorder $msgTable.netsh_wlan_set_profileorder
                    nct profileparameter $msgTable.netsh_wlan_set_profileparameter
                    nct profiletype $msgTable.netsh_wlan_set_profiletype
                    nct tracing $msgTable.netsh_wlan_set_tracing
                }
                nct show $msgTable.netsh_wlan_show {
                    nct all $msgTable.netsh_wlan_show_all
                    nct allowexplicitcreds $msgTable.netsh_wlan_show_allowexplicitcreds
                    nct autoconfig $msgTable.netsh_wlan_show_autoconfig
                    nct blockednetworks $msgTable.netsh_wlan_show_blockednetworks
                    nct createalluserprofile $msgTable.netsh_wlan_show_createalluserprofile
                    nct drivers $msgTable.netsh_wlan_show_drivers
                    nct filters $msgTable.netsh_wlan_show_filters
                    nct hostednetwork $msgTable.netsh_wlan_show_hostednetwork
                    nct interfaces $msgTable.netsh_wlan_show_interfaces
                    nct networks $msgTable.netsh_wlan_show_networks
                    nct onlyUseGPProfilesforAllowedNetworks $msgTable.netsh_wlan_show_onlyUseGPProfilesforAllowedNetworks
                    nct profiles $msgTable.netsh_wlan_show_profiles
                    nct settings $msgTable.netsh_wlan_show_settings
                    nct tracing $msgTable.netsh_wlan_show_tracing
                }
                nct start $msgTable.netsh_wlan_start {
                    nct hostednetwork $msgTable.netsh_wlan_start_hostednetwork
                }
                nct stop $msgTable.netsh_wlan_stop {
                    nct hostednetwork $msgTable.netsh_wlan_stop_hostednetwork
                }
            }
        }

        Set-CompletionPrivateData -Key NetshExeCompletionCommandTree -Value $commandTree
    }

    Get-CommandTreeCompletion $wordToComplete $commandAst $commandTree
}

#
# .SYNOPSIS
#
#     Complete parameters and arguments to bcedit.exe
#
function BCDEditExeCompletion
{
    [ArgumentCompleter(
        Native,
        Command = 'bcdedit',
        Description = 'Complete arguments to bcdedit.exe')]
    param($wordToComplete, $commandAst)

    $BCDEditSwitches = Get-CompletionPrivateData -Key BCDEdit
    if ($null -eq $BCDEditSwitches)
    {
        # This is a very naive implementation - parse the output of bcdedit
        # run a couple different ways to collect candidate completions.

        $switches = bcdedit /? 2>$null | ForEach-Object { [regex]::Matches($_, '/\w+').Value } | Sort-Object -Unique
        $switches += '/?'

        $nestedSwitches = @()
        foreach ($switch in $switches)
        {
            $nestedSwitches += bcdedit /? $switch 2>$null | ForEach-Object { [regex]::Matches($_, '/\w+').Value }
        }
    
        $BCDEditSwitches = ($switches += $nestedSwitches) | Sort-Object -Unique
        Set-CompletionPrivateData -Key BCDEdit -Value $BCDEditSwitches
    }

    $BCDEditSwitches |
        Where-Object { $_ -like "$wordToComplete*" } |
        ForEach-Object { New-CompletionResult $_ }

    # Also complete GUIDs and named configs - don't cache these, they might change
    # TODO: This can be smarter, I think it can suggest things that don't work.
    # TODO: THe following doesn't do anything useful if the process isn't elevated.
    bcdedit /ENUM 2>$null |
        ForEach-Object { [regex]::Matches($_, '\{[\w-]+\}').Value } |
        Sort-Object -Unique |
        Where-Object { $_ -like "$wordToComplete*" } |
        ForEach-Object { New-CompletionResult $_ }
}
