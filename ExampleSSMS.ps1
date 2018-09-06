
Remove-Module SSMS2017

Import-Module .\SSMS2017

Install-SSMS -ssmsPath C:\Users\Simon\Downloads\SSMS-Setup-ENU.exe -features 'SQL', 'AS', 'RS', 'RS_SHP', 'RS_SHPWFE', 'DQC', 'IS', 'MDS', 'SQL_SHARED_MPY', 'SQL_SHARED_MR', 'Tools', 'SQLENGINE', 'REPLICATION', 'FULLTEXT', 'BC','SDK'