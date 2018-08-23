Function Install-SQL2017 {
    [Cmdletbinding()] 
    Param (
        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [string]$SQLFilePath,

        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [string]$installPath,

        #todo: use this param
        [ValidateSet('WindowsAuth', 'Mixed')]
        [Parameter(Mandatory=$True)]
        [string]$authenticationType,

        #todo: use this + validate if it's a valid SQL version
        [Parameter(Mandatory=$True)]
        [string]$SQLversion,

        #todo: use this param
        [Parameter(Mandatory=$True)]
        [ValidateSet('SQL', 'AS', 'RS', 'RS_SHP', 'RS_SHPWFE', 'DQC', 'IS', 'MDS', 'SQL_SHARED_MPY', 'SQL_SHARED_MR', 'Tools', 'SQLENGINE')]
        [string[]]$SQLfeatures
    )

    #code to format the input of features into the correct style for input (CSV/no spaces)
    $featureList
    foreach ($i in $SQLfeatures){
        $featureList = $featureList + $i + ","
        Write-Host $i
    }
    $featureList = $featureList.Substring(0,$featureList.Length-1)
    Write-Host $featureList


    #cd "C:\Program Files\Microsoft SQL Server\140\Setup Bootstrap\SQL2017\x64"
    #.\LandingPage.exe /HELP=true
    

    #code that is able to modify the ConfigFile.ini to contain whatever inputs you wish before it's used below.
    Set-OrAddIniValue -FilePath ".\ConfigurationFile.ini"  -keyValueList @{
        INSTANCEID = '"SQLEXPRESS_AAA"'
        FEATURES=$featureList
        INSTALLSHAREDDIR='"C:\Users\Simon\Downloads\SQLtest"'
    }
  
    #2.0: uses the ConfigFile in the same directory as this .ps1 file
    & $SQLFilePath /v /ACTION=Install /INSTALLPATH=$installPath /LANGUAGE=en-US /CONFIGURATIONFILE="ConfigurationFile.ini" /IACCEPTROPENLICENSETERMS /IACCEPTSQLSERVERLICENSETERMS #/HELP=True
    
    #1.0: a version that does not use ConfigFile.ini and attempts to pass everything via params
    #& $SQLFilePath /ACTION=Install /INSTALLPATH=$installPath /FEATURES="SQLENGINE,REPLICATION,SQL_INST_MR,FULLTEXT,CONN,BC,SDK" /INSTANCENAME=SQLEXPRESSAAA /AGTSVCACCOUNT="NT AUTHORITY\NETWORK SERVICE" /AGTSVCSTARTUPTYPE="Disabled" /SQLSVCACCOUNT="NT Service\MSSQL$SQLEXPRESS" /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" /SECURITYMODE="SQL" /SAPWD="mypasswordhere" /IACCEPTSQLSERVERLICENSETERMS /IACCEPTROPENLICENSETERMS
   
}



#function that takes inputs and edits the .ini with them.
function Set-OrAddIniValue {
    Param(
        [string]$FilePath,
        [hashtable]$keyValueList
    )

    $content = Get-Content $FilePath

    $keyValueList.GetEnumerator() | ForEach-Object {
        if ($content -match "^$($_.Key)=") {
            $content= $content -replace "^$($_.Key)=(.*)", "$($_.Key)=$($_.Value)"
        }
        else {
            $content += "$($_.Key)=$($_.Value)"
        }
    }
    $content | Set-Content $FilePath
}



Install-SQL2017 C:\Users\Simon\Downloads\SQLTest\SQLServer2017-SSEI-Expr.exe D:\SQL 'Mixed' 'Basic' 'SQL','REPLICATION','FULLTEXT','BC','SDK'


#link to Documentation listing SQL cmdline install params:
#https://docs.microsoft.com/en-us/sql/database-engine/install-windows/install-sql-server-from-the-command-prompt?view=sql-server-2017
    
