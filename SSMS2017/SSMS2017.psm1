<#
.SYNOPSIS
A function that installs SSMS onto the system.

.DESCRIPTION
This function takes the filepath for the executable file
and then runs it, providing exit code feedback.

.EXAMPLE
Install-SSMS -SsmsPath filepathHEre

.NOTES
Maintainer: Simon Bouchier
#>

Function Install-SSMS {
    [Cmdletbinding()] 
    Param (
        [Parameter(Mandatory=$True)]
        [ValidateScript({Test-Path -Path $_ -PathType Container -IsValid})]
        #the Filepath to the SSMS executable file.
        [String]$SsmsPath
    )
    
    $output = Start-Process $SsmsPath -Verb runAs -ArgumentList "/install /quiet /norestart"
    write-host $output.ExitCode
}