
Remove-Module SQL2017
Import-Module .\SQL2017


Install-SQL2017 -SQLFilePath C:\Users\Simon\Downloads\ExpressAdv_ENU\SETUP.exe -installPath D:\SQL -configIniPath D:\git\SQL-install-script\SQL2017Media\ConfigurationFile.ini -installSharedDir 'C:\Users\Simon\Downloads\SQLtest' -SQLversion 'Basic' -instanceName 'SQLEXPRESS_888' -instanceID 'SQLEXPRESS_888' -features 'SQLENGINE','REPLICATION','ADVANCEDANALYTICS','SQL_INST_MR','SQL_INST_MPY','FULLTEXT','CONN','BC','SDK','LOCALDB','BROWSER','WRITER' -SQLauthentication -SQLpwd 'test'

#Start-Process C:\Users\Simon\Downloads\ExpressAdv_ENU\SETUP.exe -ArgumentList "/help=true"

#$output = Start-Process C:\Users\Simon\Downloads\ExpressAdv_ENU\SETUP.exe -ArgumentList "/ACTION=install /CONFIGURATIONFILE=D:\git\SQL-install-script\SQL2017Media\ConfigurationFile.ini /INSTANCENAME=SQLEXPRESS_888 /USEMICROSOFTUPDATE /IACCEPTSQLSERVERLICENSETERMS /IACCEPTPYTHONLICENSETERMS /IACCEPTROPENLICENSETERMS" -Verb runAs -PassThru
#$output
#/INSTALLPATH=$InstallPath