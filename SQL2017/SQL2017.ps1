Function Install-SQL2017 {
    [Cmdletbinding()] 
    Param (
        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [string]$SQLFilePath,

        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path $_})]
        [string]$installPath,
        
        [ValidateSet('SQLauth', 'WindowsAuth', 'Both')]
        [Parameter(Mandatory=$True)]
        [string]$authenticationType,

        [Parameter(Mandatory=$True)]
        [ValidateSet('Basic', 'Custom', 'Download Media')]
        [string]$SQLversion,

        [Parameter(Mandatory=$True)]
        [ValidateSet('feature1', 'feature2', 'feature3')]
        [string]$SQLfeatures
    )

    & 'C:\Users\Simon\Downloads\ghostwolf\SQLServer2017-SSEI-Expr.exe'
}

#link to Documentation listing SQL cmdline install params:
#https://docs.microsoft.com/en-us/sql/database-engine/install-windows/install-sql-server-from-the-command-prompt?view=sql-server-2017

& 'C:\Users\Simon\Downloads\ghostwolf\SQLServer2017-SSEI-Expr.exe' /ACTION=Install /FEATURES=SQL /INSTANCENAME="Test" /AGTSVCACCOUNT "" /AGTSVCPASSWORD "" /ASSVCACCOUNT "" /ASSVCPASSWORD "" /ASSYSADMINACCOUNTS "" /SQLSVCACCOUNT "" /SQLSVCPASSWORD "" /SQLSYSADMINACCOUNTS "" /ISSVCACCOUNT "" /ISSVCPASSWORD "" /RSSVCACCOUNT "" /RSSVCPASSWORD ""
 
