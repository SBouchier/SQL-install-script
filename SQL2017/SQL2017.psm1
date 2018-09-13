<#
.SYNOPSIS
A function that will install SQL server 2017 using a
configFile.ini file to pass parameters through.

.DESCRIPTION
The user will provide all the inputs as arguments, which will
then be validated and fed through to a configFile.ini.
The config file will then be used by the installer to take the
user arguments and use them when setting up SQL 2017.

.EXAMPLE
Install-SQL2017 -SQLFilePath PathHere -InstallPath PathHere 
-ConfigIniPath PathHere -InstallSharedDir PathHere 
-InstanceName 'name' -InstanceID 'id' 
-Features 'SQLENGINE','REPLICATION' -SQLauthentication -SQLpwd 'pwd'

.NOTES
Maintainer: Simon Bouchier
#>

Function Install-SQL2017 {
    [Cmdletbinding()] 
    Param (
        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
        #The filepath to the SQL2017 installer executable
        [String]$SQLFilePath,

        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path -Path $_ -PathType Container -IsValid})]
        #the path to install SQL2017 in
        [String]$InstallPath,

        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path -Path $_ -PathType Leaf})]
        #the location of the configFile.ini file to use for setting up SQL2017
        [String]$ConfigIniPath,

        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path -Path $_ -PathType Container -IsValid})]
        #the directory that the shared SQL server resources will be downloaded into
        [String]$InstallSharedDir,

        [Parameter(Mandatory=$True)]
        #the name of the new SQL server instance
        [String]$InstanceName,

        [Parameter(Mandatory=$True)]
        #the ID of the new SQL server instance
        [String]$InstanceID,

        [Parameter(Mandatory=$True)]
        [ValidateSet('SQLENGINE','REPLICATION','ADVANCEDANALYTICS','SQL_INST_MR',
        'SQL_INST_MPY','FULLTEXT','CONN','BC','SDK','LOCALDB','BROWSER','WRITER')]
        #the features to add to the instance
        [String[]]$Features,

        [Parameter(Mandatory=$false)]
        #(Optional): called by the user if they wish to see if a service for the new instance has been started
        [Switch]$FindInstall,
        
        [Parameter(ParameterSetName='Auth', Mandatory=$false)]
        #if this switch is called, setup for SQL auth are added to the config file
        [Switch]$SQLAuthentication,
        [Parameter(ParameterSetName='Auth', Mandatory=$false)]
        #password for SQL authentication, used if the switch above is called.
        [String]$SQLPwd
    )

    #code to format the input of features into the correct style for input (CSV/no spaces)
    $featureList
    foreach ($feature in $Features){
        $featureList = $featureList + $feature + ","
    }
    $featureList = $featureList.Substring(0,$featureList.Length-1)
    Write-Host $featureList


    
    #code that handles the option for user to have either SQL auth and windows Auth, or just windows Auth.
    If ($SQLAuthentication){
        Set-OrAddIniValue -FilePath $ConfigIniPath -Key 'SECURITYMODE' -Value '"SQL"'
        Set-OrAddIniValue -FilePath $ConfigIniPath -Key 'SAPWD' -Value ('"'+$SQLpwd+'"')
        }
    Else{
        #if there's no SQL authentication switch given, set these to blank so they are not initialised.
        Set-OrAddIniValue -FilePath $ConfigIniPath -Key 'SECURITYMODE' -Value '""'
        Set-OrAddIniValue -FilePath $ConfigIniPath -Key 'SAPWD' -Value '""'
    }

    #code that is able to modify the ConfigFile.ini to contain the inputs.
    Set-OrAddIniValue -FilePath $ConfigIniPath -Key 'INSTANCENAME' -Value ('"'+$InstanceName+'"')
    Set-OrAddIniValue -FilePath $ConfigIniPath -Key 'SQLSVCACCOUNT' -Value ('"'+"NT Service\MSSQL$"+$InstanceName+'"')
    Set-OrAddIniValue -FilePath $ConfigIniPath -Key 'SQLTELSVCACCT' -Value ('"'+"NT Service\SQLTELEMETRY$"+$InstanceName+'"')
    Set-OrAddIniValue -FilePath $ConfigIniPath -Key 'INSTANCEID' -Value ('"'+$InstanceID+'"')
    Set-OrAddIniValue -FilePath $ConfigIniPath -key 'FEATURES' -Value $featureList
    Set-OrAddIniValue -FilePath $ConfigIniPath -Key 'INSTALLSHAREDDIR' -Value ('"'+$InstallSharedDir+'"')

    
    #2.0: uses a ConfigFile.ini to provide the arguments for SQL setup.
    $output = Start-Process $SQLFilePath -ArgumentList "/ACTION=Install /INSTANCENAME=$InstanceName /INSTANCEDIR=$InstallPath /CONFIGURATIONFILE=$ConfigIniPath /USEMICROSOFTUPDATE /IACCEPTROPENLICENSETERMS /IACCEPTSQLSERVERLICENSETERMS /IACCEPTPYTHONLICENSETERMS" -PassThru -Verb runAs
    $output.ExitCode

    if ($FindInstall){
        Find-Install($InstanceName)
    }
}

