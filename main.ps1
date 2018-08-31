
Remove-Module SQL2017

Import-Module .\SQL2017 

Install-SSMS -ssmsPath C:\Users\Simon\Downloads\SSMS-Setup-ENU.exe
#Install-SQL2017 -SQLFilePath C:\Users\Simon\Downloads\SQLTest\SQLServer2017-SSEI-Expr.exe -installPath D:\SQL -configIniPath D:\git\SQL-install-script\SQL2017Media\ConfigurationFile.ini -installSharedDir 'C:\Users\Simon\Downloads\SQLtest' -SQLversion 'Basic' -instanceName 'SQLEXPRESS_SI' -instanceID 'SQLEXPRESS_123' -features 'SQL','FULLTEXT','BC' -SQLauthentication -SQLpwd 'test'
#CheckInstallation -instanceName 'SQLEXPRESS_SI'

#$manifest = @{
#    Path              = '.\SQL2017\SQL2017.psd1'
#    RootModule        = 'SQL2017.psm1' 
#    Author            = 'Simon'
#}
#New-ModuleManifest @manifest