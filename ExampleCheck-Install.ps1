
Remove-Module SQL2017
Import-Module .\SQL2017

#Put whatever instance name you want to check as an argument. The search is wildcarded, so "EXP" would find SQLEXPRESS_SI.
Check-Install -instanceName 'SQLEXPRESS_SI'