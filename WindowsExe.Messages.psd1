
@{

net_ACCOUNTS = @'
The syntax of this command is:

NET ACCOUNTS
[/FORCELOGOFF:{minutes | NO}] [/MINPWLEN:length]
              [/MAXPWAGE:{days | UNLIMITED}] [/MINPWAGE:days]
              [/UNIQUEPW:number] [/DOMAIN]

NET ACCOUNTS updates the user accounts database and modifies password
and logon requirements for all accounts.
When used without options, NET ACCOUNTS displays the current settings for
password, logon limitations, and domain information.

Two conditions are required in order for options used with
NET ACCOUNTS to take effect:

-  The password and logon requirements are only effective if user
   accounts have been set up (use User Manager or the NET USER command).

-  The NetLogon service must be running on all servers in the domain
   that verify logon. NetLogon is started automatically when Windows
   starts.
'@

net_ACCOUNTS_FORCELOGOFF = @'
/FORCELOGOFF:{minutes | NO}   Sets the number of minutes a user has
                              before being forced to log off when the
                              account expires or valid logon hours expire.
                              NO, the default, prevents forced logoff.
'@

net_ACCOUNTS_MINPWLEN = @'
/MINPWLEN:length              Sets the minimum number of characters for
                              a password. The range is 0-14 characters;
                              the default is 6 characters.
'@

net_ACCOUNTS_MAXPWAGE = @'
/MAXPWAGE:{days | UNLIMITED}  Sets the maximum number of days that a
                              password is valid. No limit is specified
                              by using UNLIMITED. /MAXPWAGE can't be less
                              than /MINPWAGE. The range is 1-999; the
                              default is to leave the value unchanged.
'@

net_ACCOUNTS_MINPWAGE = @'
/MINPWAGE:days                Sets the minimum number of days that must
                              pass before a user can change a password.
                              A value of 0 sets no minimum time. The range
                              is 0-999; the default is 0 days. /MINPWAGE
                              can't be more than /MAXPWAGE.
'@

net_ACCOUNTS_UNIQUEPW = @'
/UNIQUEPW:number              Requires that a user's passwords be unique
                              through the specified number of password
                              changes. The maximum value is 24.
'@

net_ACCOUNTS_DOMAIN = @'
/DOMAIN                       Performs the operation on a domain
                              controller of the current domain. Otherwise,
                              the operation is performed on the local
                              computer.
'@

net_COMPUTER = @'
The syntax of this command is:

NET COMPUTER
\\computername {/ADD | /DEL}

 NET COMPUTER adds or deletes computers from a domain database. This
 command is available only on Windows NT Servers.
'@

net_COMPUTER_ADD = 'Adds the specified computer to the domain.'

net_COMPUTER_DEL = 'Removes the specified computer from the domain.'

net_CONFIG = @'
NET CONFIG
[SERVER | WORKSTATION]

NET CONFIG displays configuration information of the Workstation or
Server service. When used without the SERVER or WORKSTATION switch,
it displays a list of configurable services. To get help with
configuring a service, type NET HELP CONFIG service.
'@

net_CONFIG_SERVER = @'
SERVER        Displays information about the configuration of
              the Server service.
'@

net_CONFIG_WORKSTATION = @'
WORKSTATION   Displays information about the configuration of
              the Workstation service.
'@

net_CONTINUE = 'NET CONTINUE reactivates a Windows service that has been suspended by NET PAUSE.'

net_FILE = @'
The syntax of this command is:

NET FILE
[id [/CLOSE]]

NET FILE closes a shared file and removes file locks. When used without
options, it lists the open files on a server. The listing includes the
identification number assigned to an open file, the pathname of the file,
the username, and the number of locks on the file.

This command works only on computers running the Server service.
'@

net_FILE_CLOSE = @'
/CLOSE  Closes an open file and removes file locks. Type this command
        from the server where the file is shared.
'@

net_GROUP = @'
The syntax of this command is:

NET GROUP
[groupname [/COMMENT:"text"]] [/DOMAIN]
             groupname {/ADD [/COMMENT:"text"] | /DELETE}  [/DOMAIN]
             groupname username [...] {/ADD | /DELETE} [/DOMAIN]

NET GROUP adds, displays, or modifies global groups on servers. Used
without parameters, it displays the groupnames on the server.
'@

net_GROUP_COMMENT = @'
/COMMENT:"text"  Adds a comment for a new or existing group.
                 Enclose the text in quotation marks.
'@

net_GROUP_DOMAIN = @'
/DOMAIN          Performs the operation on a domain controller
                 of the current domain. Otherwise, the operation is
                 performed on the local computer.
'@

net_GROUP_ADD = @'
/ADD             Adds a group, or adds a username to a group.
'@

net_GROUP_DELETE = @'
/DELETE          Removes a group, or removes a username from a group.
'@

net_HELP = 'NET HELP displays usage help for NET'

net_HELP_COMMAND = 'Usage help for the command: '

net_HELP_NAMES = @'
NET HELP NAMES explains different types of names in NET HELP syntax lines.
'@

net_HELP_SERVICES = @'
NET HELP SERVICES lists some of the services you can start.    
'@

net_HELP_SYNTAX = @'
NET HELP SERVICES lists some of the services you can start.
'@

net_HELPMSG = @'
The syntax of this command is:

NET HELPMSG
message#

NET HELPMSG displays information about Windows network messages
(such as error, warning, and alert messages). When you type NET HELPMSG and
the numerical error (for example, "net helpmsg 2182"), Windows tells you
about the message and suggests actions you can take to solve the problem.

message#  Is the numerical Windows error with which you need help.
'@

net_LOCALGROUP = @'
The syntax of this command is:

NET LOCALGROUP
[groupname [/COMMENT:"text"]] [/DOMAIN]
              groupname {/ADD [/COMMENT:"text"] | /DELETE}  [/DOMAIN]
              groupname name [...] {/ADD | /DELETE} [/DOMAIN]

NET LOCALGROUP modifies local groups on computers. When used without
options, it displays the local groups on the computer.

groupname        Is the name of the local group to add, expand, or
                 delete. Supply only a groupname to view a list of
                 users or global groups in a local group.
'@

net_LOCALGROUP_COMMENT = @'
/COMMENT:"text"  Adds a comment for a new or existing group.
                 Enclose the text in quotation marks.
'@

net_LOCALGROUP_DOMAIN = @'
/DOMAIN          Performs the operation on the domain controller
                 of the current domain. Otherwise, the operation is
                 performed on the local workstation.
'@

net_LOCALGROUP_ADD = @'
/ADD             Adds a groupname or username to a local group. An account
                 must be established for users or global groups added to a
                 local group with this command.
'@

net_LOCALGROUP_DELETE = @'
/DELETE          Removes a groupname or username from a local group.
'@

net_PAUSE = 'NET PAUSE suspends a Windows service or resource. Pausing a service puts it on hold.'

net_SESSION = @'
The syntax of this command is:

NET SESSION
[\\computername] [/DELETE] [/LIST]

NET SESSION lists or disconnects sessions between the computer and other
computers on the network. When used without options, it displays information
about all sessions with the computer of current focus.

This command works only on servers.
'@

net_SESSION_DELETE = @'
/DELETE         Ends the session between the local computer and
                computername, and closes all open files on the computer
                for the session. If computername is omitted,
                all sessions are ended.
'@

net_SESSION_LIST = @'
/LIST           Displays information in a list rather than a table.
'@

net_SHARE = @'
The syntax of this command is:

NET SHARE
sharename
          sharename=drive:path [/GRANT:user,[READ | CHANGE | FULL]]
                               [/USERS:number | /UNLIMITED]
                               [/REMARK:"text"]
                               [/CACHE:Manual | Documents| Programs | BranchCache | None]
          sharename [/USERS:number | /UNLIMITED]
                    [/REMARK:"text"]
                    [/CACHE:Manual | Documents | Programs | BranchCache | None]
          {sharename | devicename | drive:path} /DELETE
          sharename \\computername /DELETE

NET SHARE makes a server's resources available to network users. When
used without options, it lists information about all resources being
shared on the computer. For each resource, Windows reports the
devicename(s) or pathname(s) and a descriptive comment associated with it.

sharename          Is the network name of the shared resource. Type
                   NET SHARE with a sharename only to display information
                   about that share.
drive:path         Specifies the absolute path of the directory to
                   be shared.
'@

net_SHARE_GRANT = @'
/GRANT:user,perm   Creates the share with a security descriptor that gives
                   the requested permissions to the specified user.  This
                   option may be used more than once to give share permissions
                   to multiple users.
'@

net_SHARE_USERS = @'
/USERS:number      Sets the maximum number of users who can
                   simultaneously access the shared resource.
'@

net_SHARE_UNLIMITED = @'
/UNLIMITED         Specifies an unlimited number of users can
                   simultaneously access the shared resource
'@

net_SHARE_REMARK = @'
/REMARK:"text"     Adds a descriptive comment about the resource.
                   Enclose the text in quotation marks.
'@

net_SHARE_DELETE = @'
/DELETE            Stops sharing the resource.
'@

net_SHARE_CACHE_Manual = @'
/CACHE:Manual      Enables manual client caching of programs and documents
                   from this share
'@

net_SHARE_CACHE_Documents = @'
/CACHE:Documents   Enables automatic caching of documents from this share
'@

net_SHARE_CACHE_Programs = @'
/CACHE:Programs    Enables automatic caching of documents and programs
                   from this share
'@

net_SHARE_CACHE_BranchCache = @'
/CACHE:BranchCache Manual caching of documents with BranchCache enabled
                   from this share
'@

net_SHARE_CACHE_None = @'
/CACHE:None        Disables caching from this share
'@


net_START = 'Start a Windows service'

net_STATISTICS = @'
NET STATISTICS displays the statistics log for the local Workstation or Server service.
Used without parameters, NET STATISTICS displays the services for which statistics are available.
'@

net_STATISTICS_SERVER = 'Displays the Server service statistics.'

net_STATISTICS_WORKSTATION = 'Displays the Workstation service statistics.'

net_STOP = 'Stop a Windows service'

net_TIME = @'
The syntax of this command is:

NET TIME

[\\computername | /DOMAIN[:domainname] | /RTSDOMAIN[:domainname]] [/SET]

NET TIME synchronizes the computer's clock with that of another computer
or domain, or displays the time for a computer or domain. When used without
options on a Windows Server domain, it displays the current
date and time at the computer designated as the time server for the domain.

\\computername  Is the name of the computer you want to check or
                synchronize with.
'@

net_TIME_DOMAIN = @'
/DOMAIN[:domainname]  Specifies to synchronize the time from the Primary Domain
                      Controller of domainname.
'@

net_TIME_RTSDOMAIN = @'
/RTSDOMAIN[:domainname]  Specifies to synchronize with a Reliable Time Server
                         from domainname.
'@

net_TIME_SET = @'
/SET            Synchronizes the computer's time with the time
                on the specified computer or domain.
'@

net_USE = @'
The syntax of this command is:

NET USE
[devicename | *] [\\computername\sharename[\volume] [password | *]]
        [/USER:[domainname\]username]
        [/USER:[dotted domain name\]username]
        [/USER:[username@dotted domain name]
        [/SMARTCARD]
        [/SAVECRED]
        [[/DELETE] | [/PERSISTENT:{YES | NO}]]

NET USE {devicename | *} [password | *] /HOME

NET USE [/PERSISTENT:{YES | NO}]

NET USE connects a computer to a shared resource or disconnects a
computer from a shared resource. When used without options, it lists
the computer's connections.

devicename       Assigns a name to connect to the resource or specifies
                 the device to be disconnected. There are two kinds of
                 devicenames: disk drives (D: through Z:) and printers
                 (LPT1: through LPT3:). Type an asterisk instead of a
                 specific devicename to assign the next available
                 devicename.
\\computername   Is the name of the computer controlling the shared
                 resource. If the computername contains blank characters,
                 enclose the double backslash (\\) and the computername
                 in quotation marks (" "). The computername may be from
                 1 to 15 characters long.
\sharename       Is the network name of the shared resource.
\volume          Specifies a NetWare volume on the server. You must have
                 Client Services for Netware (Windows Workstations)
                 or Gateway Service for Netware (Windows Server)
                 installed and running to connect to NetWare servers.
password         Is the password needed to access the shared resource.
*                Produces a prompt for the password. The password is
                 not displayed when you type it at the password prompt.
'@

net_USE_USER = @'
/USER            Specifies a different username with which the connection
                 is made.
domainname       Specifies another domain. If domain is omitted,
                 the current logged on domain is used.
username         Specifies the username with which to logon.
'@

net_USE_SMARTCARD = @'
/SMARTCARD       Specifies that the connection is to use credentials on
                 a smart card.
'@

net_USE_SAVECRED = @'
/SAVECRED        Specifies that the username and password are to be saved.
                 This switch is ignored unless the command prompts for username
                 and password.
'@

net_USE_HOME = @'
/HOME            Connects a user to their home directory.
'@

net_USE_DELETE = @'
/DELETE          Cancels a network connection and removes the connection
                 from the list of persistent connections.
'@

net_USE_PERSISTENT = @'
/PERSISTENT      Controls the use of persistent network connections.
                 The default is the setting used last.
YES              Saves connections as they are made, and restores
                 them at next logon.
NO               Does not save the connection being made or subsequent
                 connections; existing connections will be restored at
                 next logon. Use the /DELETE switch to remove
                 persistent connections.
'@

net_USER = @'
The syntax of this command is:

NET USER
[username [password | *] [options]] [/DOMAIN]
         username {password | *} /ADD [options] [/DOMAIN]
         username [/DELETE] [/DOMAIN]
         username [/TIMES:{times | ALL}]
         username [/ACTIVE: {YES | NO}]

NET USER creates and modifies user accounts on computers. When used
without switches, it lists the user accounts for the computer. The
user account information is stored in the user accounts database.

username     Is the name of the user account to add, delete, modify, or
             view. The name of the user account can have as many as
             20 characters.
password     Assigns or changes a password for the user's account.
             A password must satisfy the minimum length set with the
             /MINPWLEN option of the NET ACCOUNTS command. It can have as
             many as 14 characters.
*            Produces a prompt for the password. The password is not
             displayed when you type it at a password prompt.
'@

net_USER_DOMAIN = @'
/DOMAIN      Performs the operation on a domain controller of
             the current domain.
'@

net_USER_ADD = @'
/ADD         Adds a user account to the user accounts database.
'@

net_USER_DELETE = @'
/DELETE      Removes a user account from the user accounts database.
'@

net_USER_ACTIVE = @'
/ACTIVE:{YES | NO}         Activates or deactivates the account. If
                          the account is not active, the user cannot
                          access the server. The default is YES.
'@

net_USER_COMMENT = @'
/COMMENT:"text"            Provides a descriptive comment about the
                          user's account.  Enclose the text in
                          quotation marks.
'@

net_USER_COUNTRYCODE = @'
/COUNTRYCODE:nnn           Uses the operating system country/region code
                          to implement the specified language files for
                          a user's help and error messages. A value of
                          0 signifies the default country/region code.
'@

net_USER_EXPIRES = @'
/EXPIRES:{date | NEVER}    Causes the account to expire if date is
                          set. NEVER sets no time limit on the
                          account. An expiration date is in the
                          form mm/dd/yy(yy). Months can be a number,
                          spelled out, or abbreviated with three
                          letters. Year can be two or four numbers.
                          Use slashes(/) (no spaces) to separate
                          parts of the date.
'@

net_USER_FULLNAME = @'
/FULLNAME:"name"           Is a user's full name (rather than a
                          username). Enclose the name in quotation
                          marks.
'@

net_USER_HOMEDIR = @'
/HOMEDIR:pathname          Sets the path for the user's home directory.
                          The path must exist.
'@

net_USER_PASSWORDCHG = @'
/PASSWORDCHG:{YES | NO}    Specifies whether users can change their
                          own password. The default is YES.
'@

net_USER_PASSWORDREQ = @'
/PASSWORDREQ:{YES | NO}    Specifies whether a user account must have
                          a password. The default is YES.
'@

net_USER_LOGONPASSWORDCHG = @'
/LOGONPASSWORDCHG:{YES|NO} Specifies whether user should change their
                          own password at the next logon.The default is NO.
'@

net_USER_PROFILEPATH = @'
/PROFILEPATH[:path]        Sets a path for the user's logon profile.
'@

net_USER_SCRIPTPATH = @'
/SCRIPTPATH:pathname       Is the location of the user's logon
                          script.
'@

net_USER_TIMES = @'
/TIMES:{times | ALL}       Is the logon hours. TIMES is expressed as
                          day[-day][,day[-day]],time[-time][,time
                          [-time]], limited to 1-hour increments.
                          Days can be spelled out or abbreviated.
                          Hours can be 12- or 24-hour notation. For
                          12-hour notation, use am, pm, a.m., or
                          p.m. ALL means a user can always log on,
                          and a blank value means a user can never
                          log on. Separate day and time entries with
                          a comma, and separate multiple day and time
                          entries with a semicolon.
'@

net_USER_USERCOMMENT = @'
/USERCOMMENT:"text"        Lets an administrator add or change the User
                          Comment for the account.
'@

net_USER_WORKSTATIONS = @'
/WORKSTATIONS:{computername[,...] | *}
                          Lists as many as eight computers from
                          which a user can log on to the network. If
                          /WORKSTATIONS has no list or if the list is *,
                          the user can log on from any computer.
'@

net_VIEW = @'
The syntax of this command is:

NET VIEW
[\\computername [/CACHE] | [/ALL] | /DOMAIN[:domainname]]

NET VIEW displays a list of resources being shared on a computer. When used
without options, it displays a list of computers in the current domain or
network.

\\computername             Is a computer whose shared resources you want
                           to view.
'@

net_VIEW_DOMAIN = @'
/DOMAIN:domainname         Specifies the domain for which you want to
                           view the available computers. If domainname is
                           omitted, displays all domains in the local area
                           network.
'@

net_VIEW_CACHE = @'
/CACHE                     Displays the offline client caching settings for
                           the resources on the specified computer
'@

net_VIEW_ALL = @'
/ALL                       Displays all the shares including the $ shares
'@

# All netsh_* entries generated by:
#    $x = GenNetshCommandTree
#    $x.Psd1Entries | clip
netsh_add = @'
Adds a configuration entry to a list of entries.
'@
netsh_add_helper = @'
Installs a helper DLL.
'@
netsh_advfirewall = @'
Changes to the `netsh advfirewall' context.
'@
netsh_advfirewall_consec = @'
Changes to the `netsh advfirewall consec' context.
'@
netsh_advfirewall_consec_add = @'
Adds a new connection security rule.
'@
netsh_advfirewall_consec_add_rule = @'
Adds a new connection security rule.
'@
netsh_advfirewall_consec_delete = @'
Deletes all matching connection security rules.
'@
netsh_advfirewall_consec_delete_rule = @'
Deletes all matching connection security rules.
'@
netsh_advfirewall_consec_dump = @'
Displays a configuration script.
'@
netsh_advfirewall_consec_help = @'
Displays a list of commands.
'@
netsh_advfirewall_consec_set = @'
Sets new values for properties of an existing rule.
'@
netsh_advfirewall_consec_set_rule = @'
Sets new values for properties of an existing rule.
'@
netsh_advfirewall_consec_show = @'
Displays a specified connection security rule.
'@
netsh_advfirewall_consec_show_rule = @'
Displays a specified connection security rule.
'@
netsh_advfirewall_dump = @'
Displays a configuration script.
'@
netsh_advfirewall_export = @'
Exports the current policy to a file.
'@
netsh_advfirewall_firewall = @'
Changes to the `netsh advfirewall firewall' context.
'@
netsh_advfirewall_firewall_add = @'
Adds a new inbound or outbound firewall rule.
'@
netsh_advfirewall_firewall_add_rule = @'
Adds a new inbound or outbound firewall rule.
'@
netsh_advfirewall_firewall_delete = @'
Deletes all matching firewall rules.
'@
netsh_advfirewall_firewall_delete_rule = @'
Deletes all matching firewall rules.
'@
netsh_advfirewall_firewall_dump = @'
Displays a configuration script.
'@
netsh_advfirewall_firewall_help = @'
Displays a list of commands.
'@
netsh_advfirewall_firewall_set = @'
Sets new values for properties of a existing rule.
'@
netsh_advfirewall_firewall_set_rule = @'
Sets new values for properties of a existing rule.
'@
netsh_advfirewall_firewall_show = @'
Displays a specified firewall rule.
'@
netsh_advfirewall_firewall_show_rule = @'
Displays a specified firewall rule.
'@
netsh_advfirewall_help = @'
Displays a list of commands.
'@
netsh_advfirewall_import = @'
Imports a policy file into the current policy store.
'@
netsh_advfirewall_mainmode = @'
Changes to the `netsh advfirewall mainmode' context.
'@
netsh_advfirewall_mainmode_add = @'
Adds a new mainmode rule.
'@
netsh_advfirewall_mainmode_add_rule = @'
Adds a new mainmode rule.
'@
netsh_advfirewall_mainmode_delete = @'
Deletes all matching mainmode rules.
'@
netsh_advfirewall_mainmode_delete_rule = @'
Deletes all matching mainmode rules.
'@
netsh_advfirewall_mainmode_dump = @'
Displays a configuration script.
'@
netsh_advfirewall_mainmode_help = @'
Displays a list of commands.
'@
netsh_advfirewall_mainmode_set = @'
Sets new values for properties of an existing rule.
'@
netsh_advfirewall_mainmode_set_rule = @'
Sets new values for properties of an existing rule.
'@
netsh_advfirewall_mainmode_show = @'
Displays a specified mainmode rule.
'@
netsh_advfirewall_mainmode_show_rule = @'
Displays a specified mainmode rule.
'@
netsh_advfirewall_monitor = @'
Changes to the `netsh advfirewall monitor' context.
'@
netsh_advfirewall_monitor_delete = @'
Deletes all matching security associations.
'@
netsh_advfirewall_monitor_dump = @'
Displays a configuration script.
'@
netsh_advfirewall_monitor_help = @'
Displays a list of commands.
'@
netsh_advfirewall_monitor_show = @'
Shows the runtime Firewall policy settings.
'@
netsh_advfirewall_monitor_show_consec = @'
Displays current consec state information.
'@
netsh_advfirewall_monitor_show_currentprofile = @'
Displays the currently active profiles.
'@
netsh_advfirewall_monitor_show_firewall = @'
Displays current firewall state information.
'@
netsh_advfirewall_monitor_show_mainmode = @'
Displays current mainmode state information.
'@
netsh_advfirewall_monitor_show_mmsa = @'
Displays the main mode SAs
'@
netsh_advfirewall_monitor_show_qmsa = @'
Displays the quick mode SAs.
'@
netsh_advfirewall_reset = @'
Resets the policy to the default out-of-box policy.
'@
netsh_advfirewall_set = @'
Sets the per-profile or global settings.
'@
netsh_advfirewall_set_allprofiles = @'
Sets properties in all profiles.
'@
netsh_advfirewall_set_currentprofile = @'
Sets properties in the active profile.
'@
netsh_advfirewall_set_domainprofile = @'
Sets properties in the domain profile.
'@
netsh_advfirewall_set_global = @'
Sets the global properties.
'@
netsh_advfirewall_set_privateprofile = @'
Sets properties in the private profile.
'@
netsh_advfirewall_set_publicprofile = @'
Sets properties in the public profile.
'@
netsh_advfirewall_show = @'
Displays profile or global properties.
'@
netsh_advfirewall_show_allprofiles = @'
Displays properties for all profiles.
'@
netsh_advfirewall_show_currentprofile = @'
Displays properties for the active profile.
'@
netsh_advfirewall_show_domainprofile = @'
Displays properties for the domain properties.
'@
netsh_advfirewall_show_global = @'
Displays the global properties.
'@
netsh_advfirewall_show_privateprofile = @'
Displays properties for the private profile.
'@
netsh_advfirewall_show_publicprofile = @'
Displays properties for the public profile.
'@
netsh_advfirewall_show_store = @'
Displays the policy store for the current interactive session.
'@
netsh_branchcache = @'
Changes to the `netsh branchcache' context.
'@
netsh_branchcache_dump = @'
Displays a configuration script.
'@
netsh_branchcache_exportkey = @'
Exports the content information key.
'@
netsh_branchcache_flush = @'
Flushes the contents of the cache.
'@
netsh_branchcache_help = @'
Displays a list of commands.
'@
netsh_branchcache_importkey = @'
Imports a new content information key.
'@
netsh_branchcache_reset = @'
Resets the BranchCache service.
'@
netsh_branchcache_set = @'
Sets configuration parameters.
'@
netsh_branchcache_set_cachesize = @'
Sets the size of the local cache.
'@
netsh_branchcache_set_key = @'
Generates a new content information key.
'@
netsh_branchcache_set_localcache = @'
Sets the location of the local cache.
'@
netsh_branchcache_set_publicationcache = @'
Sets the location of the local publication cache.
'@
netsh_branchcache_set_publicationcachesize = @'
Sets the size of the local publication cache.
'@
netsh_branchcache_set_service = @'
Sets the status of the BranchCache service.
'@
netsh_branchcache_show = @'
Displays configuration parameters.
'@
netsh_branchcache_show_hostedcache = @'
Displays the location of the hosted cache.
'@
netsh_branchcache_show_localcache = @'
Displays the status of the local cache.
'@
netsh_branchcache_show_publicationcache = @'
Displays the status of the local publication cache.
'@
netsh_branchcache_show_status = @'
Displays the current status of the BranchCache service.
'@
netsh_branchcache_smb = @'
Changes to the `netsh branchcache smb' context.
'@
netsh_branchcache_smb_dump = @'
Displays a configuration script.
'@
netsh_branchcache_smb_help = @'
Displays a list of commands.
'@
netsh_branchcache_smb_set = @'
Sets configuration parameters.
'@
netsh_branchcache_smb_set_latency = @'
Sets BranchCache SMB latency.
'@
netsh_branchcache_smb_show = @'
Displays configuration parameters.
'@
netsh_branchcache_smb_show_latency = @'
Displays BranchCache SMB latency settings.
'@
netsh_bridge = @'
Changes to the `netsh bridge' context.
'@
netsh_bridge_dump = @'
Displays a configuration script.
'@
netsh_bridge_help = @'
Displays a list of commands.
'@
netsh_bridge_install = @'
Installs the component corresponding to the current context.
'@
netsh_bridge_set = @'
Sets configuration information.
'@
netsh_bridge_set_adapter = @'
Modifies the bridge configuration for a specified adapter.
'@
netsh_bridge_show = @'
Displays information.
'@
netsh_bridge_show_adapter = @'
Shows the adapters configured as a single bridge.
'@
netsh_bridge_uninstall = @'
Removes the component corresponding to the current context.
'@
netsh_delete = @'
Deletes a configuration entry from a list of entries.
'@
netsh_delete_helper = @'
Removes a helper DLL.
'@
netsh_dhcpclient = @'
Changes to the `netsh dhcpclient' context.
'@
netsh_dnsclient = @'
Changes to the `netsh dnsclient' context.
'@
netsh_dnsclient_add = @'
Adds a configuration entry to a table.
'@
netsh_dnsclient_add_dnsservers = @'
Adds a static DNS server address.
'@
netsh_dnsclient_delete = @'
Deletes a configuration entry from a table.
'@
netsh_dnsclient_delete_dnsservers = @'
Deletes the DNS server from the specified interface.
'@
netsh_dnsclient_dump = @'
Displays a configuration script.
'@
netsh_dnsclient_help = @'
Displays a list of commands.
'@
netsh_dnsclient_set = @'
Sets configuration information.
'@
netsh_dnsclient_set_dnsservers = @'
Sets DNS server mode and addresses.
'@
netsh_dnsclient_show = @'
Displays information.
'@
netsh_dnsclient_show_state = @'
Shows the dns state.
'@
netsh_dump = @'
Displays a configuration script.
'@
netsh_exec = @'
Runs a script file.
'@
netsh_firewall = @'
Changes to the `netsh firewall' context.
'@
netsh_firewall_add = @'
Adds firewall configuration.
'@
netsh_firewall_delete = @'
Deletes firewall configuration.
'@
netsh_firewall_dump = @'
Displays a configuration script.
'@
netsh_firewall_help = @'
Displays a list of commands.
'@
netsh_firewall_set = @'
Sets firewall configuration.
'@
netsh_firewall_show = @'
Shows firewall configuration.
'@
netsh_help = @'
Displays a list of commands.
'@
netsh_http = @'
Changes to the `netsh http' context.
'@
netsh_http_add = @'
Adds a configuration entry to a table.
'@
netsh_http_add_cacheparam = @'
Adds an HTTP service cache parameter
'@
netsh_http_add_iplisten = @'
Adds an IP address to the IP listen list. 
'@
netsh_http_add_sslcert = @'
Adds an SSL server certificate binding.
'@
netsh_http_add_timeout = @'
Adds a global timeout to the service.
'@
netsh_http_add_urlacl = @'
Adds an URL reservation entry. 
'@
netsh_http_delete = @'
Deletes a configuration entry from a table.
'@
netsh_http_delete_cache = @'
Deletes entries from the HTTP service kernel URI cache.
'@
netsh_http_delete_iplisten = @'
Deletes an IP address from the IP listen list. 
'@
netsh_http_delete_sslcert = @'
Deletes SSL certificate bindings.
'@
netsh_http_delete_timeout = @'
Deletes a global timeout. 
'@
netsh_http_delete_urlacl = @'
Deletes a URL reservation. 
'@
netsh_http_dump = @'
Displays a configuration script.
'@
netsh_http_flush = @'
Flushes internal data.
'@
netsh_http_flush_logbuffer = @'
Flushes the internal buffers for the log files.
'@
netsh_http_help = @'
Displays a list of commands.
'@
netsh_http_show = @'
Displays information.
'@
netsh_http_show_cacheparam = @'
Shows the cache parameters of HTTP service .
'@
netsh_http_show_cachestate = @'
Lists cached URI resources and their associated properties.
'@
netsh_http_show_iplisten = @'
Displays all the IP addresses in the IP listen list.
'@
netsh_http_show_servicestate = @'
Shows a snapshot of the HTTP service.
'@
netsh_http_show_sslcert = @'
Displays SSL certificate bindings. 
'@
netsh_http_show_timeout = @'
Shows the timeout values of the service.
'@
netsh_http_show_urlacl = @'
Displays URL namespace reservations. 
'@
netsh_interface = @'
Changes to the `netsh interface' context.
'@
netsh_interface_dump = @'
Displays a configuration script.
'@
netsh_interface_help = @'
Displays a list of commands.
'@
netsh_interface_httpstunnel = @'
Changes to the `netsh interface httpstunnel' context.
'@
netsh_interface_httpstunnel_add = @'
Adds a configuration entry to a table.
'@
netsh_interface_httpstunnel_add_interface = @'
Creates an IPHTTPS client or server interface and configures the properties
'@
netsh_interface_httpstunnel_delete = @'
Deletes a configuration entry from a table.
'@
netsh_interface_httpstunnel_delete_interface = @'
Delete an IPHTTPS client or server interface
'@
netsh_interface_httpstunnel_dump = @'
Displays a configuration script.
'@
netsh_interface_httpstunnel_help = @'
Displays a list of commands.
'@
netsh_interface_httpstunnel_reset = @'
Reset the IP HTTPS configurations.
'@
netsh_interface_httpstunnel_set = @'
Sets configuration information.
'@
netsh_interface_httpstunnel_set_interface = @'
Sets the properties of an IPHTTPS client or server interface.
'@
netsh_interface_httpstunnel_show = @'
Displays information.
'@
netsh_interface_httpstunnel_show_interfaces = @'
Shows IPHTTPS interface parameters.
'@
netsh_interface_httpstunnel_show_statistics = @'
Shows IPHTTPS interface statistics.
'@
netsh_interface_isatap = @'
Changes to the `netsh interface isatap' context.
'@
netsh_interface_isatap_dump = @'
Displays a configuration script.
'@
netsh_interface_isatap_help = @'
Displays a list of commands.
'@
netsh_interface_isatap_set = @'
Sets configuration information.
'@
netsh_interface_isatap_set_router = @'
Sets ISATAP router information.
'@
netsh_interface_isatap_set_state = @'
Sets ISATAP state.
'@
netsh_interface_isatap_show = @'
Displays information.
'@
netsh_interface_isatap_show_router = @'
Shows the ISATAP router information.
'@
netsh_interface_isatap_show_state = @'
Shows the ISATAP state.
'@
netsh_interface_portproxy = @'
Changes to the `netsh interface portproxy' context.
'@
netsh_interface_portproxy_add = @'
Adds a configuration entry to a table.
'@
netsh_interface_portproxy_delete = @'
Deletes a configuration entry from a table.
'@
netsh_interface_portproxy_dump = @'
Displays a configuration script.
'@
netsh_interface_portproxy_help = @'
Displays a list of commands.
'@
netsh_interface_portproxy_reset = @'
Resets portproxy configuration state.
'@
netsh_interface_portproxy_set = @'
Sets configuration information.
'@
netsh_interface_portproxy_show = @'
Displays information.
'@
netsh_interface_portproxy_show_all = @'
Shows all port proxy parameters.
'@
netsh_interface_set = @'
Sets configuration information.
'@
netsh_interface_set_interface = @'
Sets interface parameters.
'@
netsh_interface_show = @'
Displays information.
'@
netsh_interface_show_interface = @'
Displays interfaces.
'@
netsh_interface_tcp = @'
Changes to the `netsh interface tcp' context.
'@
netsh_interface_tcp_add = @'
Adds a configuration entry to a table.
'@
netsh_interface_tcp_add_chimneyapplication = @'
Adds application to the TCP Chimney offload table.
'@
netsh_interface_tcp_add_chimneyport = @'
Adds a source port, destination port filter to the TCP Chimney
'@
netsh_interface_tcp_add_supplementalport = @'
Adds a source port, destination port filter to the TCP supplemental
'@
netsh_interface_tcp_add_supplementalsubnet = @'
Adds a destination subnet filter to the TCP supplemental
'@
netsh_interface_tcp_delete = @'
Deletes a configuration entry from a table.
'@
netsh_interface_tcp_delete_chimneyapplication = @'
Deletes a TCP chimney application from the offload table.
'@
netsh_interface_tcp_delete_chimneyport = @'
Deletes a TCP chimney port entry from the offload table.
'@
netsh_interface_tcp_delete_supplementalport = @'
Deletes a TCP port entry from the TCP supplemental filter table.
'@
netsh_interface_tcp_delete_supplementalsubnet = @'
Deletes a TCP subnet entry from the TCP supplemental filter table.
'@
netsh_interface_tcp_dump = @'
Displays a configuration script.
'@
netsh_interface_tcp_help = @'
Displays a list of commands.
'@
netsh_interface_tcp_reset = @'
Reset all TCP parameters to their default values.
'@
netsh_interface_tcp_set = @'
Sets configuration information.
'@
netsh_interface_tcp_set_global = @'
Sets global TCP parameters.
'@
netsh_interface_tcp_set_heuristics = @'
Sets heuristics TCP parameters.
'@
netsh_interface_tcp_set_security = @'
Sets TCP security parameters.
'@
netsh_interface_tcp_set_supplemental = @'
Sets the TCP global default template or the supplemental template based TCP parameters.
'@
netsh_interface_tcp_show = @'
Displays information.
'@
netsh_interface_tcp_show_chimneyapplications = @'
Shows applications in the TCP chimney offload table.
'@
netsh_interface_tcp_show_chimneyports = @'
Shows port tuples in the TCP chimney offload table.
'@
netsh_interface_tcp_show_chimneystats = @'
Shows TCP Chimney statistics for chimney-capable interfaces.
'@
netsh_interface_tcp_show_global = @'
Shows global TCP parameters.
'@
netsh_interface_tcp_show_heuristics = @'
Shows heuristics TCP parameters.
'@
netsh_interface_tcp_show_netdmastats = @'
NetDMA is not supported in this version of Windows. Changing NetDMA
settings will have no effect. Please refer to:
http://msdn.microsoft.com/en-us/library/ff568342(VS.85).aspx for more
information.
'@
netsh_interface_tcp_show_rscstats = @'
Shows TCP statistics for Receive Segment Coalescing-capable interfaces.
'@
netsh_interface_tcp_show_security = @'
Shows TCP security parameters.
'@
netsh_interface_tcp_show_supplemental = @'
Shows supplemental template based TCP parameters.
'@
netsh_interface_tcp_show_supplementalports = @'
Shows port tuples in the TCP supplemental filter table.
'@
netsh_interface_tcp_show_supplementalsubnets = @'
Shows destination subnets in the TCP supplemental filter table.
'@
netsh_interface_teredo = @'
Changes to the `netsh interface teredo' context.
'@
netsh_interface_teredo_dump = @'
Displays a configuration script.
'@
netsh_interface_teredo_help = @'
Displays a list of commands.
'@
netsh_interface_teredo_set = @'
Sets configuration information.
'@
netsh_interface_teredo_set_state = @'
Sets Teredo state.
'@
netsh_interface_teredo_show = @'
Displays information.
'@
netsh_interface_teredo_show_state = @'
Shows Teredo state.
'@
netsh_ipsec = @'
Changes to the `netsh ipsec' context.
'@
netsh_ipsec_dump = @'
Displays a configuration script.
'@
netsh_ipsec_dynamic = @'
Changes to the `netsh ipsec dynamic' context.
'@
netsh_ipsec_dynamic_add = @'
Adds policy, filter, and actions to SPD.
'@
netsh_ipsec_dynamic_add_mmpolicy = @'
Adds a main mode policy to SPD.
'@
netsh_ipsec_dynamic_add_qmpolicy = @'
Adds a quick mode policy to SPD.
'@
netsh_ipsec_dynamic_add_rule = @'
Adds a rule and associated filters to SPD.
'@
netsh_ipsec_dynamic_delete = @'
Deletes policy, filter, and actions from SPD.
'@
netsh_ipsec_dynamic_delete_all = @'
Deletes all policies, filters, and actions from SPD.
'@
netsh_ipsec_dynamic_delete_mmpolicy = @'
Deletes a main mode policy from SPD.
'@
netsh_ipsec_dynamic_delete_qmpolicy = @'
Deletes a quick mode policy from SPD.
'@
netsh_ipsec_dynamic_delete_rule = @'
Deletes a rule and associated filters from SPD.
'@
netsh_ipsec_dynamic_delete_sa = @'
ipsec dynamic delete sa
'@
netsh_ipsec_dynamic_dump = @'
Displays a configuration script.
'@
netsh_ipsec_dynamic_help = @'
Displays a list of commands.
'@
netsh_ipsec_dynamic_set = @'
Modifies policy, filter, and actions in SPD.
'@
netsh_ipsec_dynamic_set_config = @'
Sets the IPsec configuration and boot time behavior.
'@
netsh_ipsec_dynamic_set_mmpolicy = @'
Modifies a main mode policy in SPD.
'@
netsh_ipsec_dynamic_set_qmpolicy = @'
Modifies a quick mode policy in SPD.
'@
netsh_ipsec_dynamic_set_rule = @'
Modifies a rule and associated filters in SPD.
'@
netsh_ipsec_dynamic_show = @'
Displays policy, filter, and actions from SPD.
'@
netsh_ipsec_dynamic_show_all = @'
Displays policies, filters, SAs, and statistics from SPD.
'@
netsh_ipsec_dynamic_show_config = @'
Displays IPsec configuration.
'@
netsh_ipsec_dynamic_show_mmfilter = @'
Displays main mode filter details from SPD.
'@
netsh_ipsec_dynamic_show_mmpolicy = @'
Displays main mode policy details from SPD.
'@
netsh_ipsec_dynamic_show_mmsas = @'
Displays main mode security associations from SPD.
'@
netsh_ipsec_dynamic_show_qmfilter = @'
Displays quick mode filter details from SPD.
'@
netsh_ipsec_dynamic_show_qmpolicy = @'
Displays quick mode policy details from SPD.
'@
netsh_ipsec_dynamic_show_qmsas = @'
Displays quick mode security associations from SPD.
'@
netsh_ipsec_dynamic_show_rule = @'
Displays rule details from SPD.
'@
netsh_ipsec_help = @'
Displays a list of commands.
'@
netsh_ipsec_static = @'
Changes to the `netsh ipsec static' context.
'@
netsh_ipsec_static_add = @'
Creates new policies and related information.
'@
netsh_ipsec_static_add_filter = @'
Adds a filter to filter list.
'@
netsh_ipsec_static_add_filteraction = @'
Creates a filter action.
'@
netsh_ipsec_static_add_filterlist = @'
Creates an empty filter list.
'@
netsh_ipsec_static_add_policy = @'
Creates a policy with a default response rule.
'@
netsh_ipsec_static_add_rule = @'
Creates a rule for the specified policy.
'@
netsh_ipsec_static_delete = @'
Deletes policies and related information.
'@
netsh_ipsec_static_delete_all = @'
Deletes all policies, filter lists, and filter actions.
'@
netsh_ipsec_static_delete_filter = @'
Deletes a filter from a filter list.
'@
netsh_ipsec_static_delete_filteraction = @'
Deletes a filter action.
'@
netsh_ipsec_static_delete_filterlist = @'
Deletes a filter list.
'@
netsh_ipsec_static_delete_policy = @'
Deletes a policy and its rules.
'@
netsh_ipsec_static_delete_rule = @'
Deletes a rule from a policy.
'@
netsh_ipsec_static_dump = @'
Displays a configuration script.
'@
netsh_ipsec_static_exportpolicy = @'
Exports all the policies from the policy store.
'@
netsh_ipsec_static_help = @'
Displays a list of commands.
'@
netsh_ipsec_static_importpolicy = @'
Imports the policies from a file to the policy store.
'@
netsh_ipsec_static_set = @'
Modifies existing policies and related information.
'@
netsh_ipsec_static_set_batch = @'
Sets the batch update mode.
'@
netsh_ipsec_static_set_defaultrule = @'
Modifies the default response rule of a policy.
'@
netsh_ipsec_static_set_filteraction = @'
Modifies a filter action.
'@
netsh_ipsec_static_set_filterlist = @'
Modifies a filter list.
'@
netsh_ipsec_static_set_policy = @'
Modifies a policy.
'@
netsh_ipsec_static_set_rule = @'
Modifies a rule.
'@
netsh_ipsec_static_set_store = @'
Sets the current policy store.
'@
netsh_ipsec_static_show = @'
Displays details of policies and related information.
'@
netsh_ipsec_static_show_all = @'
Displays details of all policies and related information.
'@
netsh_ipsec_static_show_filteraction = @'
Displays filter action details.
'@
netsh_ipsec_static_show_filterlist = @'
Displays filter list details.
'@
netsh_ipsec_static_show_gpoassignedpolicy = @'
Displays details of a group assigned policy.
'@
netsh_ipsec_static_show_policy = @'
Displays policy details.
'@
netsh_ipsec_static_show_rule = @'
Displays rule details.
'@
netsh_ipsec_static_show_store = @'
Displays the current policy store.
'@
netsh_lan = @'
Changes to the `netsh lan' context.
'@
netsh_lan_add = @'
Adds a configuration entry to a table.
'@
netsh_lan_add_profile = @'
Adds a LAN profile to specified interface on the machine.
'@
netsh_lan_delete = @'
Deletes a configuration entry from a table.
'@
netsh_lan_delete_profile = @'
Deletes a LAN profile from one or multiple interfaces.
'@
netsh_lan_dump = @'
Displays a configuration script.
'@
netsh_lan_export = @'
Saves LAN profiles to XML files.
'@
netsh_lan_export_profile = @'
Exports specified profiles to XML files.
'@
netsh_lan_help = @'
Displays a list of commands.
'@
netsh_lan_reconnect = @'
Reconnects on an interface.
'@
netsh_lan_set = @'
Configures settings on interfaces.
'@
netsh_lan_set_allowexplicitcreds = @'
Allow or disallow the user to use shared user 
'@
netsh_lan_set_autoconfig = @'
Enables or disables auto-configuration on an interface.
'@
netsh_lan_set_blockperiod = @'
Set the block period.
'@
netsh_lan_set_eapuserdata = @'
Adds EAP user data to an interface.
'@
netsh_lan_set_profileparameter = @'
Set parameters in a wired network profile.
'@
netsh_lan_set_tracing = @'
Enables or disables tracing.
'@
netsh_lan_show = @'
Displays information.
'@
netsh_lan_show_interfaces = @'
Shows a list of the current wired interfaces on the system.
'@
netsh_lan_show_profiles = @'
Shows a list of wired profiles currently configured on the machine.
'@
netsh_lan_show_settings = @'
Shows the current global settings of wired LAN.
'@
netsh_lan_show_tracing = @'
Shows whether wired LAN tracing is enabled or disabled.
'@
netsh_mbn = @'
Changes to the `netsh mbn' context.
'@
netsh_mbn_add = @'
Adds a configuration entry to a table.
'@
netsh_mbn_add_profile = @'
Adds a network profile in the Profile Data Store.
'@
netsh_mbn_connect = @'
Connects to a Mobile Broadband network.
'@
netsh_mbn_delete = @'
Deletes a configuration entry from a table.
'@
netsh_mbn_delete_profile = @'
Deletes a network profile from the Profile Data Store.
'@
netsh_mbn_disconnect = @'
Disconnects from a Mobile Broadband network.
'@
netsh_mbn_dump = @'
Displays a configuration script.
'@
netsh_mbn_help = @'
Displays a list of commands.
'@
netsh_mbn_set = @'
Sets configuration information.
'@
netsh_mbn_set_profileparameter = @'
Set parameters in a Mobile Broadband Network Profile.
'@
netsh_mbn_set_tracing = @'
Enable or disable tracing.
'@
netsh_mbn_show = @'
Displays information.
'@
netsh_mbn_show_capability = @'
Shows the interface capability information for the given interface.
'@
netsh_mbn_show_connection = @'
Shows the current connection information for the given interface.
'@
netsh_mbn_show_homeprovider = @'
Shows the home provider information for the given interface.
'@
netsh_mbn_show_interfaces = @'
Shows a list of Mobile Broadband interfaces on the system.
'@
netsh_mbn_show_pin = @'
Shows the pin information for the given interface.
'@
netsh_mbn_show_pinlist = @'
Shows the pin list information for the given interface.
'@
netsh_mbn_show_preferredproviders = @'
Shows the preferred providers list for the given interface.
'@
netsh_mbn_show_profiles = @'
Shows a list of profiles configured on the system.
'@
netsh_mbn_show_provisionedcontexts = @'
Shows the provisioned contexts information for the given interface.
'@
netsh_mbn_show_radio = @'
Shows the radio state information for the given interface.
'@
netsh_mbn_show_readyinfo = @'
Shows the ready information for the given interface.
'@
netsh_mbn_show_signal = @'
Shows the signal information for the given interface.
'@
netsh_mbn_show_smsconfig = @'
Shows the SMS configuration information for the given interface.
'@
netsh_mbn_show_tracing = @'
Shows whether Mobile Broadband tracing is enabled or disabled.
'@
netsh_mbn_show_visibleproviders = @'
Shows the visible providers list for the given interface.
'@
netsh_namespace = @'
Changes to the `netsh namespace' context.
'@
netsh_namespace_dump = @'
Displays a configuration script.
'@
netsh_namespace_help = @'
Displays a list of commands.
'@
netsh_namespace_show = @'
Displays information.
'@
netsh_namespace_show_effectivepolicy = @'
Shows dns client effective policy table.
'@
netsh_namespace_show_policy = @'
Shows dns client policy table.
'@
netsh_nap = @'
Changes to the `netsh nap' context.
'@
netsh_nap_client = @'
Changes to the `netsh nap client' context.
'@
netsh_nap_client_add = @'
Adds configuration.
'@
netsh_nap_client_add_server = @'
Adds trusted server configuration.
'@
netsh_nap_client_add_trustedservergroup = @'
Adds trusted server group configuration.
'@
netsh_nap_client_delete = @'
Deletes configuration.
'@
netsh_nap_client_delete_server = @'
Deletes trusted server configuration.
'@
netsh_nap_client_delete_trustedservergroup = @'
Deletes trusted server group configuration.
'@
netsh_nap_client_dump = @'
Displays a configuration script.
'@
netsh_nap_client_export = @'
Exports configuration settings.
'@
netsh_nap_client_help = @'
Displays a list of commands.
'@
netsh_nap_client_import = @'
Imports configuration settings.
'@
netsh_nap_client_rename = @'
Renames configuration.
'@
netsh_nap_client_rename_server = @'
Renames trusted server configuration.
'@
netsh_nap_client_rename_trustedservergroup = @'
Renames trusted server group configuration.
'@
netsh_nap_client_reset = @'
Resets configuration.
'@
netsh_nap_client_reset_configuration = @'
Resets configuration.
'@
netsh_nap_client_reset_csp = @'
Resets CSP configuration.
'@
netsh_nap_client_reset_enforcement = @'
Resets enforcement configuration.
'@
netsh_nap_client_reset_hash = @'
Resets hash configuration.
'@
netsh_nap_client_reset_server = @'
Resets trusted server configuration.
'@
netsh_nap_client_reset_tracing = @'
Resets tracing configuration.
'@
netsh_nap_client_reset_trustedservergroup = @'
Resets trusted server group configuration.
'@
netsh_nap_client_reset_userinterface = @'
Resets user interface configuration.
'@
netsh_nap_client_set = @'
Sets configuration.
'@
netsh_nap_client_set_csp = @'
Sets CSP configuration.
'@
netsh_nap_client_set_enforcement = @'
Sets enforcement configuration.
'@
netsh_nap_client_set_hash = @'
Sets hash configuration.
'@
netsh_nap_client_set_server = @'
Sets trusted server configuration.
'@
netsh_nap_client_set_tracing = @'
Sets tracing configuration.
'@
netsh_nap_client_set_userinterface = @'
Sets user interface configuration.
'@
netsh_nap_client_show = @'
Shows configuration and state information.
'@
netsh_nap_client_show_configuration = @'
Shows configuration.
'@
netsh_nap_client_show_csps = @'
Shows CSP configuration.
'@
netsh_nap_client_show_grouppolicy = @'
Shows group policy configuration.
'@
netsh_nap_client_show_hashes = @'
Shows hash configuration.
'@
netsh_nap_client_show_state = @'
Shows state.
'@
netsh_nap_client_show_trustedservergroup = @'
Shows all trusted server groups.
'@
netsh_nap_dump = @'
Displays a configuration script.
'@
netsh_nap_help = @'
Displays a list of commands.
'@
netsh_nap_hra = @'
Changes to the `netsh nap hra' context.
'@
netsh_nap_reset = @'
Resets configuration.
'@
netsh_nap_reset_configuration = @'
Resets configuration.
'@
netsh_nap_show = @'
Shows configuration and state information.
'@
netsh_nap_show_configuration = @'
Shows configuration.
'@
netsh_netio = @'
Changes to the `netsh netio' context.
'@
netsh_netio_add = @'
Adds a configuration entry to a table.
'@
netsh_netio_add_bindingfilter = @'
Adds a binding filter.
'@
netsh_netio_delete = @'
Deletes a configuration entry from a table.
'@
netsh_netio_delete_bindingfilter = @'
Deletes a binding filter.
'@
netsh_netio_dump = @'
Displays a configuration script.
'@
netsh_netio_help = @'
Displays a list of commands.
'@
netsh_netio_show = @'
Displays information.
'@
netsh_netio_show_bindingfilters = @'
Shows all binding filters.
'@
netsh_ras = @'
Changes to the `netsh ras' context.
'@
netsh_ras_aaaa = @'
Changes to the `netsh ras aaaa' context.
'@
netsh_ras_aaaa_add = @'
Adds items to a table.
'@
netsh_ras_aaaa_add_acctserver = @'
Adds a RADIUS accounting server.
'@
netsh_ras_aaaa_add_authserver = @'
Adds a RADIUS authentication server.
'@
netsh_ras_aaaa_delete = @'
Removes items from a table.
'@
netsh_ras_aaaa_delete_acctserver = @'
Deletes a RADIUS accounting server.
'@
netsh_ras_aaaa_delete_authserver = @'
Deletes a RADIUS server.
'@
netsh_ras_aaaa_dump = @'
Displays a configuration script.
'@
netsh_ras_aaaa_help = @'
Displays a list of commands.
'@
netsh_ras_aaaa_set = @'
Sets configuration information.
'@
netsh_ras_aaaa_set_accounting = @'
Sets the accounting provider.
'@
netsh_ras_aaaa_set_acctserver = @'
Sets properties of an accounting server.
'@
netsh_ras_aaaa_set_authentication = @'
Sets the authentication provider.
'@
netsh_ras_aaaa_set_authserver = @'
Sets properties of an authentication server.
'@
netsh_ras_aaaa_set_ipsecpolicy = @'
Sets the IPsec policy for L2TP connection. 
'@
netsh_ras_aaaa_show = @'
Displays information.
'@
netsh_ras_aaaa_show_accounting = @'
Displays the current accounting provider.
'@
netsh_ras_aaaa_show_acctserver = @'
Displays the RADIUS server(s) used for accounting.
'@
netsh_ras_aaaa_show_authentication = @'
Displays the current authentication provider.
'@
netsh_ras_aaaa_show_authserver = @'
Displays the RADIUS server(s) used for authentication.
'@
netsh_ras_aaaa_show_ipsecpolicy = @'
Shows the IPsec policy for L2TP connection.
'@
netsh_ras_add = @'
Adds items to a table.
'@
netsh_ras_add_authtype = @'
Adds types of authentication the Remote Access server will negotiate.
'@
netsh_ras_add_link = @'
Adds to the list of link properties PPP will negotiate
'@
netsh_ras_add_multilink = @'
Adds to the list of multilink types PPP will negotiate
'@
netsh_ras_add_registeredserver = @'
Registers the given Windows computer as a 
'@
netsh_ras_delete = @'
Removes items from a table.
'@
netsh_ras_delete_authtype = @'
Deletes an authentication type from the Remote Access server.
'@
netsh_ras_delete_link = @'
Deletes from the list of link properties PPP will negotiate
'@
netsh_ras_delete_multilink = @'
Deletes from the list of multilink types PPP will negotiate
'@
netsh_ras_delete_registeredserver = @'
Un-registers the given Windows computer as a 
'@
netsh_ras_diagnostics = @'
Changes to the `netsh ras diagnostics' context.
'@
netsh_ras_diagnostics_dump = @'
Displays a configuration script.
'@
netsh_ras_diagnostics_help = @'
Displays a list of commands.
'@
netsh_ras_diagnostics_set = @'
Sets configuration information.
'@
netsh_ras_diagnostics_set_cmtracing = @'
Enables/disables Connection Manager logging.
'@
netsh_ras_diagnostics_set_loglevel = @'
Sets  the global Log level for RRAS 
'@
netsh_ras_diagnostics_set_modemtracing = @'
Enables or disables tracing of modem settings and messages during a network connection.
'@
netsh_ras_diagnostics_set_rastracing = @'
Enables/disables extended tracing for a component.
'@
netsh_ras_diagnostics_set_securityeventlog = @'
Enables or disables Security Event logging. You can view Security Event logs using Event Viewer.
'@
netsh_ras_diagnostics_set_tracefacilities = @'
Enables/disables extended tracing for all components.
'@
netsh_ras_diagnostics_show = @'
Displays information.
'@
netsh_ras_diagnostics_show_all = @'
Shows Remote Access Diag Report.
'@
netsh_ras_diagnostics_show_cmtracing = @'
Shows whether Connection Manager logging is enabled.
'@
netsh_ras_diagnostics_show_configuration = @'
Configuration Info.
'@
netsh_ras_diagnostics_show_installation = @'
Installation Info.
'@
netsh_ras_diagnostics_show_loglevel = @'
Shows the global Log level for RRAS 
'@
netsh_ras_diagnostics_show_logs = @'
Shows all logs.
'@
netsh_ras_diagnostics_show_modemtracing = @'
Shows whether tracing of modem settings and messages during a network connection is enabled.
'@
netsh_ras_diagnostics_show_rastracing = @'
Shows whether extended tracing is enabled for components.
'@
netsh_ras_diagnostics_show_securityeventlog = @'
Shows whether Security Event Logs are enabled.
'@
netsh_ras_diagnostics_show_tracefacilities = @'
Shows whether extended tracing is enabled for all components.
'@
netsh_ras_dump = @'
Displays a configuration script.
'@
netsh_ras_help = @'
Displays a list of commands.
'@
netsh_ras_ip = @'
Changes to the `netsh ras ip' context.
'@
netsh_ras_ip_add = @'
Adds items to a table.
'@
netsh_ras_ip_add_range = @'
Adds a range to the static IP address pool.
'@
netsh_ras_ip_delete = @'
Removes items from a table.
'@
netsh_ras_ip_delete_pool = @'
Deletes all ranges from the static IP address pool.
'@
netsh_ras_ip_delete_range = @'
Deletes a range from the static IP address pool.
'@
netsh_ras_ip_dump = @'
Displays a configuration script.
'@
netsh_ras_ip_help = @'
Displays a list of commands.
'@
netsh_ras_ip_set = @'
Sets configuration information.
'@
netsh_ras_ip_set_access = @'
Sets whether clients are given access beyond the remote
'@
netsh_ras_ip_set_addrassign = @'
Sets the method by which the Remote Access server
'@
netsh_ras_ip_set_addrreq = @'
Sets whether clients can request their own IP addresses.
'@
netsh_ras_ip_set_broadcastnameresolution = @'
Sets whether to enable or disable broadcast
'@
netsh_ras_ip_set_negotiation = @'
Sets whether IP is negotiated for client Remote Access connections.
'@
netsh_ras_ip_set_preferredadapter = @'
Specifies the preferred adapter for Routing and Remote
'@
netsh_ras_ip_show = @'
Displays information.
'@
netsh_ras_ip_show_config = @'
Displays current Remote Access IP configuration.
'@
netsh_ras_ip_show_preferredadapter = @'
Shows the preferred adapter for Routing and Remote 
'@
netsh_ras_set = @'
Sets configuration information.
'@
netsh_ras_set_authmode = @'
Sets the authentication mode.
'@
netsh_ras_set_client = @'
Reset the statistics or disconnect a Remote Access Client. 
'@
netsh_ras_set_conf = @'
Sets the configuration state of the server. 
'@
netsh_ras_set_portstatus = @'
Resets the statistics information of RAS ports. 
'@
netsh_ras_set_type = @'
Sets the Router and RAS functionalities of the computer. 
'@
netsh_ras_set_user = @'
Sets the Remote Access properties of a user.
'@
netsh_ras_set_wanports = @'
Sets the RAS WAN ports options. 
'@
netsh_ras_show = @'
Displays information.
'@
netsh_ras_show_activeservers = @'
Listens for Remote Access server advertisements.
'@
netsh_ras_show_authmode = @'
Shows the authentication mode.
'@
netsh_ras_show_authtype = @'
Displays the authentication types currently enabled.
'@
netsh_ras_show_client = @'
Shows Remote Access clients connected to this machine 
'@
netsh_ras_show_conf = @'
Shows the configuration state of the server. 
'@
netsh_ras_show_link = @'
Shows the link properties PPP will negotiate
'@
netsh_ras_show_multilink = @'
Shows the multilink types PPP will negotiate
'@
netsh_ras_show_portstatus = @'
Shows the current status of RAS ports.  
'@
netsh_ras_show_registeredserver = @'
Displays whether a computer is registered as a  
'@
netsh_ras_show_status = @'
Shows the status of the Routing and Remote Access Server. 
'@
netsh_ras_show_type = @'
Shows the Router and RAS functionalities of the computer. 
'@
netsh_ras_show_user = @'
Displays Remote Access properties for a user(s).
'@
netsh_ras_show_wanports = @'
Shows the options set for RAS WAN ports. 
'@
netsh_rpc = @'
Changes to the `netsh rpc' context.
'@
netsh_rpc_add = @'
Creates an Add list of subnets. 
'@
netsh_rpc_delete = @'
Creates a Delete list of subnets. 
'@
netsh_rpc_dump = @'
Displays a configuration script.
'@
netsh_rpc_filter = @'
Changes to the `netsh rpc filter' context.
'@
netsh_rpc_filter_add = @'
Adds configuration entry to a table. 
'@
netsh_rpc_filter_add_condition = @'
Adds a condition to an existing RPC firewall filter rule. 
'@
netsh_rpc_filter_add_filter = @'
Adds an RPC firewall filter. 
'@
netsh_rpc_filter_add_rule = @'
Adds an RPC firewall filter rule. 
'@
netsh_rpc_filter_delete = @'
Deletes configuration entry from a table. 
'@
netsh_rpc_filter_delete_filter = @'
Deletes RPC firewall filter(s). 
'@
netsh_rpc_filter_delete_rule = @'
Deletes the RPC firewall filter rule. 
'@
netsh_rpc_filter_dump = @'
Displays a configuration script.
'@
netsh_rpc_filter_help = @'
Displays a list of commands.
'@
netsh_rpc_filter_show = @'
Displays information. 
'@
netsh_rpc_filter_show_filter = @'
Lists all RPC firewall filters. 
'@
netsh_rpc_help = @'
Displays a list of commands.
'@
netsh_rpc_reset = @'
Resets the selective binding settings to 'none' (listen on all interfaces). 
'@
netsh_rpc_show = @'
Displays the selective binding state for each subnet on the system.
'@
netsh_set = @'
Updates configuration settings.
'@
netsh_set_machine = @'
Sets the current machine on which to operate.
'@
netsh_show = @'
Displays information.
'@
netsh_show_alias = @'
Lists all defined aliases.
'@
netsh_show_helper = @'
Lists all the top-level helpers.
'@
netsh_trace = @'
Changes to the `netsh trace' context.
'@
netsh_trace_convert = @'
Converts a trace file to an HTML report.
'@
netsh_trace_correlate = @'
Normalizes or filters a trace file to a new output file.
'@
netsh_trace_diagnose = @'
Start a diagnose session.
'@
netsh_trace_dump = @'
Displays a configuration script.
'@
netsh_trace_help = @'
Displays a list of commands.
'@
netsh_trace_show = @'
List interfaces, providers and tracing state.
'@
netsh_trace_show_CaptureFilterHelp = @'
List supported capture filters and usage.
'@
netsh_trace_show_globalKeywordsAndLevels = @'
List global keywords and levels.
'@
netsh_trace_show_helperclass = @'
Show helper class information.
'@
netsh_trace_show_interfaces = @'
List available interfaces.
'@
netsh_trace_show_provider = @'
Shows provider information.
'@
netsh_trace_show_providers = @'
Shows available providers.
'@
netsh_trace_show_scenario = @'
Shows scenario information.
'@
netsh_trace_show_scenarios = @'
Shows available scenarios.
'@
netsh_trace_show_status = @'
Shows tracing configuration.
'@
netsh_trace_start = @'
Starts tracing.
'@
netsh_trace_stop = @'
Stops tracing.
'@
netsh_wcn = @'
Changes to the `netsh wcn' context.
'@
netsh_wcn_dump = @'
Displays a configuration script.
'@
netsh_wcn_enroll = @'
Connects to a wireless network.
'@
netsh_wcn_help = @'
Displays a list of commands.
'@
netsh_wcn_query = @'
Queries information about a WCN device.
'@
netsh_wfp = @'
Changes to the `netsh wfp' context.
'@
netsh_wfp_capture = @'
Captures real-time diagnostic information.
'@
netsh_wfp_capture_start = @'
Starts an interactive capture session. 
'@
netsh_wfp_capture_status = @'
Tells whether an interactive capture session is in progress.
'@
netsh_wfp_capture_stop = @'
Stops an interactive capture session.
'@
netsh_wfp_dump = @'
Displays a configuration script.
'@
netsh_wfp_help = @'
Displays a list of commands.
'@
netsh_wfp_set = @'
Sets WFP diagnostic options.
'@
netsh_wfp_set_options = @'
Sets the global WFP options.
'@
netsh_wfp_show = @'
Shows WFP configuration and state.
'@
netsh_wfp_show_appid = @'
Displays the application ID for the specified file. 
'@
netsh_wfp_show_boottimepolicy = @'
Displays the boot-time policy and filters. 
'@
netsh_wfp_show_filters = @'
Displays filters matching the specified traffic parameters.
'@
netsh_wfp_show_netevents = @'
Displays recent network events matching the traffic parameters. 
'@
netsh_wfp_show_options = @'
Displays the global WFP options. 
'@
netsh_wfp_show_security = @'
Displays the specified security descriptor. 
'@
netsh_wfp_show_state = @'
Displays the current state of WFP and IPsec.
'@
netsh_wfp_show_sysports = @'
Displays system ports used by the TCP/IP Stack and the RPC sub-system. 
'@
netsh_winhttp = @'
Changes to the `netsh winhttp' context.
'@
netsh_winhttp_dump = @'
Displays a configuration script.
'@
netsh_winhttp_help = @'
Displays a list of commands.
'@
netsh_winhttp_import = @'
Imports WinHTTP proxy settings.
'@
netsh_winhttp_import_proxy = @'
Imports proxy setting from IE.
'@
netsh_winhttp_reset = @'
Resets WinHTTP settings.
'@
netsh_winhttp_reset_proxy = @'
Resets WinHTTP proxy setting to DIRECT.
'@
netsh_winhttp_reset_tracing = @'
Use netsh trace stop.
'@
netsh_winhttp_set = @'
Configures WinHTTP settings.
'@
netsh_winhttp_set_proxy = @'
Configures WinHTTP proxy setting.
'@
netsh_winhttp_set_tracing = @'
Use netsh trace start scenario=InternetClient.
'@
netsh_winhttp_show = @'
Displays currents settings.
'@
netsh_winhttp_show_proxy = @'
Displays current WinHTTP proxy setting.
'@
netsh_winhttp_show_tracing = @'
Use netsh trace show.
'@
netsh_winsock = @'
Changes to the `netsh winsock' context.
'@
netsh_winsock_audit = @'
Displays a list of Winsock LSPs that have been installed and removed.
'@
netsh_winsock_audit_trail = @'
Shows the audit trail of Layered Service Providers that have been installed and uninstalled. 
'@
netsh_winsock_dump = @'
Displays a configuration script.
'@
netsh_winsock_help = @'
Displays a list of commands.
'@
netsh_winsock_remove = @'
Removes a Winsock LSP from the system.
'@
netsh_winsock_remove_provider = @'
Removes a Winsock LSP from the system.
'@
netsh_winsock_reset = @'
Resets the Winsock Catalog to a clean state.
'@
netsh_winsock_set = @'
Sets Winsock options.
'@
netsh_winsock_set_autotuning = @'
Sets Winsock options for the system.
'@
netsh_winsock_show = @'
Displays information.
'@
netsh_winsock_show_autotuning = @'
Displays whether Winsock send autotuning is enabled.
'@
netsh_winsock_show_catalog = @'
Displays contents of Winsock Catalog.
'@
netsh_wlan = @'
Changes to the `netsh wlan' context.
'@
netsh_wlan_add = @'
Adds a configuration entry to a table.
'@
netsh_wlan_add_filter = @'
Add a wireless network into the wireless allowed or
'@
netsh_wlan_add_profile = @'
Add a WLAN profile to specified interface on the system.
'@
netsh_wlan_connect = @'
Connects to a wireless network.
'@
netsh_wlan_delete = @'
Deletes a configuration entry from a table.
'@
netsh_wlan_delete_filter = @'
Remove a wireless network from the wireless allowed or
'@
netsh_wlan_delete_profile = @'
Delete a WLAN profile from one or multiple interfaces.
'@
netsh_wlan_disconnect = @'
Disconnects from a wireless network.
'@
netsh_wlan_dump = @'
Displays a configuration script.
'@
netsh_wlan_export = @'
Saves WLAN profiles to XML files.
'@
netsh_wlan_export_hostednetworkprofile = @'
Export the hosted network profile to XML file.
'@
netsh_wlan_export_profile = @'
Export specified profiles to XML files.
'@
netsh_wlan_help = @'
Displays a list of commands.
'@
netsh_wlan_refresh = @'
Refresh hosted network settings.
'@
netsh_wlan_refresh_hostednetwork = @'
Refresh hosted network settings.
'@
netsh_wlan_reportissues = @'
Generate WLAN smart trace report.
'@
netsh_wlan_set = @'
Sets configuration information.
'@
netsh_wlan_set_allowexplicitcreds = @'
Allow or disallow the user to use shared user 
'@
netsh_wlan_set_autoconfig = @'
Enable or disable auto configuration logic on interface.
'@
netsh_wlan_set_blockednetworks = @'
Show or hide the blocked networks in visible
'@
netsh_wlan_set_blockperiod = @'
Set the block period.
'@
netsh_wlan_set_createalluserprofile = @'
Allow or disallow everyone to create all user
'@
netsh_wlan_set_hostednetwork = @'
Set hosted network properties.
'@
netsh_wlan_set_profileorder = @'
Set the preference order of a wireless network profile.
'@
netsh_wlan_set_profileparameter = @'
Set parameters in a wireless network profile.
'@
netsh_wlan_set_profiletype = @'
Set profile type to alluser or peruser. 
'@
netsh_wlan_set_tracing = @'
Enable or disable tracing.
'@
netsh_wlan_show = @'
Displays information.
'@
netsh_wlan_show_all = @'
Shows complete wireless device and networks information.
'@
netsh_wlan_show_allowexplicitcreds = @'
Shows the allow shared user credentials settings.
'@
netsh_wlan_show_autoconfig = @'
Shows whether the auto configuration logic is enabled or
'@
netsh_wlan_show_blockednetworks = @'
Shows the blocked network display settings.
'@
netsh_wlan_show_createalluserprofile = @'
Shows whether everyone is allowed to create all
'@
netsh_wlan_show_drivers = @'
Shows properties of the wireless LAN drivers on the system.
'@
netsh_wlan_show_filters = @'
Shows the allowed and blocked network list.
'@
netsh_wlan_show_hostednetwork = @'
Show hosted network properties and status.
'@
netsh_wlan_show_interfaces = @'
Shows a list of the wireless LAN interfaces on
'@
netsh_wlan_show_networks = @'
Shows a list of networks visible on the system.
'@
netsh_wlan_show_onlyUseGPProfilesforAllowedNetworks = @'
Shows the only use GP profiles on GP configured networks setting.
'@
netsh_wlan_show_profiles = @'
Shows a list of profiles configured on the system.
'@
netsh_wlan_show_settings = @'
Shows the global settings of wireless LAN.
'@
netsh_wlan_show_tracing = @'
Shows whether wireless LAN tracing is enabled or disabled.
'@
netsh_wlan_start = @'
Start hosted network.
'@
netsh_wlan_start_hostednetwork = @'
Start hosted network.
'@
netsh_wlan_stop = @'
Stop hosted network.
'@
netsh_wlan_stop_hostednetwork = @'
Stop hosted network.
'@
}

