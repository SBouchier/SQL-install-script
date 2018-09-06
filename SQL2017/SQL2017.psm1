Function Install-SQL2017 {
    [Cmdletbinding()] 
    Param (
        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [ValidateScript({Test-Path -Path $_ -PathType Container -IsValid})]
        [string]$SQLFilePath,

        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [ValidateScript({Test-Path -Path $_ -PathType Container -IsValid})]
        [string]$InstallPath,

        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [ValidateScript({Test-Path -Path $_ -PathType Container -IsValid})]
        [string]$ConfigIniPath,

        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [ValidateScript({Test-Path -Path $_ -PathType Container -IsValid})]
        [string]$InstallSharedDir,

        #todo: use this + validate if it's a valid SQL version
        [Parameter(Mandatory=$True)]
        [string]$SQLVersion,

        [Parameter(Mandatory=$True)]
        [string]$InstanceName,

        [Parameter(Mandatory=$True)]
        [string]$InstanceID,

        [Parameter(Mandatory=$True)]
        [ValidateSet('SQL', 'BROWSER', 'WRITER', 'AS', 'RS', 'ADVANCEDANALYTICS', 'SQL_INST_MR', 'SQL_INST_MPY', 'CONN', 'LOCALDB', 'RS_SHP', 'RS_SHPWFE', 'DQC', 'IS', 'MDS', 'SQL_SHARED_MPY', 'SQL_SHARED_MR', 'Tools', 'SQLENGINE', 'REPLICATION', 'FULLTEXT', 'BC','SDK')]
        [string[]]$Features,

        #if this switch is called, user can give a password for the SQL auth if they want it
        [Parameter(ParameterSetName='Auth', Mandatory=$false)]
        [switch]$SQLAuthentication,
        [Parameter(ParameterSetName='Auth', Mandatory=$false)]
        [string]$SQLPwd
    )

    #code to format the input of features into the correct style for input (CSV/no spaces)
    $featureList
    foreach ($feature in $Features){
        $featureList = $featureList + $feature + ","
    }
    $featureList = $featureList.Substring(0,$featureList.Length-1)
    Write-Host $featureList


    
    #code that handles the option for user to have either SQL auth as well as windows Auth, or just windows Auth.
    If ($SQLAuthentication.IsPresent){
        Set-OrAddIniValue -FilePath $ConfigIniPath  -keyValueList @{
            SECURITYMODE='"SQL"'
            SAPWD='"'+$SQLpwd+'"'
        }
    }
    Else{
        Set-OrAddIniValue -FilePath $ConfigIniPath  -keyValueList @{
            SECURITYMODE=""
            SAPWD=""
        }
    }



    #code that is able to modify the ConfigFile.ini to contain whatever inputs you wish before it's used below.
    Set-OrAddIniValue -FilePath $ConfigIniPath  -keyValueList @{
        INSTANCENAME = '"'+$InstanceName+'"'
        SQLSVCACCOUNT = '"'+"NT Service\MSSQL$"+$InstanceName+'"'
        SQLTELSVCACCT='"'+"NT Service\SQLTELEMETRY$"+$InstanceName+'"'

        INSTANCEID = '"'+$InstanceID+'"'
        FEATURES=$featureList
        INSTALLSHAREDDIR= '"'+$InstallSharedDir+'"'
    }
  
    #2.0: uses the ConfigFile in the same directory as this .ps1 file
    #& $SQLFilePath /v /ACTION=Install /INSTALLPATH=$InstallPath /LANGUAGE=en-US /CONFIGURATIONFILE=$ConfigIniPath /IACCEPTROPENLICENSETERMS /IACCEPTSQLSERVERLICENSETERMS #/HELP=True
    $output = Start-Process $SQLFilePath -ArgumentList "/ACTION=Install /INSTANCENAME=$InstanceName /INSTANCEDIR=$InstallPath /CONFIGURATIONFILE=$ConfigIniPath /USEMICROSOFTUPDATE /IACCEPTROPENLICENSETERMS /IACCEPTSQLSERVERLICENSETERMS /IACCEPTPYTHONLICENSETERMS" -PassThru -Verb runAs

    $output
    
    #1.0: a version that does not use ConfigFile.ini and attempts to pass everything via params
    #& $SQLFilePath /ACTION=Install /INSTALLPATH=$installPath /FEATURES="SQLENGINE,REPLICATION,SQL_INST_MR,FULLTEXT,CONN,BC,SDK" /INSTANCENAME=SQLEXPRESSAAA /AGTSVCACCOUNT="NT AUTHORITY\NETWORK SERVICE" /AGTSVCSTARTUPTYPE="Disabled" /SQLSVCACCOUNT="NT Service\MSSQL$SQLEXPRESS" /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" /SECURITYMODE="SQL" /SAPWD="mypasswordhere" /IACCEPTSQLSERVERLICENSETERMS /IACCEPTROPENLICENSETERMS
}


#private function that takes inputs and edits the .ini with them.
Function Set-OrAddIniValue {
    Param(
        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [ValidateScript({Test-Path -Path $_ -PathType Container -IsValid})]
        [string]$FilePath,

        [Parameter(Mandatory=$True)]
        [hashtable]$KeyValueList
    )

    $content = Get-Content $FilePath

    $KeyValueList.GetEnumerator() | ForEach-Object {
        if ($content -match "^$($_.Key)=") {
            $content= $content -replace "^$($_.Key)=(.*)", "$($_.Key)=$($_.Value)"
        }
        else {
            $content += "$($_.Key)=$($_.Value)"
        }
    }
    $content | Set-Content $FilePath
}
