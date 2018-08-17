Function Install-SQL2017 {
    [Cmdletbinding()] 
    Param (
        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [string]$SQLFilePath,

        #todo: if path does not exist, create it
        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [string]$installPath,

        [ValidateSet('SQLauth', 'WindowsAuth', 'Both')]
        [Parameter(Mandatory=$True)]
        [string]$authenticationType,

        #todo: use this param
        [Parameter(Mandatory=$True)]
        [ValidateSet('Basic', 'Custom', 'Download Media')]
        [string]$SQLversion,

        #todo: use this param
        [Parameter(Mandatory=$True)]
        [ValidateSet('SQL', 'AS', 'RS', 'RS_SHP', 'RS_SHPWFE', 'DQC', 'IS', 'MDS', 'SQL_SHARED_MPY', 'SQL_SHARED_MR', 'Tools')]
        [string[]]$SQLfeatures
    )

    $featureList
    foreach ($i in $SQLfeatures){
        $featureList = $featureList + $i + ","
        Write-Host $i
    }
    $featureList = $featureList.Substring(0,$featureList.Length-1)
    Write-Host $featureList

    & $SQLFilePath /q /v /ACTION=Install /INSTALLPATH=$installPath /IACCEPTSQLSERVERLICENSETERMS /LANGUAGE=en-US #/HELP=True
}

#link to Documentation listing SQL cmdline install params:
#https://docs.microsoft.com/en-us/sql/database-engine/install-windows/install-sql-server-from-the-command-prompt?view=sql-server-2017

Install-SQL2017 C:\Users\Simon\Downloads\SQLTest\SQLServer2017-SSEI-Expr.exe C:\Users\Simon\Downloads\SQLTest 'SQLauth' 'Basic' 'SQL','AS','DQC'

