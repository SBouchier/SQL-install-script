
Remove-Module SQL2017

Import-Module .\SQL2017


Install-SQL2017 -SQLFilePath C:\Users\Simon\Downloads\ExpressAdv_ENU\SETUP.exe -InstallPath D:\SQL -ConfigIniPath D:\git\SQL-install-script\SQL2017Media\ConfigurationFile.ini -InstallSharedDir 'C:\Users\Simon\Downloads\SQLtest' -SQLversion 'Basic' -InstanceName 'SQLEXPRESS_888' -InstanceID 'SQLEXPRESS_888' -Features 'SQLENGINE','REPLICATION','ADVANCEDANALYTICS','SQL_INST_MR','SQL_INST_MPY','FULLTEXT','CONN','BC','SDK','LOCALDB','BROWSER','WRITER' -SQLauthentication -SQLpwd 'test'
