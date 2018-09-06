Function Install-SSMS {
    [Cmdletbinding()] 
    Param (
        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [string]$SsmsPath,

        #todo: use this param
        [Parameter(Mandatory=$True)]
        [ValidateSet('SQL', 'AS', 'RS', 'RS_SHP', 'RS_SHPWFE', 'DQC', 'IS', 'MDS', 'SQL_SHARED_MPY', 'SQL_SHARED_MR', 'Tools', 'SQLENGINE', 'REPLICATION', 'FULLTEXT', 'BC','SDK')]
        [string[]]$Features
    )
    $featureList
    foreach ($feature in $Features){
        $featureList = $featureList + $Features + ","
    }
    $featureList = $featureList.Substring(0,$featureList.Length-1)
    
    Start-Process $SsmsPath -Verb runAs -ArgumentList "/install /quiet /norestart #/features $featureList  /HELP"
}