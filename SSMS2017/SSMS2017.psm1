Function Install-SSMS {
    [Cmdletbinding()] 
    Param (
        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [string]$SsmsPath
    )
    
    Start-Process $SsmsPath -Verb runAs -ArgumentList "/install /quiet /norestart"

}